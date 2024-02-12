{inputs, ...}: c: {...}: {
  services.xserver = {
    enable = true;

    libinput = {
      enable = true;
      touchpad.tappingDragLock = false;
    };
  };
}
