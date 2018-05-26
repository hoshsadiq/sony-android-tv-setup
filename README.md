# Sony Setup

A docker container that simply deletes a whole bunch of unnecessary packages for Sony Android TVs and installs additional packages.

You can build it like so:
```bash
docker build -t sony-tv-setup .
```

Then run it with
```bash
docker run --rm -it --privileged -v $(pwd):/workdir -v /dev/bus/usb:/dev/bus/usb --name adbd sony-tv-setup
```

### Deleted packages
All packages that will be deleted are in `/filesystem/usr/local/bin/del-sony-packages.sh`

### Installed packages
Currently only `com.nitroxenon.terrarium` is installed
