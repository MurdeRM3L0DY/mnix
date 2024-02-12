{inputs, ...}: c: {...}: {
  # bluetooth
  hardware.bluetooth = {
    enable = true;
  };
  services.blueman = {
    enable = true;
  };
}
