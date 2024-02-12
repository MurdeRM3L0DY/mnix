{inputs, ...}: c: {...}: {
  # RealtimeKit
  security.rtkit.enable = true;

  # pipewire
  services.pipewire = {
    enable = true;
  };
  services.pipewire.wireplumber = {
    enable = true;
  };
  services.pipewire.alsa = {
    enable = true;
    support32Bit = true;
  };
  services.pipewire.pulse = {
    enable = true;
  };
}
