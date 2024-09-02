{
  stdenv,
  lib,
  fetchurl,
  autoPatchelfHook,
  zlib,
}:
stdenv.mkDerivation rec {
  pname = "bicep-cli";
  version = "0.29.47";

  src = fetchurl {
    url = "https://github.com/Azure/bicep/releases/download/v${version}/bicep-linux-x64";
    hash = "sha256-lg1jbNmcpYckVl8xQbseCYO1i2uqShAYsHyvBkSKs8M=";
  };

  nativeBuildInputs = [ autoPatchelfHook ];

  dontUnpack = true;

  sourceRoot = ".";

  buildInputs = [
    stdenv.cc.cc.lib
    zlib
  ];

  installPhase = ''
    runHook preInstall
    install -m755 -D $src $out/bin/bicep
    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/Azure/bicep";
    description = "Bicep CLI";
    platforms = platforms.linux;
  };
}
