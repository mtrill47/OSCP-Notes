# Directory Bruteforcing

## Gobuster
- `gobuster dir -u http://"$IP"/ -w /usr/share/wordlists/dirb/common.txt --no-error -o $PWD/enum/gobustergob-common -x asp,php`

- `gobuster dir -u http://"$IP"/ -w /usr/share/seclists/Discovery/Web-Content/raft-small-words.txt --no-error -o $PWD/enum/gobustergob-raft-small-words -x asp,php`

- `gobuster dir -u http://"$IP"/ -w /usr/share/wordlists/dirbuster/directory-list-2.3-small.txt --no-error -o $PWD/enum/gobuster/gob-directory-small -x asp,php`

## DirSearch
`dirsearch -u http://<IP>/ --exclude-status=300,400-499,500-599 -o dirsearch`

# SubDomain Enum
`wfuzz -c -f sub-finder -w <wordlist> -u '<url>' -H "Host: FUZZ.cmess.thm" --hw <common number>`

# Hidden Parameter Fuzzing
`wfuzz -c -z file,/usr/share/seclists/Discovery/Web-Content/burp-parameter-names.txt --hh <common number> <URL>`

# LFI
`wfuzz -c -z file,/usr/share/seclists/Fuzzing/LFI/LFI-Jhaddix.txt --hh <common number> <URL>`