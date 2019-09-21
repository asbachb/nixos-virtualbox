{ config, pkgs, ... }:

{
  imports = [ <nixpkgs/nixos/modules/installer/virtualbox-demo.nix> ];

  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];

  environment.systemPackages = with pkgs; [
    wget git
  ];

  environment.etc."gitconfig".text = ''
    [user]
      name = Benjamin Asbach
      email = asbachb@users.noreply.github.com
  '';

  services.xserver.layout = "de";

  virtualisation.lxc = {
    enable = true;
    lxcfs.enable = true;
    defaultConfig = "lxc.include = ${pkgs.lxcfs}/share/lxc/config/common.conf.d/00-lxcfs.conf";
  };

  virtualisation.lxd.enable = true;

  users.users.demo = {
    extraGroups = [ "wheel" "lxd" ];
  };
}
