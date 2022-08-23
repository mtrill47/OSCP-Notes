## Directory Bruteforcing
- `gobuster dir -u http://"$IP"/ -w /usr/share/wordlists/dirb/common.txt --no-error -o $PWD/enum/gobustergob-common -x asp,php`
- `gobuster dir -u http://"$IP"/ -w /usr/share/seclists/Discovery/Web-Content/raft-small-words.txt --no-error -o $PWD/enum/gobustergob-raft-small-words -x asp,php`
- `gobuster dir -u http://"$IP"/ -w /usr/share/wordlists/dirbuster/directory-list-2.3-small.txt --no-error -o $PWD/enum/gobuster/gob-directory-small -x asp,php`