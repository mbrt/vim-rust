# vim-rust
Docker image that bundles [Rust lang](http://www.rust-lang.org/) (with `rustc`, `cargo`) and the following vim plugins:
* [racer](https://github.com/phildawes/racer)
* [rust.vim](https://github.com/rust-lang/rust.vim)
* [tagbar](https://github.com/majutsushi/tagbar)
* [neocomplete](https://github.com/Shougo/neocomplete)
* [NERD Tree](https://github.com/scrooloose/nerdtree)
* [vim-airline](https://github.com/bling/vim-airline)
* [fugitive.vim](https://github.com/tpope/vim-fugitive)
* [NERD Tree tabs](https://github.com/jistr/vim-nerdtree-tabs)
* [undotree](https://github.com/mbbill/undotree)
* [vim-easymotion](https://github.com/Lokaltog/vim-easymotion)
* [NERD Commenter](https://github.com/scrooloose/nerdcommenter)

## Usage
Run this image from within your workspace. You can than edit your project using `vim` and usual rust commands: `cargo build`, `cargo test`, etc. 

```
cd your/rust/workspace
docker run --rm -tiv `pwd`:/source mbrt/vim-rust
```

You can also debug by using `rust-gdb` command. If you have problems with the debugger, see the *Troubleshooting* section.

## Troubleshooting
Default Docker installation (as of version 1.5.0 on Ubuntu 14.04) have problems with `gdb` (e.g. breakpoints does not work).
If you want to use `gdb` from within the image, you can use the following workaround (under Ubuntu):

* Install the `apparmor-utils` package: `sudo apt-get install apparmor-utils`
* Enable the complain mode for the docker apparmor config: `sudo aa-complain /etc/apparmor.d/docker`

This is needed *at every reboot*. If you want to persist this setting, simply edit `/etc/rc.local` as root and add this line before `exit 0`:

`aa-complain /etc/apparmor.d/docker`

See [StevenVanAcker comment](https://github.com/docker/docker/issues/7276#issuecomment-50436671) on issue #7276 of Docker.
