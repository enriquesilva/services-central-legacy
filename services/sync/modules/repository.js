/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is Firefox Sync.
 *
 * The Initial Developer of the Original Code is
 * the Mozilla Foundation.
 * Portions created by the Initial Developer are Copyright (C) 2011
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *   Philipp von Weitershausen <philipp@weitershausen.de>
 *   Richard Newman <rnewman@mozilla.com>
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

const {classes: Cc, interfaces: Ci, utils: Cu, results: Cr} = Components;
Cu.import("resource://services-sync/resource.js");

const EXPORTED_SYMBOLS = ["Repository",
                          "ServerRepository",
                          "Crypto5Middleware"];

/**
 * Base repository
 */
function Repository() {}
Repository.prototype = {

  /**
   * Values to pass to and from callbacks.
   */
  DONE: {},
  STOP: {},

  /**
   * Retrieve a sequence of GUIDs corresponding to records that have been
   * modified since timestamp. The callback is invoked exactly once.
   *
   * @param timestamp
   *        Number of seconds since the epoch (can be a decimal number).
   * @param guidsCallback
   *        Callback function with the signature (error, guids_array).
   *        @param error is null for a successful operation.
   */
  guidsSince: function guidsSince(timestamp, guidsCallback) {
    throw "Repository must implement 'guidsSince'";
  },

  /**
   * Retrieve a sequence of records that have been modified since timestamp.
   * Invoke the callback once for each retrieved record and finally with
   * the DONE value.
   *
   * @param timestamp
   *        Number of seconds since the epoch (can be a decimal number).
   * @param fetchCallback
   *        Callback function with the signature (error, record).
   *        @param error is null for a successful operation.
   *        @param record will be the DONE value on the last invocation.
   *        @return STOP if the fetch operation should be aborted,
   */
  fetchSince: function fetchSince(timestamp, fetchCallback) {
    throw "Repository must implement 'fetchSince'";
  },

  /**
   * Retrieve a sequence of records by GUID. guids should be an iterable.
   * Invoke the callback once for each retrieved record and finally with
   * the DONE value.
   *
   * @param guids
   *        Array of GUIDs to retrieve.
   * @param fetchCallback
   *        Callback function with the signature (error, record).
   *        @param error is null for a succcessful operation.
   *        @param record will be the DONE value on the last invocation.
   *        @return STOP if the fetch operation should be aborted.
   */
  fetch: function fetch(guids, fetchCallback) {
    throw "Repository must implement 'fetch'";
  },

  /**
   * Store the given sequence of records. Invoke the callback for each failed
   * item and finally with the DONE value.
   *
   * @param recs
   *        Array of records.
   * @param storeCallback
   *        Callback with the signature (error)
   *        @param error describes an error. It may be an arbitrary exception
   *        object, a repository error where error.guid contains the GUID of
   *        the record that couldn't be stored, or the DONE value to indicate
   *        the operation has completed.
   *        @return STOP if the store operation should be aborted.
   */
  store: function store(recs, storeCallback) {
    throw "Repository must implement 'store'";
  }

};


/**
 * Implement the Sync 1.1 API
 */
function ServerRepository(uri) {
  Repository.call(this);
  this.uri = uri;
}
ServerRepository.prototype = {

  __proto__: Repository.prototype,

  downloadLimit: null,

  /**
   * Repository API
   */

  guidsSince: function guidsSince(timestamp, guidsCallback) {
    let resource = new AsyncResource(this.uri + "?newer=" + timestamp);
    resource.get(function (error, result) {
      if (error) {
        guidsCallback(error);
        return;
      }
      try {
        result = JSON.parse(result);
      } catch (ex) {
        //TODO
        guidsCallback(ex);
        return;
      }
      guidsCallback(null, result);
    });
  },

  fetchSince: function fetchSince(timestamp, fetchCallback) {
    let uri = this.uri + "?full=1&newer=" + timestamp;
    if (this.downloadLimit) {
      uri += "&limit=" + this.downloadLimit + "&sort=index";
    }
    this._fetchRecords(uri, fetchCallback);
  },

  fetch: function fetch(guids, fetchCallback) {
    let uri = this.uri + "full=1&ids=" + guids;
    this._fetchRecords(uri, fetchCallback);
  },

  store: function store(recs, storeCallback) {
    //TODO batching? or should this be done by the Synchronizer?
    // or a batching middleware?
    let resource = new AsyncResource(uri);
    resource.put(recs, function onPut(error, result) {
      //TODO process result, may contain errors about individual records
      storeCallback(error);
    });
  },

  /**
   * Private stuff
   */

  _fetchRecords: function(uri, fetchCallback) {
    let resource = new AsyncResource(uri);
    resource.setHeader("Accept", "application/newlines");

    //TODO XXX resource._data and resouce._onProgress are so retarded,
    // ('this' is the ChannelListener, not the resource!)
    // need a better streaming api for resource

    resource._onProgress = function onProgress() {
      let newline;
      while ((newline = this._data.indexOf("\n")) > 0) {
        let json = this._data.slice(0, newline);
        this._data = this._data.slice(newline + 1);
        let rv, record;
        try {
          record = JSON.parse(json);
        } catch(ex) {
          //TODO
          rv = fetchCallback(ex);
        }
        rv = fetchCallback(null, record);
        // TODO process rv, abort on STOP
      }
    };
    resource.get(function onGet(error, result) {
      fetchCallback(error, Repository.prototype.DONE);
    });
  }

};



/**
 * Wraps a server repository to implement storage version 5 crypto.
 *
 * Transforms a local record to a WBO.
 */
function Crypto5Middleware(repository) {
  Repository.call(this);
  this.repository = repository;
}
Crypto5Middleware = {

  __proto__: Repository.prototype,

  /**
   * Repository API
   */

  guidsSince: function guidsSince(timestamp, guidsCallback) {
    this.repository.guidsSince(timestamp, guidsCallback);
  },

  fetchSince: function fetchSince(timestamp, fetchCallback) {
    this.repository.fetchSince(timestamp, this.makeDecryptCb(fetchCallback));
  },

  fetch: function fetch(guids, fetchCallback) {
    this.repository.fetch(guids, this.makeDecryptCb(fetchCallback));
  },

  store: function store(recs, storeCallback) {
    for (let i = 0; i < recs.length; i++) {
      //XXX we're assuming we own the recs array here, avoids having to create
      // another array object.
      //TODO if encryption fails somehow, catch the error and call storeCallback
      // appropriately.
      recs[i] = this.encrypt(recs[i]);
    }
    this.repository.store(recs, storeCallback);
  },

  /**
   * Crypto + storage format stuff
   */

  makeDecryptCb: function makeDecryptCb(fetchCallback) {
    return (function decryptCallback(error, record) {
      if (!error && record != DONE) {
        //TODO if decryption fails somehow, catch the error and call
        // fetchCallback appropriately.
        record = this.decrypt(record);
      }
      return fetchCallback(error, record);
    }).bind(this);
  },

  //XXX TODO this doesn't handle errors and key refetches very well
  // idea: catch exceptions above and don't invoke callback until we have keys.
  encrypt: function encrypt(record, keyBundle) {
    keyBundle = keyBundle || CollectionKeys.keyForCollection(this.collection);
    if (!keyBundle)
      throw new Error("Key bundle is null for " + this.uri.spec);

    let iv = Svc.Crypto.generateRandomIV();
    let ciphertext = Svc.Crypto.encrypt(JSON.stringify(record),
                                        keyBundle.encryptionKey, iv);
    let payload = {IV: iv,
                   ciphertext: ciphertext,
                   hmac: this.ciphertextHMAC(ciphertext, keyBundle)};
    return {id: record.id,
            sortindex: record.sortindex,
            payload: JSON.stringify(payload)};
  },

  decrypt: function decrypt(record, keyBundle) {
  },

  ciphertextHMAC: function ciphertextHMAC(ciphertext, keyBundle) {
    let hasher = keyBundle.sha256HMACHasher;
    if (!hasher)
      throw "Cannot compute HMAC without an HMAC key.";

    return Utils.bytesAsHex(Utils.digestUTF8(ciphertext, hasher));
  },

};
