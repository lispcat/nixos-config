{ lib
, stdenv
, fetchurl
, qt4
}:

stdenv.mkDerivation rec {
  pname = "rave-generator-2";
  version = "1.0";

  src = fetchurl {
    url = "https://blog.wavosaur.com/download/ravegenerator2/RaveGenerator2-Linux.tar.gz";
    sha256 = "Ig/B1i8oTXFvu7l9EJieZA2V/jOby/ge1ec1ayBfebk=";
  };
  sourceRoot = ".";

  buildInputs = [
    qt4
  ];

  installPhase = ''
    mkdir -p $out/lib/vst
    cp RaveGenerator2VST-x64.so $out/lib/vst/
  '';

  meta = with lib; {
    description = "RaveGenerator 2";
    longDescription = ''
      Second version of the famous RaveGenerator plugin.
      It natively runs on Linux.
    '';
    homepage = "https://blog.wavosaur.com/rave-generator-2-vst-audiounit-the-stab-machine-is-back-in-the-house/";
    license = licenses.unfree;
    maintainers = with maintainers; [ me ]; # TODO
    platforms = platforms.linux;
    # mainProgram = "";
  };
}
