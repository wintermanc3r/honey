p0f is a package for passively reading and fingerprinting packets, either live data or capture packet files.

OS detection is done via a number of factors, including the size of the Time to Live packets.

On a normal Ubuntu installation, p0f can be installed simply with 
`apt-get install p0f`

Included are a few scripts for parsing packet files:

p0f_os_detection.sh:
Sample output:
p0f OS detection sorted by number of packets (possibly) from each OS:
  14702 Linux 3.11 and newer
    492 Linux 2.2.x-3.x (barebone)
     76 Windows 7 or 8
     62 Linux 3.1-3.10
     23 Windows XP
     18 Linux 2.4.x
      7 Linux 2.2.x-3.x
      4 Linux 3.x
      4 Linux 2.2.x-3.x (no timestamps)
      3 Linux 2.4.x-2.6.x
      2 Linux 2.6.x

p0f_older_linux.sh simply shows packets that seem to be from a Linux system pre Linux 3.x

p0f_windows.sh shows packets from Windows machines

p0f_barebones.sh shows packets from barebone Linux machines

p0f_older_linux_by_port.sh: Takes all packets from Linux 2.0 and all barebone Linux machines (2.0 and 3.0) and shows them by port
Sample output:
    744 23
    158 5358
     46 2323
     28 6789
     19 22
      6 7547
      5 80
      4 23231
      2 8080
      2 4028
      2 2222
      2 19058

