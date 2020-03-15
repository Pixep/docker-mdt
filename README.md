# Mendel Development Tool docker image

This docker image provides Mendel development tool (mdt).

## Usage

The examples below mount `~/.config/mdt` folder, used by `mdt` to generate and use the device authentication key. If you later choose to run `mdt` natively on your host, you will need to change the owner or permission of the keys in `~/.config/mdt`. By default the image runs as root, and these keys will be owned by the `root` user.

The `--network host` allows the image to use the host network directly. This is required for zeroconf (used for device detection) to work.

Run a Bash interactive shell with `mdt` support:
```
docker run -it --rm --network host -v ${HOME}/.config/mdt:/root/.config/mdt aleravat/mendel-development-tool
```

Show devices detected by `mdt` with `mdt devices` 
```
docker run -it --rm --network host -v ${HOME}/.config/mdt:/root/.config/mdt aleravat/mendel-development-tool mdt devices
```

... or for any other command
```
docker run -it --rm --network host -v ${HOME}/.config/mdt:/root/.config/mdt aleravat/mendel-development-tool mdt <command>
```

