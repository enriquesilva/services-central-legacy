/* -*- Mode: C++; tab-width: 8; indent-tabs-mode: nil; c-basic-offset: 2 -*-
 * vim: sw=2 ts=8 et :
 */
/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this file,
 * You can obtain one at http://mozilla.org/MPL/2.0/. */

#include "Hal.h"

namespace mozilla {
namespace hal_impl {

bool
SetLight(hal::LightType light, const hal::LightConfiguration& aConfig)
{
  return true;
}

bool
GetLight(hal::LightType light, hal::LightConfiguration* aConfig)
{
  aConfig->light() = light;
  // The rest of the fields are 0 by default, which is fine.
  return true;
}

} // namespace hal_impl
} // namespace mozilla
