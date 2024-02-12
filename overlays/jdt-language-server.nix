{inputs, ...}: final: prev: {
  jdt-language-server = prev.jdt-language-server.overrideAttrs (fa: oa: {
    version = "1.26.0";
    timestamp = "202307072044";
    src = prev.fetchurl {
      url = "https://download.eclipse.org/jdtls/snapshots/jdt-language-server-${fa.version}-${fa.timestamp}.tar.gz";
      sha256 = "sha256-1XykNfn6sFmTgfP1gizPGyutUBABfnTBsRP0PyO204E=";
    };
  });
}
