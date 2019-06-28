# About

Machine Image builder for our VSCode Liveshare sessions (https://twitch.tv/statebox).

Some more background on how we're using this, here https://hackmd.io/6jSPsTXDTcu0xxqsdfMBdA

# Usage

Create a VM from this image using the *google cloud console*.

Then, ssh into it and forward the `nomachine` port, 4000.

```
# replace wires@instance-1 by the username and the instance name
gcloud --project=statebox-infra compute ssh wires@liveshare -- -L 4555:localhost:4000
```

You can add the `-A` flag at the end of this command to forward you ssh-agent connection, meaning that you can use your local private keys to push to github. Do not forget to run `ssh-add` before you you connect, to add your keys to the ssh agent.

# Machine configuration

Based of debian-9 and with a `wires` user.

The APT repository is updated and some stuff is installed:

- LXDE desktop,
- git, tig,
- vim, less
- sakura (shell)
- nmap
- htop
- nix
- nodejs v12.3.1

Then, `nomachine` is installed, which provides the remote desktop functionality.

VSCode is installed.

It writes a NX server config and creates a user:

> login: `wires`
> password: `geheim`

Then, as the `wires` user, some more stuff is installed:

- Some VS code extentions are installed
    - `ms-vsliveshare.vsliveshare` Live sharing
    - `zjhmale.idris` Idris support
- Elba as `~wires/bin/elba`
- Some statebox code from public repos into `~wires/code`

Then the `/nix` store is warmed up by starting a nix-env shell in the repos.

# Updating the image

## Configuration

Configuration in `config.json`

to see available values:

- `source_image_family`, list images ("FAMILY" column) `gcloud compute images list`
- `machine_type`, list machine types ("NAME" column) `gcloud compute machine-types list`

## Building

```
# run
packer build -var-file=config.json packer.json
```

## References

- wiki page https://wiki.archlinux.org/index.php/FreeNX#Installation
- manual https://www.nomachine.com/DT07M00090#10.8.
- multicursor window manager http://multicursor-wm.sourceforge.net/#compiling

https://www.nomachine.com/accessing-your-remote-desktop-on-google-cloud-platform-via-nomachine

https://syslog.ravelin.com/baking-with-packer-in-google-cloud-ef20dd3a6098?gi=3edb76d8eb59

cannot use root username [ref](https://serverfault.com/questions/792328/using-packer-with-google-cloud-and-getting-an-ssh-connection-issue-w-debian-bui)
