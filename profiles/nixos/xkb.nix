{inputs, ...}: c: {...}: {
  console.useXkbConfig = true;

  services.xserver = {
    enable = true;
    autoRepeatDelay = 160;
    autoRepeatInterval = 40;
    xkb = {
      layout = c.layout or "";
      options = c.options or "";
    };
  };
}
