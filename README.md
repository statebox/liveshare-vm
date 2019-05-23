# Usage

Create a VM from this image using the *google cloud console*.

Then, ssh into it and forward the `nomachine` port, 4000.

```
# replace wires@instance-1 by the username and the instance name
gcloud --project=statebox-infra compute ssh wires@liveshare -- -L 4555:localhost:4000
```

# Machine configuration

First, `nomachine` is installed, which provides the remote desktop functionality.



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
