{ config, pkgs, ... }:
let
  iinet = "wlo1";
  ivpn = "wg0";
	lan = "192.168.178.0/24";
	guestLan = "192.168.179.0/24";
in {
  networking.enableIPv6 = false;

	networking.nftables = {
		enable = true;
		ruleset = ''
    flush ruleset

    define VPN_PORTS = { 51820 }

    table ip6 filter_ip6 {
      chain INPUT {
        type filter hook input priority 0; policy drop;
      };
      chain FORWARD {
        type filter hook forward priority 0; policy drop;
      };
      chain OUTPUT {
        type filter hook output priority 0; policy drop;
      };
    }

    table ip killswitch {
      chain INPUT {
        type filter hook input priority 0; policy drop;

        iifname "lo" counter accept
        iifname ${iinet} ip daddr 224.0.0.0/24 counter accept
        iifname ${iinet} ip saddr 255.255.255.255 counter accept

        ct state related,established accept

        counter log prefix "NFT drop in: " drop
        # counter drop
      }

      chain FORWARD {
        type filter hook forward priority 0; policy drop;
        counter log prefix "NFT drop fwd: " drop
      }

      chain OUTPUT {
        type filter hook output priority 0; policy drop;

        oifname "lo" counter accept
        oifname ${iinet} udp dport $VPN_PORTS counter accept
        oifname ${ivpn} counter accept
        oifname ${iinet} ip daddr 224.0.0.0/24 counter accept
        oifname ${iinet} ip daddr 255.255.255.255 counter accept
        oifname ${iinet} ip daddr ${lan} counter accept
        oifname ${iinet} ip daddr ${guestLan} tcp dport 22222 counter accept

        ct state related,established accept

        counter log prefix "NFT drop out: " drop
        # counter drop
      }
    }
		'';
	};

  networking.wg-quick.interfaces = {
    wg0 = {
      autostart = true;
      address = [ "10.2.0.2/32" ];
      dns = [ "10.2.0.1" ];
      privateKeyFile = "/root/wireguard/pkey";

      peers = [
        {
          publicKey = "XcWEb0DMaFBex2HD2DVUStifh6wBZe9ELo2N/KLlMHc=";
          allowedIPs = [ "0.0.0.0/0" ];
          endpoint = "194.126.177.13:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
