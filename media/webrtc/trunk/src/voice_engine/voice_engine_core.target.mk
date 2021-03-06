# This file is generated by gyp; do not edit.

TOOLSET := target
TARGET := voice_engine_core
DEFS_Debug := '-D_FILE_OFFSET_BITS=64' \
	'-DCHROMIUM_BUILD' \
	'-DUSE_NSS=1' \
	'-DTOOLKIT_USES_GTK=1' \
	'-DGTK_DISABLE_SINGLE_INCLUDES=1' \
	'-DENABLE_REMOTING=1' \
	'-DENABLE_P2P_APIS=1' \
	'-DENABLE_CONFIGURATION_POLICY' \
	'-DENABLE_INPUT_SPEECH' \
	'-DENABLE_NOTIFICATIONS' \
	'-DENABLE_GPU=1' \
	'-DENABLE_EGLIMAGE=1' \
	'-DUSE_SKIA=1' \
	'-DENABLE_REGISTER_PROTOCOL_HANDLER=1' \
	'-DENABLE_WEB_INTENTS=1' \
	'-DENABLE_PLUGIN_INSTALLATION=1' \
	'-DWEBRTC_TARGET_PC' \
	'-DWEBRTC_LINUX' \
	'-DWEBRTC_THREAD_RR' \
	'-D__STDC_FORMAT_MACROS' \
	'-DDYNAMIC_ANNOTATIONS_ENABLED=1' \
	'-DWTF_USE_DYNAMIC_ANNOTATIONS=1' \
	'-D_DEBUG'

# Flags passed to all source files.
CFLAGS_Debug := -Werror \
	-pthread \
	-fno-exceptions \
	-fno-strict-aliasing \
	-Wall \
	-Wno-unused-parameter \
	-Wno-missing-field-initializers \
	-fvisibility=hidden \
	-pipe \
	-fPIC \
	-Wextra \
	-Wno-unused-parameter \
	-Wno-missing-field-initializers \
	-O0 \
	-g

# Flags passed to only C files.
CFLAGS_C_Debug := 

# Flags passed to only C++ files.
CFLAGS_CC_Debug := -fno-rtti \
	-fno-threadsafe-statics \
	-fvisibility-inlines-hidden \
	-Wsign-compare

INCS_Debug := -Isrc \
	-I. \
	-Isrc/voice_engine/main/interface \
	-Isrc/modules/audio_device/main/source \
	-Isrc/common_audio/resampler/include \
	-Isrc/common_audio/signal_processing/include \
	-Isrc/modules/audio_coding/main/interface \
	-Isrc/modules/interface \
	-Isrc/modules/audio_conference_mixer/interface \
	-Isrc \
	-Isrc/modules/audio_device/main/interface \
	-Isrc/modules/audio_processing/interface \
	-Isrc/modules/media_file/interface \
	-Isrc/modules/rtp_rtcp/interface \
	-Isrc/modules/udp_transport/interface \
	-Isrc/modules/utility/interface \
	-Isrc/system_wrappers/interface

DEFS_Release := '-D_FILE_OFFSET_BITS=64' \
	'-DCHROMIUM_BUILD' \
	'-DUSE_NSS=1' \
	'-DTOOLKIT_USES_GTK=1' \
	'-DGTK_DISABLE_SINGLE_INCLUDES=1' \
	'-DENABLE_REMOTING=1' \
	'-DENABLE_P2P_APIS=1' \
	'-DENABLE_CONFIGURATION_POLICY' \
	'-DENABLE_INPUT_SPEECH' \
	'-DENABLE_NOTIFICATIONS' \
	'-DENABLE_GPU=1' \
	'-DENABLE_EGLIMAGE=1' \
	'-DUSE_SKIA=1' \
	'-DENABLE_REGISTER_PROTOCOL_HANDLER=1' \
	'-DENABLE_WEB_INTENTS=1' \
	'-DENABLE_PLUGIN_INSTALLATION=1' \
	'-DWEBRTC_TARGET_PC' \
	'-DWEBRTC_LINUX' \
	'-DWEBRTC_THREAD_RR' \
	'-D__STDC_FORMAT_MACROS' \
	'-DNDEBUG' \
	'-DNVALGRIND' \
	'-DDYNAMIC_ANNOTATIONS_ENABLED=0'

# Flags passed to all source files.
CFLAGS_Release := -Werror \
	-pthread \
	-fno-exceptions \
	-fno-strict-aliasing \
	-Wall \
	-Wno-unused-parameter \
	-Wno-missing-field-initializers \
	-fvisibility=hidden \
	-pipe \
	-fPIC \
	-Wextra \
	-Wno-unused-parameter \
	-Wno-missing-field-initializers \
	-O2 \
	-fno-ident \
	-fdata-sections \
	-ffunction-sections

# Flags passed to only C files.
CFLAGS_C_Release := 

# Flags passed to only C++ files.
CFLAGS_CC_Release := -fno-rtti \
	-fno-threadsafe-statics \
	-fvisibility-inlines-hidden \
	-Wsign-compare

INCS_Release := -Isrc \
	-I. \
	-Isrc/voice_engine/main/interface \
	-Isrc/modules/audio_device/main/source \
	-Isrc/common_audio/resampler/include \
	-Isrc/common_audio/signal_processing/include \
	-Isrc/modules/audio_coding/main/interface \
	-Isrc/modules/interface \
	-Isrc/modules/audio_conference_mixer/interface \
	-Isrc \
	-Isrc/modules/audio_device/main/interface \
	-Isrc/modules/audio_processing/interface \
	-Isrc/modules/media_file/interface \
	-Isrc/modules/rtp_rtcp/interface \
	-Isrc/modules/udp_transport/interface \
	-Isrc/modules/utility/interface \
	-Isrc/system_wrappers/interface

OBJS := $(obj).target/$(TARGET)/src/voice_engine/main/source/audio_frame_operations.o \
	$(obj).target/$(TARGET)/src/voice_engine/main/source/channel.o \
	$(obj).target/$(TARGET)/src/voice_engine/main/source/channel_manager.o \
	$(obj).target/$(TARGET)/src/voice_engine/main/source/channel_manager_base.o \
	$(obj).target/$(TARGET)/src/voice_engine/main/source/dtmf_inband.o \
	$(obj).target/$(TARGET)/src/voice_engine/main/source/dtmf_inband_queue.o \
	$(obj).target/$(TARGET)/src/voice_engine/main/source/level_indicator.o \
	$(obj).target/$(TARGET)/src/voice_engine/main/source/monitor_module.o \
	$(obj).target/$(TARGET)/src/voice_engine/main/source/output_mixer.o \
	$(obj).target/$(TARGET)/src/voice_engine/main/source/ref_count.o \
	$(obj).target/$(TARGET)/src/voice_engine/main/source/shared_data.o \
	$(obj).target/$(TARGET)/src/voice_engine/main/source/statistics.o \
	$(obj).target/$(TARGET)/src/voice_engine/main/source/transmit_mixer.o \
	$(obj).target/$(TARGET)/src/voice_engine/main/source/utility.o \
	$(obj).target/$(TARGET)/src/voice_engine/main/source/voe_audio_processing_impl.o \
	$(obj).target/$(TARGET)/src/voice_engine/main/source/voe_base_impl.o \
	$(obj).target/$(TARGET)/src/voice_engine/main/source/voe_call_report_impl.o \
	$(obj).target/$(TARGET)/src/voice_engine/main/source/voe_codec_impl.o \
	$(obj).target/$(TARGET)/src/voice_engine/main/source/voe_dtmf_impl.o \
	$(obj).target/$(TARGET)/src/voice_engine/main/source/voe_encryption_impl.o \
	$(obj).target/$(TARGET)/src/voice_engine/main/source/voe_external_media_impl.o \
	$(obj).target/$(TARGET)/src/voice_engine/main/source/voe_file_impl.o \
	$(obj).target/$(TARGET)/src/voice_engine/main/source/voe_hardware_impl.o \
	$(obj).target/$(TARGET)/src/voice_engine/main/source/voe_neteq_stats_impl.o \
	$(obj).target/$(TARGET)/src/voice_engine/main/source/voe_network_impl.o \
	$(obj).target/$(TARGET)/src/voice_engine/main/source/voe_rtp_rtcp_impl.o \
	$(obj).target/$(TARGET)/src/voice_engine/main/source/voe_video_sync_impl.o \
	$(obj).target/$(TARGET)/src/voice_engine/main/source/voe_volume_control_impl.o \
	$(obj).target/$(TARGET)/src/voice_engine/main/source/voice_engine_impl.o

# Add to the list of files we specially track dependencies for.
all_deps += $(OBJS)

# CFLAGS et al overrides must be target-local.
# See "Target-specific Variable Values" in the GNU Make manual.
$(OBJS): TOOLSET := $(TOOLSET)
$(OBJS): GYP_CFLAGS := $(DEFS_$(BUILDTYPE)) $(INCS_$(BUILDTYPE))  $(CFLAGS_$(BUILDTYPE)) $(CFLAGS_C_$(BUILDTYPE))
$(OBJS): GYP_CXXFLAGS := $(DEFS_$(BUILDTYPE)) $(INCS_$(BUILDTYPE))  $(CFLAGS_$(BUILDTYPE)) $(CFLAGS_CC_$(BUILDTYPE))

# Suffix rules, putting all outputs into $(obj).

$(obj).$(TOOLSET)/$(TARGET)/%.o: $(srcdir)/%.cc FORCE_DO_CMD
	@$(call do_cmd,cxx,1)

# Try building from generated source, too.

$(obj).$(TOOLSET)/$(TARGET)/%.o: $(obj).$(TOOLSET)/%.cc FORCE_DO_CMD
	@$(call do_cmd,cxx,1)

$(obj).$(TOOLSET)/$(TARGET)/%.o: $(obj)/%.cc FORCE_DO_CMD
	@$(call do_cmd,cxx,1)

# End of this set of suffix rules
### Rules for final target.
LDFLAGS_Debug := -pthread \
	-Wl,-z,noexecstack \
	-fPIC \
	-B$(builddir)/../../third_party/gold

LDFLAGS_Release := -pthread \
	-Wl,-z,noexecstack \
	-fPIC \
	-B$(builddir)/../../third_party/gold \
	-Wl,-O1 \
	-Wl,--as-needed \
	-Wl,--gc-sections

LIBS := 

$(obj).target/src/voice_engine/libvoice_engine_core.a: GYP_LDFLAGS := $(LDFLAGS_$(BUILDTYPE))
$(obj).target/src/voice_engine/libvoice_engine_core.a: LIBS := $(LIBS)
$(obj).target/src/voice_engine/libvoice_engine_core.a: TOOLSET := $(TOOLSET)
$(obj).target/src/voice_engine/libvoice_engine_core.a: $(OBJS) FORCE_DO_CMD
	$(call do_cmd,alink)

all_deps += $(obj).target/src/voice_engine/libvoice_engine_core.a
# Add target alias
.PHONY: voice_engine_core
voice_engine_core: $(obj).target/src/voice_engine/libvoice_engine_core.a

# Add target alias to "all" target.
.PHONY: all
all: voice_engine_core

