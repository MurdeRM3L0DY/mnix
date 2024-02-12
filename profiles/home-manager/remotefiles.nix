{
  inputs,
  modules,
  ...
}: name: c: {...}: {
  imports = [
    modules.remotefiles
  ];
  home.remotefiles."${name}" = c;
}
