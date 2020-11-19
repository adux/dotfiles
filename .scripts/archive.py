"""
An Archive script that:
gets all the files in ~/Archive

Rsyncs them into the host.
$ › rsync -art -P -e 'ssh -p 23580' Archive/ adux@192.168.1.48:/mnt/crypt/Archive/ ~

how to check integrity ?
Its for files to maaaaybe go back to. not really for backup on "to be used"

if "PipisEstrich" in str(subprocess.check_output(["iwgetid", "-r"])):
...     print("Exito")

I would only do it on local wifi ...


All needs to get a systemd timer
https://wiki.archlinux.org/index.php/Systemd/Timers

and check that its for sure executed

"""
