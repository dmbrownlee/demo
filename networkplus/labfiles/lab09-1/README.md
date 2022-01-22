# Sorry, this lab is still under construction

![Image of construction sign](../ConstructionSign.png)

# Name Resolution
Network nodes communicate with each other across networks using IP addresses.  However, IP addresses are hard for people to remember so we refer to hosts and websites by name.  Before a client can connect to a server, it needs to translate the hostname to an IP address.

## OBJECTIVE
In this lab, we will learn to use tools to investigate how name resolution is happening.

## SETUP

This lab uses the same virtual lab environment as the other labs.  Make sure you have opened this project and run the `setup` script on the control node as described [here](https://github.com/dmbrownlee/demo/blob/release/networkplus/labfiles/README.md).

We will be using the debian1-1 VM in this lab.  The first part of the lab will use a utility called `strace` to watch how network clients request networking services from the host operating system and you will want to make sure it is installed if if isn't already.  On the debian1-1 VM, run:
```
sudo apt install -y strace
```

## STEPS
### Capturing name resolution traffic
Before getting started, shutdown the debian VMs if they are running. Start a network capture on debian1-1's link and set the filter to `dns or mdns or llmnr or nbns`. This will allow us to capture name resolution traffic generated when these VMs start.

1. Boot debian1-1 VM and login.  Observe the DNS traffic as the host checks for updates.
   ```
   No.  Time  Source  Destination Protocol  Length  Info
   13 3.858238  fe80::a00:27ff:fe1f:a3a4  ff02::fb  MDNS  201 Standard query response 0x0000 PTR, cache flush debian1.local AAAA, cache flush fe80::a00:27ff:fe1f:a3a4
   21 5.119118  192.168.45.149  224.0.0.251 MDNS  252 Standard query 0x0000 ANY 4.a.3.a.f.1.e.f.f.f.7.2.0.0.a.0.0.0.0.0.0.0.0.0.0.0.0.0.0.8.e.f.ip6.arpa, "QM" question ANY debian1.local, "QM" question ANY 149.45.168.192.in-addr.arpa, "QM" question A 192.168.45.149 PTR debian1.local AAAA fe80::a00:27ff:fe1f:a3a4 PTR debian1.local
   22 5.371212  192.168.45.149  224.0.0.251 MDNS  252 Standard query 0x0000 ANY 4.a.3.a.f.1.e.f.f.f.7.2.0.0.a.0.0.0.0.0.0.0.0.0.0.0.0.0.0.8.e.f.ip6.arpa, "QM" question ANY debian1.local, "QM" question ANY 149.45.168.192.in-addr.arpa, "QM" question A 192.168.45.149 PTR debian1.local AAAA fe80::a00:27ff:fe1f:a3a4 PTR debian1.local
   23 5.620446  192.168.45.149  224.0.0.251 MDNS  252 Standard query 0x0000 ANY 4.a.3.a.f.1.e.f.f.f.7.2.0.0.a.0.0.0.0.0.0.0.0.0.0.0.0.0.0.8.e.f.ip6.arpa, "QM" question ANY debian1.local, "QM" question ANY 149.45.168.192.in-addr.arpa, "QM" question A 192.168.45.149 PTR debian1.local AAAA fe80::a00:27ff:fe1f:a3a4 PTR debian1.local
   24 5.820701  192.168.45.149  224.0.0.251 MDNS  234 Standard query response 0x0000 PTR, cache flush debian1.local A, cache flush 192.168.45.149 PTR, cache flush debian1.local AAAA, cache flush fe80::a00:27ff:fe1f:a3a4
   27 6.859602  192.168.45.149  224.0.0.251 MDNS  234 Standard query response 0x0000 PTR, cache flush debian1.local A, cache flush 192.168.45.149 PTR, cache flush debian1.local AAAA, cache flush fe80::a00:27ff:fe1f:a3a4
   28 8.546097  fe80::a00:27ff:fe1f:a3a4  ff02::fb  MDNS  101 Standard query 0x0000 PTR _nmea-0183._tcp.local, "QM" question
   29 8.546165  192.168.45.149  224.0.0.251 MDNS  81  Standard query 0x0000 PTR _nmea-0183._tcp.local, "QM" question
   30 8.900228  192.168.45.149  224.0.0.251 MDNS  234 Standard query response 0x0000 PTR, cache flush debian1.local A, cache flush 192.168.45.149 PTR, cache flush debian1.local AAAA, cache flush fe80::a00:27ff:fe1f:a3a4
   31 9.545461  fe80::a00:27ff:fe1f:a3a4  ff02::fb  MDNS  101 Standard query 0x0000 PTR _nmea-0183._tcp.local, "QM" question
   32 9.545533  192.168.45.149  224.0.0.251 MDNS  81  Standard query 0x0000 PTR _nmea-0183._tcp.local, "QM" question
   33 11.548149 fe80::a00:27ff:fe1f:a3a4  ff02::fb  MDNS  101 Standard query 0x0000 PTR _nmea-0183._tcp.local, "QM" question
   34 11.548228 192.168.45.149  224.0.0.251 MDNS  81  Standard query 0x0000 PTR _nmea-0183._tcp.local, "QM" question
   36 15.551434 fe80::a00:27ff:fe1f:a3a4  ff02::fb  MDNS  101 Standard query 0x0000 PTR _nmea-0183._tcp.local, "QM" question
   37 15.551499 192.168.45.149  224.0.0.251 MDNS  81  Standard query 0x0000 PTR _nmea-0183._tcp.local, "QM" question
   38 23.548097 fe80::a00:27ff:fe1f:a3a4  ff02::fb  MDNS  101 Standard query 0x0000 PTR _nmea-0183._tcp.local, "QM" question
   39 23.548168 192.168.45.149  224.0.0.251 MDNS  81  Standard query 0x0000 PTR _nmea-0183._tcp.local, "QM" question
   42 25.448820 192.168.45.149  192.168.44.1  DNS 73  Standard query 0x6262 A cdn.fwupd.org
   43 25.448879 192.168.45.149  192.168.44.1  DNS 73  Standard query 0x4879 AAAA cdn.fwupd.org
   44 25.472431 192.168.44.1  192.168.45.149  DNS 178 Standard query response 0x6262 A cdn.fwupd.org CNAME p2.shared.global.fastly.net A 151.101.2.49 A 151.101.66.49 A 151.101.130.49 A 151.101.194.49
   45 25.484766 192.168.44.1  192.168.45.149  DNS 175 Standard query response 0x4879 AAAA cdn.fwupd.org CNAME p2.shared.global.fastly.net SOA ns1.fastly.net
   880  27.062180 192.168.45.149  192.168.44.1  DNS 90  Standard query 0xb2df SRV _http._tcp.security.debian.org
   881  27.062627 192.168.45.149  192.168.44.1  DNS 89  Standard query 0x6955 SRV _http._tcp.http.us.debian.org
   882  27.079957 192.168.44.1  192.168.45.149  DNS 134 Standard query response 0xb2df SRV _http._tcp.security.debian.org SRV 10 1 80 debian.map.fastlydns.net
   883  27.081149 192.168.45.149  192.168.44.1  DNS 84  Standard query 0x033c A debian.map.fastlydns.net
   884  27.081181 192.168.45.149  192.168.44.1  DNS 84  Standard query 0x8939 AAAA debian.map.fastlydns.net
   885  27.098421 192.168.44.1  192.168.45.149  DNS 100 Standard query response 0x033c A debian.map.fastlydns.net A 151.101.54.132
   886  27.099155 192.168.44.1  192.168.45.149  DNS 142 Standard query response 0x6955 No such name SRV _http._tcp.http.us.debian.org SOA denis.debian.org
   887  27.100190 192.168.45.149  192.168.44.1  DNS 78  Standard query 0x5cf3 A http.us.debian.org
   888  27.100219 192.168.45.149  192.168.44.1  DNS 78  Standard query 0x6df1 AAAA http.us.debian.org
   889  27.110485 192.168.44.1  192.168.45.149  DNS 112 Standard query response 0x8939 AAAA debian.map.fastlydns.net AAAA 2a04:4e42:d::644
   895  27.131013 192.168.44.1  192.168.45.149  DNS 144 Standard query response 0x5cf3 A http.us.debian.org CNAME ftp.us.debian.org A 208.80.154.15 A 64.50.236.52 A 64.50.233.100
   896  27.136512 192.168.44.1  192.168.45.149  DNS 180 Standard query response 0x6df1 AAAA http.us.debian.org CNAME ftp.us.debian.org AAAA 2600:3402:200:227::2 AAAA 2600:3404:200:237::2 AAAA 2620:0:861:1:208:80:154:15
   1026 34.277117 fe80::a00:27ff:fe1f:a3a4  ff02::fb  MDNS  102 Standard query 0x0000 PTR _pgpkey-hkp._tcp.local, "QM" question
   1027 34.277192 192.168.45.149  224.0.0.251 MDNS  82  Standard query 0x0000 PTR _pgpkey-hkp._tcp.local, "QM" question
   1028 35.277431 fe80::a00:27ff:fe1f:a3a4  ff02::fb  MDNS  102 Standard query 0x0000 PTR _pgpkey-hkp._tcp.local, "QM" question
   1029 35.277502 192.168.45.149  224.0.0.251 MDNS  82  Standard query 0x0000 PTR _pgpkey-hkp._tcp.local, "QM" question
   1030 37.281532 fe80::a00:27ff:fe1f:a3a4  ff02::fb  MDNS  102 Standard query 0x0000 PTR _pgpkey-hkp._tcp.local, "QM" question
   1031 37.281600 192.168.45.149  224.0.0.251 MDNS  82  Standard query 0x0000 PTR _pgpkey-hkp._tcp.local, "QM" question
   1032 39.542835 fe80::a00:27ff:fe1f:a3a4  ff02::fb  MDNS  101 Standard query 0x0000 PTR _nmea-0183._tcp.local, "QM" question
   1033 39.542905 192.168.45.149  224.0.0.251 MDNS  81  Standard query 0x0000 PTR _nmea-0183._tcp.local, "QM" question
   1034 41.280723 fe80::a00:27ff:fe1f:a3a4  ff02::fb  MDNS  102 Standard query 0x0000 PTR _pgpkey-hkp._tcp.local, "QM" question
   1035 41.280833 192.168.45.149  224.0.0.251 MDNS  82  Standard query 0x0000 PTR _pgpkey-hkp._tcp.local, "QM" question
   1036 49.282609 fe80::a00:27ff:fe1f:a3a4  ff02::fb  MDNS  102 Standard query 0x0000 PTR _pgpkey-hkp._tcp.local, "QM" question
   1037 49.282680 192.168.45.149  224.0.0.251 MDNS  82  Standard query 0x0000 PTR _pgpkey-hkp._tcp.local, "QM" question
   1039 65.274990 fe80::a00:27ff:fe1f:a3a4  ff02::fb  MDNS  102 Standard query 0x0000 PTR _pgpkey-hkp._tcp.local, "QM" question
   1040 65.275063 192.168.45.149  224.0.0.251 MDNS  82  Standard query 0x0000 PTR _pgpkey-hkp._tcp.local, "QM" question
   1748 86.290988 192.168.45.149  192.168.44.1  DNS 90  Standard query 0xebe5 SRV _http._tcp.security.debian.org
   1749 86.291041 192.168.45.149  192.168.44.1  DNS 89  Standard query 0x1591 SRV _http._tcp.http.us.debian.org
   1750 86.308322 192.168.44.1  192.168.45.149  DNS 134 Standard query response 0xebe5 SRV _http._tcp.security.debian.org SRV 10 1 80 debian.map.fastlydns.net
   1751 86.312459 192.168.45.149  192.168.44.1  DNS 84  Standard query 0x5b28 A debian.map.fastlydns.net
   1752 86.312511 192.168.45.149  192.168.44.1  DNS 84  Standard query 0x3d34 AAAA debian.map.fastlydns.net
   1753 86.326989 192.168.44.1  192.168.45.149  DNS 142 Standard query response 0x1591 No such name SRV _http._tcp.http.us.debian.org SOA denis.debian.org
   1754 86.329544 192.168.45.149  192.168.44.1  DNS 78  Standard query 0x8634 A http.us.debian.org
   1755 86.329595 192.168.45.149  192.168.44.1  DNS 78  Standard query 0x6608 AAAA http.us.debian.org
   1756 86.331100 192.168.44.1  192.168.45.149  DNS 157 Standard query response 0x8634 A http.us.debian.org CNAME ftp.us.debian.org A 64.50.233.100 A 64.50.236.52 A 208.80.154.15
   1757 86.331179 192.168.44.1  192.168.45.149  DNS 193 Standard query response 0x6608 AAAA http.us.debian.org CNAME ftp.us.debian.org AAAA 2620:0:861:1:208:80:154:15 AAAA 2600:3404:200:237::2 AAAA 2600:3402:200:227::2
   1759 86.339386 192.168.44.1  192.168.45.149  DNS 100 Standard query response 0x5b28 A debian.map.fastlydns.net A 151.101.54.132
   1760 86.348089 192.168.44.1  192.168.45.149  DNS 112 Standard query response 0x3d34 AAAA debian.map.fastlydns.net AAAA 2a04:4e42:d::644
   1789 97.272164 fe80::a00:27ff:fe1f:a3a4  ff02::fb  MDNS  102 Standard query 0x0000 PTR _pgpkey-hkp._tcp.local, "QM" question
   1790 97.272265 192.168.45.149  224.0.0.251 MDNS  82  Standard query 0x0000 PTR _pgpkey-hkp._tcp.local, "QM" question
   1804 161.262641  fe80::a00:27ff:fe1f:a3a4  ff02::fb  MDNS  102 Standard query 0x0000 PTR _pgpkey-hkp._tcp.local, "QM" question
   1805 161.262732  192.168.45.149  224.0.0.251 MDNS  82  Standard query 0x0000 PTR _pgpkey-hkp._tcp.local, "QM" question
   1808 289.266786  fe80::a00:27ff:fe1f:a3a4  ff02::fb  MDNS  102 Standard query 0x0000 PTR _pgpkey-hkp._tcp.local, "QM" question
   1809 289.266862  192.168.45.149  224.0.0.251 MDNS  82  Standard query 0x0000 PTR _pgpkey-hkp._tcp.local, "QM" question
   1823 580.091493  192.168.45.149  224.0.0.251 MDNS  252 Standard query 0x0000 ANY 4.a.3.a.f.1.e.f.f.f.7.2.0.0.a.0.0.0.0.0.0.0.0.0.0.0.0.0.0.8.e.f.ip6.arpa, "QM" question ANY debian1.local, "QM" question ANY 149.45.168.192.in-addr.arpa, "QM" question A 192.168.45.149 PTR debian1.local AAAA fe80::a00:27ff:fe1f:a3a4 PTR debian1.local
   1825 580.341951  192.168.45.149  224.0.0.251 MDNS  252 Standard query 0x0000 ANY 4.a.3.a.f.1.e.f.f.f.7.2.0.0.a.0.0.0.0.0.0.0.0.0.0.0.0.0.0.8.e.f.ip6.arpa, "QM" question ANY debian1.local, "QM" question ANY 149.45.168.192.in-addr.arpa, "QM" question A 192.168.45.149 PTR debian1.local AAAA fe80::a00:27ff:fe1f:a3a4 PTR debian1.local
   1826 580.592960  192.168.45.149  224.0.0.251 MDNS  252 Standard query 0x0000 ANY 4.a.3.a.f.1.e.f.f.f.7.2.0.0.a.0.0.0.0.0.0.0.0.0.0.0.0.0.0.8.e.f.ip6.arpa, "QM" question ANY debian1.local, "QM" question ANY 149.45.168.192.in-addr.arpa, "QM" question A 192.168.45.149 PTR debian1.local AAAA fe80::a00:27ff:fe1f:a3a4 PTR debian1.local
   1828 580.792444  192.168.45.149  224.0.0.251 MDNS  234 Standard query response 0x0000 PTR, cache flush debian1.local A, cache flush 192.168.45.149 PTR, cache flush debian1.local AAAA, cache flush fe80::a00:27ff:fe1f:a3a4
   1834 581.862742  192.168.45.149  224.0.0.251 MDNS  234 Standard query response 0x0000 PTR, cache flush debian1.local A, cache flush 192.168.45.149 PTR, cache flush debian1.local AAAA, cache flush fe80::a00:27ff:fe1f:a3a4
   1835 581.862785  fe80::a00:27ff:fe1f:a3a4  ff02::fb  MDNS  201 Standard query response 0x0000 PTR, cache flush debian1.local AAAA, cache flush fe80::a00:27ff:fe1f:a3a4
   1836 583.933727  192.168.45.149  224.0.0.251 MDNS  234 Standard query response 0x0000 PTR, cache flush debian1.local A, cache flush 192.168.45.149 PTR, cache flush debian1.local AAAA, cache flush fe80::a00:27ff:fe1f:a3a4
   1837 583.933793  fe80::a00:27ff:fe1f:a3a4  ff02::fb  MDNS  201 Standard query response 0x0000 PTR, cache flush debian1.local AAAA, cache flush fe80::a00:27ff:fe1f:a3a4
   1840 587.931038  fe80::a00:27ff:fe1f:a3a4  ff02::fb  MDNS  101 Standard query 0x0000 PTR _nmea-0183._tcp.local, "QM" question
   1841 587.931108  192.168.45.149  224.0.0.251 MDNS  81  Standard query 0x0000 PTR _nmea-0183._tcp.local, "QM" question
   1842 588.938347  fe80::a00:27ff:fe1f:a3a4  ff02::fb  MDNS  101 Standard query 0x0000 PTR _nmea-0183._tcp.local, "QM" question
   1843 588.938400  192.168.45.149  224.0.0.251 MDNS  81  Standard query 0x0000 PTR _nmea-0183._tcp.local, "QM" question
   1844 590.938045  fe80::a00:27ff:fe1f:a3a4  ff02::fb  MDNS  101 Standard query 0x0000 PTR _nmea-0183._tcp.local, "QM" question
   1845 590.938109  192.168.45.149  224.0.0.251 MDNS  81  Standard query 0x0000 PTR _nmea-0183._tcp.local, "QM" question
   1847 594.940559  fe80::a00:27ff:fe1f:a3a4  ff02::fb  MDNS  101 Standard query 0x0000 PTR _nmea-0183._tcp.local, "QM" question
   1848 594.940629  192.168.45.149  224.0.0.251 MDNS  81  Standard query 0x0000 PTR _nmea-0183._tcp.local, "QM" question
   1849 602.941932  fe80::a00:27ff:fe1f:a3a4  ff02::fb  MDNS  101 Standard query 0x0000 PTR _nmea-0183._tcp.local, "QM" question
   1850 602.942010  192.168.45.149  224.0.0.251 MDNS  81  Standard query 0x0000 PTR _nmea-0183._tcp.local, "QM" question
   1854 612.545878  192.168.45.149  192.168.44.1  DNS 73  Standard query 0xcccb A cdn.fwupd.org
   1855 612.545909  192.168.45.149  192.168.44.1  DNS 73  Standard query 0x50ce AAAA cdn.fwupd.org
   1856 612.567883  192.168.44.1  192.168.45.149  DNS 178 Standard query response 0xcccb A cdn.fwupd.org CNAME p2.shared.global.fastly.net A 151.101.2.49 A 151.101.66.49 A 151.101.130.49 A 151.101.194.49
   1857 612.575320  192.168.44.1  192.168.45.149  DNS 175 Standard query response 0x50ce AAAA cdn.fwupd.org CNAME p2.shared.global.fastly.net SOA ns1.fastly.net
   2697 613.907959  192.168.45.149  192.168.44.1  DNS 90  Standard query 0x0ddc SRV _http._tcp.security.debian.org
   2698 613.908651  192.168.45.149  192.168.44.1  DNS 89  Standard query 0x6e3f SRV _http._tcp.http.us.debian.org
   2699 613.923637  192.168.44.1  192.168.45.149  DNS 134 Standard query response 0x0ddc SRV _http._tcp.security.debian.org SRV 10 1 80 debian.map.fastlydns.net
   2700 613.924762  192.168.45.149  192.168.44.1  DNS 84  Standard query 0x4290 A debian.map.fastlydns.net
   2701 613.924796  192.168.45.149  192.168.44.1  DNS 84  Standard query 0x6295 AAAA debian.map.fastlydns.net
   2702 613.940068  192.168.44.1  192.168.45.149  DNS 100 Standard query response 0x4290 A debian.map.fastlydns.net A 151.101.54.132
   2703 613.946679  192.168.44.1  192.168.45.149  DNS 142 Standard query response 0x6e3f No such name SRV _http._tcp.http.us.debian.org SOA denis.debian.org
   2704 613.946943  192.168.44.1  192.168.45.149  DNS 112 Standard query response 0x6295 AAAA debian.map.fastlydns.net AAAA 2a04:4e42:d::644
   2705 613.947834  192.168.45.149  192.168.44.1  DNS 78  Standard query 0x560f A http.us.debian.org
   2706 613.947866  192.168.45.149  192.168.44.1  DNS 78  Standard query 0xd00c AAAA http.us.debian.org
   2714 613.986557  192.168.44.1  192.168.45.149  DNS 144 Standard query response 0x560f A http.us.debian.org CNAME ftp.us.debian.org A 64.50.236.52 A 64.50.233.100 A 208.80.154.15
   2715 613.986833  192.168.44.1  192.168.45.149  DNS 180 Standard query response 0xd00c AAAA http.us.debian.org CNAME ftp.us.debian.org AAAA 2600:3402:200:227::2 AAAA 2620:0:861:1:208:80:154:15 AAAA 2600:3404:200:237::2
   ```
   We can see our local DNS server is 192.168.44.1 and observe a number of queries and responses with a mix of resource records. We also see mDNS packets which is part of zeroconf and is one way auto-configured machines (with APIPA addresses) can find each other. Leave the packet capture running and start a windows VM. In addition to DNS and mDNS, windows uses LLMNR which is Microsoft's mDNS implementation and NetBIOS Name Services (NBNS) to make itself known on the local network.

### The resolver library
An operating system provides many services to applications and one of these is name resolution.  This is essentially just looking up an answer to a query in a data source.  We will be looking at three files on debian1-1 involved with this process, `/etc/nsswitch.conf`, `/etc/hosts`, and `/etc/resolv.conf`.  While we are focusing on hostname related lookups, keep in mind the operating system has other types of lookups, for example, matching usernames to user IDs, which is why the first file we look at is used for more than just hostname lookups.

1. On the debian1-1 VM, we are going to look at the Name Services Switch (NSS) configuration file, `/etc/nsswitch.conf`.  The NSS library is also used for other types of lookups, but for hostname resolution, we are only interested in one line, the line beginning with `hosts:`. We can use the grep utility to show just that line:
   ```
   student@debian1:~$ grep ^hosts: /etc/nsswitch.conf
   hosts:          files mdns4_minimal [NOTFOUND=return] dns myhostname
   student@debian1:~$
   ```
   This line tells us it will search `files` first, then `mdns4_minimal`, then `dns`, and lastly `myhostname`. When a query fails, the default action is to continue with next potential source.  However, in the case of `mdns4_minimal`, the `[NOTFOUND=return]` that follows says IPv4 multicast DNS should return if it successfully queries and gets a NOTFOUND result.

1. `files` in the nsswitch.conf below refers to local files and, in the case of hostname lookups, this means `/etc/hosts` is the first place the system looks for a matching IP address. We can look at `/etc/hosts` with any text viewer and we see the default entries are for the localhost.
   ```
   student@debian1:~$ cat /etc/hosts
   127.0.0.1  localhost
   127.0.1.1  debian-11.1.0-default debian-11

   # The following lines are desirable for IPv6 capable hosts
   ::1     localhost ip6-localhost ip6-loopback
   ff02::1 ip6-allnodes
   ff02::2 ip6-allrouters
   ```
   There are a few things to note.  First, each line is a record with space separated fields.  The first field is the IP address, followed by one or more names that will all resolve to the same address.  Note, if you are adding hostnames to `/etc/hosts` for the local host, make sure the first hostname on the line is fully qualified as some software can have problems if the first hostname is missing the domain part.  Second, all addresses beginning with `127` refer to the local host using the loopback interface, not just 127.0.0.1.

1. Trying to maintain a shared text file across multiple systems is much more error prone than using a centralized network service like DNS, but because it is searched first, it can still be useful in testing scenarios.  For example, ping www1 and observe the IP address you get back.
   ```
   student@debian1:~$ ping -c 1 www1
   PING www1.networkplus.test (192.168.43.1) 56(84) bytes of data.
   64 bytes from www1.networkplus.test (192.168.43.1): icmp_seq=1 ttl=61 time=1.53 ms

   --- www1.networkplus.test ping statistics ---
   1 packets transmitted, 1 received, 0% packet loss, time 0ms
   rtt min/avg/max/mdev = 1.525/1.525/1.525/0.000 ms
   student@debian1:~$
   ```
   We see the host resolved `www1` to 192.168.43.1. Let's assume you were developing a web app on debian1-1 and you wanted to connect to nginx running on debian1-1 whenever you typed http://www1.networkplus.test/ in the browser.  You could add a line to your `/etc/hosts` file to provide an answer before DNS does like this.
   ```
   student@debian1:~$ sudo -i
   [sudo] password for student: 
   root@debian1:~# echo '127.0.0.2 www1.networkplus.test www1' >> /etc/hosts
   root@debian1:~# ping -c 1 www1
   PING www1.networkplus.test (127.0.0.2) 56(84) bytes of data.
   64 bytes from www1.networkplus.test (127.0.0.2): icmp_seq=1 ttl=64 time=0.026 ms

   --- www1.networkplus.test ping statistics ---
   1 packets transmitted, 1 received, 0% packet loss, time 0ms
   rtt min/avg/max/mdev = 0.026/0.026/0.026/0.000 ms
   root@debian1:~#
   ```
   We can see from our ping test that trying to connect to www1 will now connected to 127.0.0.2 which is a loopback address.  You could just point your browser at 127.0.0.2 instead of editing the `/etc/hosts` but this has the added benefit of setting the `host:` header in the HTTP request in case you are using namebased virtual hosts. Of course, you can still get to the real www1 by IP address, but you will want to remember to undo this when you're done testing.  Let's do that now before we forget and while we are still the root user.
   ```
   root@debian1:~# sed -i -e '/^127.0.0.2/d' /etc/hosts
   root@debian1:~# cat /etc/hosts
   127.0.0.1  localhost
   127.0.1.1  debian-11.1.0-default debian-11

   # The following lines are desirable for IPv6 capable hosts
   ::1     localhost ip6-localhost ip6-loopback
   ff02::1 ip6-allnodes
   ff02::2 ip6-allrouters
   root@debian1:~# exit
   logout
   student@debian1:~$ 
   ```

1. After checking local files, our `/etc/nsswitch.conf` file tells us to try `mdns4_minimal`.  Multicast DNS, or mDNS, is a standard evolved from Apple's zeroconf service, Bonjour. You may have heard how hosts can automatically assign themselves an IPv4 address on the reserved 169.254.0.0/16 network (an APIPA address) when there is no DHCP and been wondering how hosts on such a network can find each other. mDNS uses a reserved DNS top level domain (TLD) of `.local`.  The mDNS service uses UDP port 5353 (standard DNS uses UDP port 53). Avahi is the name of the service running on our version of Debian that announce the machines hostname using mDNS and listens for mDNS traffic. We can verify that using `ss` (`ss` is a replacement for the ancient `netstat` command on newer Linux distributions but you could use either in this case assuming `netstat` is installed). You need to use `sudo` in order to see the name and PID of the process listening on the ports.
   ```
   student@debian1:~$ sudo ss -nulp
   [sudo] password for student: 
   State     Recv-Q    Send-Q       Local Address:Port        Peer Address:Port    Process                                                                         
   UNCONN    0         0                  0.0.0.0:5353             0.0.0.0:*        users:(("avahi-daemon",pid=410,fd=12))                                         
   UNCONN    0         0                  0.0.0.0:34329            0.0.0.0:*        users:(("avahi-daemon",pid=410,fd=14))                                         
   UNCONN    0         0                     [::]:36898               [::]:*        users:(("avahi-daemon",pid=410,fd=15))                                         
   UNCONN    0         0                     [::]:5353                [::]:*        users:(("avahi-daemon",pid=410,fd=13)) 
   ``` 
   With our packet capture still running, we can restart the Avahi service and observe the mDNS announcements.
   ```
   student@debian1:~$ sudo systemctl restart avahi-daemon
   student@debian1:~$
   ```
   224.0.0.251 is the IPv4 multicast address reserved for mDNS and ff02::fb is the IPv6 address reserved for mDNS.  All hosts using mDNS will be listening for traffic on one or both of these addresses.  From the windows VM, open a powershell and try to ping debian1.local.


# Unfinished...
and we c (on some Linux systems use systemd-resolve to provide mDNS and Stop the router2 node. From the windows VM, open a terminal and ping debian1-1.local.
   ```
   ping debian1-1.local
   ```
   Observe the 

i. Start DNS trace in front of dns1.  Ping a site you have not visited.  Now ping it again.  Observe caching.

1. dig -h
   dig www1
   dig www1.networkplus.test
   dig @8.8.8.8 www1.networkplus.test
   dig networkplus.test
   dig networkplus.test NS
   dig networkplus.test MX
   dig +trace ???
