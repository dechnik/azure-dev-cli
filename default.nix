{
  stdenv,
  lib,
  fetchurl,
  autoPatchelfHook,
  gh,
  bicep,
}:
stdenv.mkDerivation rec {
  pname = "azure-dev-cli";
  version = "1.10.2";

  src = fetchurl {
    url = "https://github.com/Azure/azure-dev/releases/download/azure-dev-cli_${version}/azd-linux-amd64.tar.gz";
    hash = "sha256-YxAZYK8FoulWCydodGNXnrDRraQR3J2dS7+pnGSK5+0=";
  };

  nativeBuildInputs = [ autoPatchelfHook ];

  buildInputs = [
    bicep
    gh
  ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall
    install -m755 -D azd-linux-amd64 $out/bin/azd
    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/Azure/azure-dev";
    description = "Azure Developer CLI";
    platforms = platforms.linux;
  };
}
