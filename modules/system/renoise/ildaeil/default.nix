{ lib
, stdenv
, fetchurl
}:

stdenv.mkDerivation rec {
  pname = "ildaeil";
  version = "1.3";

  src = fetchurl {
    url = "https://github.com/DISTRHO/Ildaeil/releases/download/v1.3/Ildaeil-linux-aarch64-v{version}.zip";
    sha256 = "Ig/B1i8oTXFvu7l9EJieZA2V/jOby/ge1ec1ayBfebk=";
  };
  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out/lib/vst
    cp RaveGenerator2VST-x64.so $out/lib/vst/
  '';

  meta = with lib; {
    description = "Ildaeil";
    longDescription = ''
      Mini-plugin host as plugin
    '';
    homepage = "https://github.com/DISTRHO/Ildaeil";
    license = licenses.gpl2;
    maintainers = with maintainers; [ me ]; # TODO
    platforms = platforms.linux;
    # mainProgram = "";
  };
}
