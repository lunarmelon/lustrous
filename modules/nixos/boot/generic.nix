{lib, config, ...}: 
let 
  inherit (lib.modules)
    mkMerge
    mkIf
    mkForce
    mkDefault
    ;

  inherit (lib.options) mkEnableOption;

  cfg = config.moon.system.boot;
in
{
  options.moon.system.boot = {
    initrd = {
      optimizeCompressor = mkEnableOption ''
          initrd compression algorithm optimizations for size.
          Enabling this option will force initrd to use zstd (default) with
          level 19 and -T0 (STDIN). This will reduce thee initrd size greatly
          at the cost of compression speed.
          Not recommended for low-end hardware.
      '';
    };
  };

  config.boot = {
    consoleLogLevel = 3;

    extraModprobeConfig = mkDefault "options fnmode=1";

    loader = {
      # if set to 0, space needs to be held to get the boot menu to appear
      timeout = mkForce 2;

      # copy boot files to /boot so that /nix/store is not required to boot
      generationsDir.copyKernels = true;

      efi.canTouchEfiVariables = true;
    };

    # initrd and kernel tweaks
    initrd = mkMerge [
      ({
        verbose = false;

        kernelModules = [
          "nvme"
          "xhci_pci"
          "ahci"
          "btrfs"
          "sd_mod"
          "sd_mod"
        ];

        availableKernelModules = [
          "vmd"
          "usbhid"
          "sd_mod"
          "sr_mod"
          "dm_mod"
          "uas"
          "usb_storage"
          "rtsx_usb_sdmmc"
          "rtsx_pci_sdmmc"
          "ata_piix"
          "virtio_pci"
          "virtio_scsi"
          "ehci_pci"
        ];
      })

      (mkIf cfg.initrd.optimizeCompressor {
        compressor = "zstd";
        compressorArgs = [
          "-19"
          "-T0"
        ];
      })
    ];
  };
}