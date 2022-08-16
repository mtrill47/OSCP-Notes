# OSCP-Notes
Most of the notes, resources and scripts I used to prepare for the OSCP and pass it the first time.

There are a bunch of sections in these notes, some sections have their own folders and all, just look around.

## Recon
Rustscan combined with Nmap with using a bash alias
Usage: `rusty <IP>`
```# rustscan all ports
rusty() {
    IP=$1
    /home/kali/.cargo/bin/rustscan -a "$IP" -- -A -v -oN $PWD/nmapinit```