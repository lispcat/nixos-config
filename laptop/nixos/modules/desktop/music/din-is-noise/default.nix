{ lib
, stdenv
, fetchurl
, autoreconfHook
, pkg-config
, libGL
, libGLU
, SDL
, tcl
, alsa-lib
, libjack2
, withJack ? false # Uses alsa by default
}:

stdenv.mkDerivation rec {
  pname = "din-is-noise";
  version = "59";

  src = fetchurl {
    url = "https://dinisnoise.org/files/din-${version}.tar.gz";
    sha256 = "o5WiI2dRB5V6EpzZ8OpVZBBb6Jlv5C29zd84OhrJjJc=";
  };

  nativeBuildInputs = [
    autoreconfHook
    pkg-config
  ];

  buildInputs = [
    libGL
    libGLU
    SDL
    tcl
    alsa-lib
  ] ++ lib.optionals withJack [
    libjack2
  ];

  preConfigure = ''
    chmod +x configure
  '';

  configurePhase = if withJack then ''
    ./configure --prefix=$out \
      CXXFLAGS="-O3 -D__UNIX_JACK__" \
      CFLAGS="-O3" \
      LIBS="-ljack"
  '' else ''
    ./configure --prefix=$out \
      CXXFLAGS="-O3 -D__LINUX_ALSA__" \
      CFLAGS="-O3"
  '';

  meta = with lib; {
    description = "DIN Is Noise - A software musical instrument and audio synthesizer";
    longDescription = ''
      DIN Is Noise is a software musical instrument and audio synthesizer.
      It supports both ALSA and JACK audio backends for Linux systems.
      This package is built with ${if withJack then "JACK" else "ALSA"} support.
    '';
    homepage = "https://dinisnoise.org";
    license = licenses.gpl2;
    maintainers = with maintainers; [ me ]; # TODO
    platforms = platforms.linux;
    mainProgram = "din";
  };
}
