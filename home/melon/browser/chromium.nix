{
  config,
  lib,
  pkgs,
  ...
}: 
let
  inherit (lib) mkEnableOption;
  inherit (lib.lists) concatLists head;
  inherit (lib.versions) splitVersion;
  inherit (lib.strings) concatMapStrings enableFeature getVersion;

  features = en: features: "--${en}-features=" + (concatMapStrings (x: x + ",") features);

  extension =
    {
      id,
      version,
      hash,
    }:
    {
      inherit id version;
      crxPath = pkgs.fetchurl {
        name = "${id}.crx";
        url = "https://clients2.google.com/service/update2/crx?response=redirect&acceptformat=crx2,crx3&prodversion=${head (splitVersion (getVersion config.programs.chromium.package))}&x=id%3D${id}%26installsource%3Dondemand%26uc";
        inherit hash;
      };
    };

  cfg = config.moon.programs.chromium;
in
{
  options.moon.programs.chromium.enable = mkEnableOption "Enable chromium browser";

  config = {
    programs.chromium = {
      inherit (cfg) enable;

    extensions = map extension [
      # uBlock Origin
      {
        id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
        version = "1.72.2";
        hash = "sha256-am9BiDyrsTDQCNXazBGIKEkMJwE3ZbNRiSR+i+oXg5E=";
      }
    ];

      nativeMessagingHosts = [ pkgs.ff2mpv-rust ];

      package = pkgs.ungoogled-chromium.override {
        enableWideVine = true;

        commandLineArgs = concatLists [
          # aesthetics
          [
            "--gtk-version=4"
          ]

          # Performance
          [
            (enableFeature true "gpu-rasterization")
            (enableFeature true "oop-rasterization")
            (enableFeature true "zero-copy")

            # share a process per site
            "--process-per-site"

            # allow parallel downloads
            (enableFeature true "parallel-downloading")

            # vaapi info: https://chromium.googlesource.com/chromium/src/+/refs/heads/main/docs/gpu/vaapi.md
            "--ignore-gpu-blocklist"
            "--disable-gpu-driver-bug-workaround"
          ]

          # Wayland
          [ "--ozone-platform=wayland" ]

          # Etc
          [
            "--disk-cache=$XDG_RUNTIME_DIR/chromium-cache"

            "--no-first-run"
            "--disable-wake-on-wifi"
            "--disable-breakpad"

            # please stop asking me to be the default browser
            "--no-default-browser-check"

            # hdr some others too
            (enableFeature true "experimental-web-platform-features")

            # I don't need these, thus I disable them
            (enableFeature false "speech-api")
            (enableFeature false "speech-synthesis-api")
          ]

          # Security
          [
            # Disable pings
            "--no-pings"

            # Require HTTPS for component updater
            "--component-updater=require_encryption"

            # Disable crash upload
            "--no-crash-upload"

            # don't run things without asking
            "--no-service-autorun"

            # Disable sync
            "--disable-sync"

            # disable canvas reading for privacy
            # (enableFeature false "reading-from-canvas")

            "--password-store=gnome-libsecret"
          ]


          [
            (features "enable" [
              # needed for wayland
              "UseOzonePlatform"

              "MiddleClickAutoscroll"

              # allow manifest v2
              "AllowLegacyMV2Extensions"

              # see the performance section as to why these are added
              "AcceleratedVideoEncoder"
              "AcceleratedVideoDecodeLinuxGL"
              "VaapiOnNvidiaGPUs"
              "WaylandLinuxDrmSyncobj"

              # Enable visited link database partitioning
              "PartitionVisitedLinkDatabase"

              # Enable prefetch privacy changes
              "PrefetchPrivacyChanges"

              # Enable split cache
              "SplitCacheByNetworkIsolationKey"
              "SplitCodeCacheByNetworkIsolationKey"

              # Enable partitioning connections
              "EnableCrossSiteFlagNetworkIsolationKey"
              "HttpCacheKeyingExperimentControlGroup"
              "PartitionConnectionsByNetworkIsolationKey"

              # Enable strict origin isolation
              "StrictOriginIsolation"

              # Enable reduce accept language header
              "ReduceAcceptLanguage"

              # Enable content settings partitioning
              "ContentSettingsPartitioning"
            ])

            (features "disable" [
              # Disable autofill
              "AutofillPaymentCardBenefits"
              "AutofillPaymentCvcStorage"
              "AutofillPaymentCardBenefits"

              # Disable third-party cookie deprecation bypasses
              "TpcdHeuristicsGrants"
              "TpcdMetadataGrants"

              # Disable hyperlink auditing
              "EnableHyperlinkAuditing"

              # Disable showing popular sites
              "NTPPopularSitesBakedInContent"
              "UsePopularSitesSuggestions"

              # Disable article suggestions
              "EnableSnippets"
              "ArticlesListVisible"
              "EnableSnippetsByDse"

              # Disable content feed suggestions
              "InterestFeedV2"

              # Disable media DRM preprovisioning
              "MediaDrmPreprovisioning"

              # Disable autofill server communication
              "AutofillServerCommunication"

              # Disable new privacy sandbox features
              "PrivacySandboxSettings4"
              "BrowsingTopics"
              "BrowsingTopicsDocumentAPI"
              "BrowsingTopicsParameters"

              # Disable translate button
              "AdaptiveButtonInTopToolbarTranslate"

              # Disable detailed language settings
              "DetailedLanguageSettings"

              # Disable fetching optimization guides
              "OptimizationHintsFetching"

              # Partition third-party storage
              "DisableThirdPartyStoragePartitioningDeprecationTrial2"

              # Disable media engagement
              "PreloadMediaEngagementData"
              "MediaEngagementBypassAutoplayPolicies"

              # allow manifest v2
              "ExtensionsManifestV3Only"
              "ExtensionManifestV2Unsupported"
              "ExtensionManifestV2Disabled"
            ])
          ]
        ];
      };
    };
  };
}
