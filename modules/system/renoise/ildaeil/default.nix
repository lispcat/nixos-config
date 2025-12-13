{ lib
, stdenv
, fetchurl
, unzip
}:

stdenv.mkDerivation rec {
  pname = "ildaeil";
  version = "1.3";

  src = fetchurl {
    url = "https://github.com/DISTRHO/Ildaeil/releases/download/v1.3/Ildaeil-linux-aarch64-v${version}.zip";
    sha256 = "neRRMQLenoBbUmVkh45yKELIqM8Cty/kRVeKKA4pUuc=";
  };
  nativeBuildInputs = [ unzip ];
  unpackPhase = ''
    unzip $src
  '';

  sourceRoot = ".";
  installPhase = ''
    mkdir -p $out/lib/vst
    mkdir -p $out/lib/lv2
    mkdir -p $out/lib/vst3/Ildaeil-FX
    mkdir -p $out/lib/vst3/Ildaeil-Synth

    cp -r Ildaeil-FX.lv2 $out/lib/lv2/
    cp -r Ildaeil-MIDI.lv2 $out/lib/lv2/
    cp -r Ildaeil-Synth.lv2 $out/lib/lv2/
    cp -r Ildaeil.vst $out/lib/vst/
    cp -r Ildaeil-FX.vst3/Contents/aarch64-linux/* $out/lib/vst3/Ildaeil-FX
    cp -r Ildaeil-Synth.vst3/Contents/aarch64-linux/* $out/lib/vst3/Ildaeil-Synth
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
