{
  description = "An Example nixos configuration";

  inputs = {
    #nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable"; # nixpkgs、Unstableバージョン
    nixpkgs.url = "github:nixos/nixpkgs/24.05"; # バージョン24.05

    # urlに設定する値の書きかたは以下を参照
    # https://nix.dev/manual/nix/2.18/command-ref/new-cli/nix3-flake.html#url-like-syntax
  };

  outputs = { nixpkgs, ... }: {
    # outputsには色々な属性(attributes)が入る。
    # - devShells
    # - packages
    # - apps
    # - checks
    # - formatter
    # - overlays
    # - nixosModules
    # - nixosConfigurations
    #
    # 今回はNixOSの設定を記述するため、"nixosConfigurations"を使用する。

    nixosConfigurations = {
      example-configs-pc = # この場合"example-configs-pc"が、コマンド上で指定する名前になる。
        nixpkgs.lib.nixosSystem {
          system = "x86_64-linux"; # インストールするPCのアーキテクチャと一致する様に記述。
          modules = [
            # システムの設定
            ./src/configuration.nix

            # ハードウェア関連の設定
            ./src/hardware-configuration.nix
          ];
        };
    };
  };
}
