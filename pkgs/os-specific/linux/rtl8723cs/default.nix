{ lib, stdenv, fetchFromGitHub, nukeReferences, kernel }:
with lib;
stdenv.mkDerivation rec {
  name = "rtl8723cs-${kernel.version}-${version}";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "yoshmiru";
    repo = "rtl8723cs";
    rev = "v${version}";
    sha256 = "0f61l16afpa3pr94644jlc8c57084d0b1pp1rwl5a8vjwq2rfsjg";
  };

  hardeningDisable = [ "pic" ];

  buildInputs = [ nukeReferences ];

  makeFlags = [
    "ARCH=${stdenv.hostPlatform.linuxArch}" # Normally not needed, but the Makefile sets ARCH in a broken way.
    "KSRC=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build" # Makefile uses $(uname -r); breaks us.
  ];

  enableParallelBuilding = true;

  # The Makefile doesn't use env-vars well, so install manually:
  installPhase = ''
    mkdir -p      $out/lib/modules/${kernel.modDirVersion}/kernel/drivers/net/wireless
    cp 8723cs.ko $out/lib/modules/${kernel.modDirVersion}/kernel/drivers/net/wireless

    nuke-refs $(find $out -name "*.ko")
  '';

  meta = {
    description = "Realtek SDIO Wi-Fi driver";
    homepage = "https://github.com/yoshmiru/rtl8723cs";
    license = lib.licenses.gpl2;
    platforms = lib.platforms.linux;
  };
}
