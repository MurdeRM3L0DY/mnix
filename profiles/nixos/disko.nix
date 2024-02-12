{inputs, ...}: c: {...}: {
  imports = [
    inputs.disko.nixosModules.disko
  ];

  disko.devices = c;
}
