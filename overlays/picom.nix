{inputs, ...}: final: prev: {
  picom = prev.picom.overrideAttrs (oa: {
    src = inputs.picom-ft-labs-src;
    nativeBuildInputs = oa.nativeBuildInputs ++ (with prev; [pcre2 xorg.xcbutil]);
  });
}
