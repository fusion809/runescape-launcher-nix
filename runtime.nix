{ stdenv, fetchurl, dpkg }:

stdenv.mkDerivation rec {
  name = "runescape-launcher-${version}";
  version = "2.2.4";

  src = fetchurl {
    url = "https://content.runescape.com/downloads/ubuntu/pool/non-free/r/runescape-launcher/runescape-launcher_${version}_amd64.deb";
    sha256 = "d5c579b8727cc25f7b855235f1665a7c60a23f231da95c94e5f78cac9c42562f";
  };

  dontPatchELF = true;
  dontStrip = true;

  nativeBuildInputs = [ dpkg ];
  unpackCmd = "dpkg -x $curSrc .";

  installPhase = ''
    cp -r . $out
    substituteInPlace $out/bin/runescape-launcher --replace /usr/share $out/share
  '';

  meta = with stdenv.lib; {
    description = "Runescape NXT client";
    homepage = https://www.runescape.com;
    license = licenses.unfree;
    platforms = platforms.linux;
    maintainers = with maintainers; [ yegortimoshenko ];
  };
}
