{ config, pkgs, ... }:

{
  users = {
    mutableUsers = false;
    users.root = {
      shell = pkgs.fish;
      hashedPassword = "$6$9IUNqyGsWrU$Pfhv8Smj6YURO60E8JRu96DbBhzvXMTcSV4sADJpLurOljurJf4H3DqpYTklBYeQxQxOE7n5DFmTPpqsiRczZ.";
    };
    users.jan = {
      shell = pkgs.fish;
      isNormalUser = true;
      home = "/home/jan";
      extraGroups = ["wheel" "networkmanager" "video" "audio" "libvirtd"];
      uid = 1000;
      hashedPassword = "$6$CBDCAMFsC$GnF91Mr6dee0qO6mxJwGwXIEfnixNP/d80KB38mf2mIz9c4HuoGwNY2i1UERhkdj.QwTgZy5CodMc3kMi.wCf/";
    };
  };
}
