{inputs, ...}: c: {...}: {
  # postgresql
  services.postgresql = {
    enable = true;
  };
}
