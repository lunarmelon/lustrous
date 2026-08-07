{lib, config, ...}:
let
  inherit (lib.lists) optionals;
  inherit (lib.options) mkEnableOption;

  cfg = config.moon.system;
in
{
  options.moon.system = {
    boot.silent = mkEnableOption ''
      Almost entirely silent boot process through `quiet` kernel parameter
    '';
  };

  config.boot.kernelParams = [
    # nixOS produces many wakeups per second, which is bad for battery life
    # this kernel parameter disables the timer tick on the last 4 cores
    "nohz_full=4-7"

    # make stack-based attacks on the kernel harder
    "randomize_kstack_offset=on"

    # controls the behavior of vsyscalls. this has been defaulted to none back in 2016 - break really old binaries for security
    "vsyscall=none"

    # reduce most of the exposure of a heap attack to a single cache
    "slab_nomerge"

    # disable debugfs which exposes sensitive kernel data
    "debufs=off"

    # sometimes certain kernel exploits will cause what's called an "oops" which is a kernel panic
    # that is recoverable. this will make it unrecoverable and therefore safe to those attacks
    "oops=panic"

    # only allow signed modules
    "modules.sig_enforce=1"

    # block access to all kernel memory, even preventing administrators from being able to inspect and probe the kernel
    "lockdown=confidentiality"

    # enable buddy allocator free poisoning
    "page_poison=on"

    # performance improvement for direct mapped memory-side-cache utilization, reduces predictability of page allocations
    "page_alloc.shuffle=1"

    # for debugging kernel-level slab issues
    "slub_debug=FZP"

    # disable sysrq keys. sysrq is useful for debugging, but also insecure
    "sysrq_always_enabled=0"

    # ignore acces time (atime) update on files, except when they coincide with update to the ctime or mtime
    "rootflags=noatime"

    # linux security modules
    "lsm=landlock,lockdown,yama,integrity,apparmor,bpf,tomoyo,selinux"

    # prevent the kernel from blanking plymouth out of the fb
    "fbcon=nodefer"

    # https://en.wikipedia.org/wiki/Kernel_page-table_isolation
    # auto means kernel will automatically decide the pti state
    "pti_auto"

    # enable IOMMU for devices used in passthrough and provide better host performance
    "iommu=pt"

    # disable usb autosuspend
    "usbcore.autosuspend=-1"

    # disables resume and restores original swap space
    "noresume"

    # allow systemd to set and save the backlight state
    "acpi_backlight=native"

    # prevent the kernel from blanking plymouth out of the fb
    "fbcon=nodefer"

    # disable boot logo
    "logo.nologo"

    # disable the cursro in vt to get a black screen during intermissions
    "vt.global_cursor_default=0"
  ]
  ++ optionals cfg.boot.silent [
    # tell the kernel to not be verbose
    "quiet"

    # kernel log message level
    "loglevel=3"

    # udev log message level
    "udev.log_level=3"

    # lower the udev log level to show only errors or worse
    "rd.udev.log_level=3"

    # disable systemd status messages
    # rd prefix means systemd-udev will be used instead of initrd
    "systemd.show_status=auto"
    "rd.systemd.show_status=auto"
  ];
}