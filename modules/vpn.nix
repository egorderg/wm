{ config, pkgs, ... }:
let
	primaryDns = "1.1.1.1";
	secondaryDns = "8.8.8.8";
	lan = "192.168.178.0";
in {
	networking.enableIPv6 = false;
	networking.nameservers = [ primaryDns secondaryDns ];

	networking.firewall = {
		enable = true;
		extraCommands = ''
		# Disallow traffic
		iptables -P INPUT DROP
		iptables -P FORWARD DROP
		iptables -P OUTPUT DROP

		# Disallow ipv6 traffic
		ip6tables -P INPUT DROP
		ip6tables -P FORWARD DROP
		ip6tables -P OUTPUT DROP

		# Loopback, Established and VPN
		iptables -A OUTPUT -o lo -j ACCEPT
		iptables -A INPUT -i lo -j ACCEPT
		iptables -A OUTPUT -o tun+ -j ACCEPT
		iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

		# Multicast
		iptables -A INPUT -s 224.0.0.0/24 -j ACCEPT
		iptables -A OUTPUT -d 224.0.0.0/24 -j ACCEPT

		# DHCP
		iptables -A INPUT -s 255.255.255.255 -j ACCEPT
		iptables -A OUTPUT -d 255.255.255.255 -j ACCEPT

		# LAN
		iptables -A INPUT -s ${lan}/24 -j ACCEPT
		iptables -A OUTPUT -d ${lan}/24 -j ACCEPT

		# DNS
		iptables -A OUTPUT -d ${primaryDns} -j ACCEPT
		iptables -A OUTPUT -d ${secondaryDns} -j ACCEPT

		# Allow VPN connection
		iptables -A OUTPUT -o wlo1 -p udp -m multiport --dports 80,1194,4569,5060,51820 -j ACCEPT

		# Logging
		#iptables -N logging
		#iptables -A INPUT -j logging
		#iptables -A OUTPUT -j logging
		#iptables -A logging -j LOG --log-prefix "IPTables: " --log-level 7
		#iptables -A logging -j DROP
		'';
	};

	services.openvpn.servers = {
		random = {
			config = '' config /root/nixos/openvpn/random.ovpn '';
			autoStart = true;
			updateResolvConf = true;
		};
	};
}
