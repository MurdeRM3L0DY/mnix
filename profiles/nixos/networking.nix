{inputs, ...}: c: {...}: {
  # networking
  networking.networkmanager = {
    enable = true;
  };
}
