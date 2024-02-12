{inputs, ...}: c: {pkgs, ...}: {
  # qemu
  virtualisation.libvirtd = {
    enable = true;
  };
  virtualisation.libvirtd.qemu = {
    ovmf = {
      enable = true;
      packages = [pkgs.OVMFFull.fd];
    };
    swtpm = {
      enable = true;
    };
  };
  virtualisation.spiceUSBRedirection = {
    enable = true;
  };
  services.spice-vdagentd = {
    enable = true;
  };
}
