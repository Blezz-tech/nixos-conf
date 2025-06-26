{ stdenv
, fetchFromGitHub
, lib

, zdy_version
, zdy_hash
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "zapret-discord-youtube";
  version = zdy_version;

  src = fetchFromGitHub {
    owner = "Flowseal";
    repo = "zapret-discord-youtube";
    rev = finalAttrs.version;
    sha256 = zdy_hash;
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out/
    cp -r $src/* $out
    runHook postInstall
  '';

  meta = {
    description = "Configs for zapret for Discord and YouTube";
    homepage = "https://github.com/Flowseal/zapret-discord-youtube";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
    # maintainers = with maintainers; [ ]; # Add maintainers if applicable
  };
})
