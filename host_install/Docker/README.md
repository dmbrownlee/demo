# Docker on MacOS demo machines
The Network+ course uses Docker containers to simulate hosts in its GNS3 lab network. This page outlines my process for creating container images on MacOS.

## Installing Docker
1. Install the software
  ```
  brew install docker-machine
  brew install docker
  brew install docker-compose
  brew install docker-squash
  ```
1. Create a Linux virtual machine named "default" in VirtualBox for building and testing containers
  ```
  docker-machine create -d virtualbox default
  ```
  Note: this also starts the virtual machine.

1. Set the environment variables in the current shell needed so the local docker command can communicate with the docker engine in the "default" virtual machine
  ```
  eval $(docker-machine env default)
  ```
Docker commands from the local (macos) command line will now execute on the docker engine running inside the "default" virtual machine.

## Stopping and restarting the "default" virtual machine
You can stop the "default" virtual machine with:</br>
```
docker-machine stop default
```
You can start the "default" virtual machine with:</br>
```
docker-machine start default
```
You can login to the "default" virtual machine if you want to run docker commands from the Linux command line with:</br>
```
docker-machine ssh
```
If you are in a new shell that does not have the necessary environment, run:</br>
```
eval $(docker-machine env default)
```
## Building an image from a Docker file
Change into the directory containing the ```Dockerfile``` (I'll use the "debansible" image in this example):</br>
```
cd debansible/
```
Next, run the docker build command specifying an appropriate repo and tag and passing the current directory ('.') as the first argument:</br>
```
docker build --rm --no-cache --build-arg username=ansible --build-arg password=password -t debansible:test .
```
Note, I use the tag "<image>:test" for testing.</br>
You can verify the new image is in the "default" virtual machine's image store with:</br>
```
docker images
```
From the same directory, you can launch a test container to see if the image works:</br>
```
docker-compose up -d
```
You can verify the container is running with:</br>
```
docker exec -it <container id> sh
```
If you created a container that accepts SSH connections, you can connect to the container via ssh:</br>
```
ssh -l ansible -p 2023 192.168.99.100
```
Note, the IP address belongs to the "default" virtual machine and port 2023 (or port specified in docker-compose.yml) is getting forwarded to port 22 within the test container.

When you're done testing, you can shutdown and remove the test container:</br>
```
docker-compose down
```

## Uploading new images to hub.docker.com
First, create a squashed image from the original to make it smaller:</br>
```
docker-squash -v -c -t dmbrownlee/debansible:latest debansible:test
```
Make sure you are logged into your hub.docker.com account:</br>
```
docker login
```
Then upload the squashed image:</br>
```
docker push dmbrownlee/debansible:latest
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

## Docker commands you might find useful
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
docker pull dmbrownlee/debansible:latest
```
Find out more about an image:</br>
```
docker inspect dmbrownlee/debansible:latest
```
See the history of the layers (not useful when squashed?):</br>
```
docker history dmbrownlee/debansible:latest
```
## There is also ```podman``` for MacOS
I need to look into this more someday...
```
brew install podman
podman machine init default2
podman machine start default2
podman machine list
podman images
podman container list
podman image search dmbrownlee
podman machine stop default2
```

