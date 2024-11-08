{ pkgs, ... }: {
    services.minecraft-servers = {
	enable = true;
	eula = true;

	servers = {
	    cool-server = {
		enable = true;
		package = pkgs.fabricServers.fabric-1_19_2;
		enableReload = true;
		serverProperties = {
		    motd = "This server runs on nixos";
		    gamemode = "survival";
		    difficulty = "hard";
		    max-players = 10;
		};
		symlinks = {
		    "mods" = "/home/sire_n1chaulas/Mods"; 
		};
	    };
	};
    };
}
