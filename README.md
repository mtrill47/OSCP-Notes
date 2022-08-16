# OSCP-Notes
Most of the notes, resources and scripts I used to prepare for the OSCP and pass it the first time.

There are a bunch of sections in these notes, some sections have their own folders and all, just look around.

## Recon

### Port Scanning
Rustscan combined with Nmap using a bash alias

Usage: `rusty <IP>`
```# rustscan all ports
rusty() {
    IP=$1
    /home/kali/.cargo/bin/rustscan -a "$IP" -- -A -v -oN $PWD/nmapinit }

### SMB Enum
Nmap and Enum4linuxng using a bash alias. This creates a directory called Enum in the current working directory.

Usage: `win-enum <IP>`
```win-enum() {
    IP=$1
    echo "Starting SMB Enum Script..."
    mkdir -p enum
    nmap --script "smb-vuln*" -p139,445 -oN $PWD/enum/nmap-smb-enum "$IP"

    echo "Starting SMB Vuln Scritps..."
    nmap --script "smb-enum*" -p139,445 -oN $PWD/enum/nmap-smb-vuln "$IP"

    echo "Starting Enum4Linux..."
    /home/kali/tools/enum4linux-ng/enum4linux-ng.py -A "$IP" -oY $PWD/enum/enum4l

}