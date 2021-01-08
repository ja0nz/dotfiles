{ appimageTools, lib }:

let
  pname = "sizzy";
  version = "47.0.0";
  name = "${pname}-${version}";
  src = ./. + "/Sizzy-${version}.AppImage";
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
    description = "The browser for Developers & Designers";
    homepage = "https://www.sizzy.co/";
    #license = with licenses; [ unfree ];
    #maintainers = with maintainers; [ ja0nz ];
    platforms = [ "x86_64-linux" ];
  };
}
