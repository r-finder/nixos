{ config, pkgs, lib, ... }:
let
  # obsidian = pkgs.callPackage ../../packages/obsidian.nix 
  # {
  #     version = "1.4.13";
  #     sha256 = "253b28a1b38803ce3e8f7dd80c02d211233c3cc63e83e35bbf66446ac64763d9";
  # };

  obssync = pkgs.writeTextFile {
    name = "obssync";
    destination = "/bin/obssync";
    executable = true;
    text = ''
        pushd .
        cd ~/obsidian
        git pull
        git status
        git add .
        git commit -m 'auto'
        git push
        popd
    '';
  };
in
{
  environment.systemPackages = with pkgs; [
    obssync
    obsidian
  ];
}
