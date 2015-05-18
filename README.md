# vim-rust
Docker image that bundles rust with vim + plugins

Warning: this image is under development

## Known issues

Default Docker installation (as of version 1.5.0 on Ubuntu 14.04) have problems with `gdb` (e.g. breakpoints does not work).
If you want to use `gdb` from within the image, you can use the following workaround (under Ubuntu):

* Install the `apparmor-utils` package: `sudo apt-get install apparmor-utils`
* Enable the complain mode for the docker apparmor config: `sudo aa-complain /etc/apparmor.d/docker`

This is needed *at every reboot*. If you want to persist this setting, simply put it in `/etc/rc.local`:

`sudo echo "aa-complain /etc/apparmor.d/docker" >> /etc/rc.local`.

See [StevenVanAcker comment](https://github.com/docker/docker/issues/7276#issuecomment-50436671) on issue #7276 of Docker.
