interface={{ iface_local }}
domain={{ dnsdomain }}

# DHCP Address Pool
dhcp-range= {{ iface_local }},{{ dhcp_range_bottom }},{{ dhcp_range_top }},{{ dhcp_range_mask }},{{ dhcp_lease_duration }}

# DHCP Options
# 3   = gateway address
# 6   = nameserver address
# 28  = broadcast address
# 42  = NTP server address
dhcp-option=3,{{ gateway_address }}
dhcp-option=6,{{ nameserver_address }},{{ nameserver2_address }}
dhcp-option=28,{{ broadcast_address }}
#dhcp-option=42,{{ ntpserver_address }}
dhcp-option=66,{{ pxeserver_address }}

# PXE Configuration
dhcp-boot=pxelinux/pxelinux.0,pxeserver

# Example Static IP address reservations
#dhcp-host=08:00:27:00:00:a1,workstation,192.168.5.100
