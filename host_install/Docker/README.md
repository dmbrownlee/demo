# Docker on MacOS demo machines
The Network+ course uses Docker containers to simulate hosts in its GNS3 lab network. This page outlines my process for creating container images on MacOS.

## Installing Docker
1. Install the software
  ```
  brew install podman
  ```
1. Create a Linux virtual machine named "default" with qemu for building and testing containers
  ```
  podman machine init
  ```
  Note: This creates the VM but does not start it (see below)

1. You can see the status of your podman VMs with:
  ```
  podman machine list
  ```
podman commands issued on the local (macos) command line will be sent to the podman machine running inside the "default" virtual machine.

## Starting and stopping the "default" virtual machine
You can start the "default" virtual machine with:</br>
```
podman machine start
```
You can stop the "default" virtual machine with:</br>
```
podman machine stop
```
You can login to the "default" virtual machine if you want to run podman commands from the Linux command line with:</br>
```
podman machine ssh
```
## Building an image from a Docker file
Change into the directory containing the ```Dockerfile``` (I'll use the "alpine" image in this example):</br>
```
cd alpine/
```
Next, run the podman build command specifying an appropriate repo and tag and passing the current directory ('.') as the first argument:</br>
```
podman build --rm --no-cache --build-arg username=student --build-arg password=password -t dmbrownlee/alpine:latest .
```
Note, I use the tag "<image>:latest" for testing.</br>
You can verify the new image is in the "default" virtual machine's image store with:</br>
```
podman images
```
You can start a container using:</br>
```
podman run -it --rm -p 2023:22 --name mycontainer dmbrownlee/alpine:latest
```
You can attach a terminal to the running container with:</br>
```
podman container attach mycontainer
```
Note: To detatch from a container, use Ctrl-p,Cntl-q</br>
If the default entry point is buggy, you can open a shell in the container with:</br>
```
podman exec -it <container id> bash
```
If you created a container that accepts SSH connections, you can connect to the container via ssh:</br>
```
ssh -l student -p 2023 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null 192.168.99.100
```
Note, the IP address belongs to the "default" virtual machine and port 2023 is getting forwarded to port 22 within the test container.

or to run a shell within the container:</br>
```
podman run -it --rm -p 2023:22 --name mycontainer dmbrownlee/alpine:latest bash
```
## Uploading new images to hub.docker.com
Make sure you are logged into your hub.docker.com account:</br>
```
podman login docker.io --username dmbrownlee
```
Then upload the image:</br>
```
podman push dmbrownlee/alpine:latest
```
## Updating images in GNS3 VM
If you have already pulled an image to the GNS3 VM, it will continue to use that version of the image even if a newer version has been pushed to hub.docker.com.  Information about how to login to the GNS3 VM can be found on the VMs console.
```
ssh -l gns3 192.168.56.101
```
Once logged in, you can run docker commands to update images, remove containers, etc.
However, the GNS3 GUI keeps track of container IDs in models.  Your best bet is to:
1. Stop the GNS3 GUI
1. Delete the project directory from ~/GNS3/projects/
1. Start the GNS3 VM from the VirtualBox UI
1. Login to the GNS3 VM and use docker commands to clean up old containers and images before updating the images with docker pull
1. Start the GNS3 GUI again
1. Reimport the portable project

The last step will creating all new containers using the new images and include them in the model.

## Docker commands you might find useful with the GNS3 VM
List all containers including containers that are not currently running:</br>
```
docker container list -a
```
Remove a container:</br>
```
docker container rm <id>
```
List all images:</br>
```
docker images
```
Delete and image:</br>
```
docker image rm <id>
```
Download the latest image:</br>
```
docker pull dmbrownlee/alpine:latest
```
Find out more about an image:</br>
```
docker inspect dmbrownlee/alpine:latest
```
See the history of the layers (not useful when squashed?):</br>
```
docker history dmbrownlee/alpine:latest
```
