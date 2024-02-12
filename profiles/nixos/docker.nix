{inputs, ...}: c: {...}: {
  # docker
  virtualisation.docker = {
    enable = true;
    storageDriver = c.storageDriver;
  };
}
