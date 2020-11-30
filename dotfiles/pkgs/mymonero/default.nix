{ appimageTools, lib }:

let
  pname = "mymonero";
  version = "1.1.18";
  name = "${pname}-${version}";
  src = ./. + "/MyMonero-${version}.AppImage";
  appimageContents = appimageTools.extractType2 { inherit name src; };
in
appimageTools.wrapType2 {
  inherit name src;
  extraInstallCommands = ''
    mv $out/bin/${name} $out/bin/${pname}
    install -m 444 -D \
      ${appimageContents}/${pname}.desktop \
      $out/share/applications/${pname}.desktop
      substituteInPlace $out/share/applications/${pname}.desktop \
      --replace 'Exec=AppRun' 'Exec=${pname}'
    cp -r ${appimageContents}/usr/share/icons $out/share
  '';
  meta = with lib; {
    description = "MyMonero Desktop Wallet";
    homepage = "https://mymonero.com/";
    #license = with licenses; [ unfree ];
    #maintainers = with maintainers; [ ja0nz ];
    platforms = [ "x86_64-linux" ];
  };
}
