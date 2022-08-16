# Port Scanning
# Rustscan combined with Nmap using a bash alias for all ports
# Usage: `rusty <IP>`
rusty() {
    IP=$1
    /home/kali/.cargo/bin/rustscan -a "$IP" -- -A -v -oN $PWD/nmapinit 
}


# SMB Enum
# Nmap and Enum4linuxng using a bash alias. This creates a directory called Enum in the current working directory.
# Usage: `win-enum <IP>`
win-enum() {
    IP=$1
    echo "Starting SMB Enum Script..."
    mkdir -p enum
    nmap --script "smb-vuln*" -p139,445 -oN $PWD/enum/nmap-smb-enum "$IP"

    echo "Starting SMB Vuln Scritps..."
    nmap --script "smb-enum*" -p139,445 -oN $PWD/enum/nmap-smb-vuln "$IP"

    echo "Starting Enum4Linux..."
    /home/kali/tools/enum4linux-ng/enum4linux-ng.py -A "$IP" -oY $PWD/enum/enum4l 
}


# netcat reverse shell
rusty() {
    IP=$1
    /home/kali/.cargo/bin/rustscan -a "$IP" -- -A -v -oN $PWD/nmapinit
}