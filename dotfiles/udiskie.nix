{ config, ... }:

let
  inherit (config) dots;
in
{
  services.udiskie = {
    enable = true;
  };
  home.file.".config/udiskie/config.yml".text = ''
    device_config:
      - id_uuid: b3ec2286-cc94-4540-b5bc-3446fabb2242
      - keyfile: ./killswitch_random_keyfile
  '';
  home.file.".config/udiskie/killswitch_random_keyfile".source = "${dots}/protected/killswitch_random_keyfile";
}
