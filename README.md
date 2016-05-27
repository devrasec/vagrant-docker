# Vagrant + Docker Web Development Environment

A vagrant machine with the tools you need to develop web applications with Docker.
I use it every day for development with Docker on my Mac.

**IMPORTANT NOTE:** I test this vagrant machine only on a Mac, I can't tell you
if this work on Windows.

The VM contains the following tools:

* Node
* Bower
* Grunt
* Gulp
* Composer
* You can install your own tools!

## REQUIREMENTS
* Vagrant 1.8.1+
* Ansible 2.0+
* nfsd (NFS server daemon) on the host
* NFS support on the guest machine
* Docker (if you want to use Docker client from the host)

## USAGE

Following are a set of steps that you need to do to start using this VM.

### Step 1

Copy or rename the file *example.config.yml* to *config.yml*. This file
contains settings to set the machine's IP address and synced folders options.

### Step 2

It's simple just `$ vagrant up`

### Step 3

In order to use Docker you need to SSH into the vm.

`$ vagrant ssh`

## Using Docker cli from the host

If you want to use Docker from the host you must uncomment the shell provision
in the Vagrantfile. That shell script do the necessary things to make the Docker
daemon in the vm to listen on port 2375. Then you need to set the environment
variable DOCKER_HOST on your host as seen in the following line.

`$ export DOCKER_HOST=tcp://VM_IP_ADDRESS:2375`

The ip address is specified in the config.yml file.

That's all! If everything is ok, the following command will print the version of
the Docker client and the Docker daemon on the terminal.

`$ docker version`

## Synced folders

Documentation pending...

If you have questions or something, you can contact me at luiscon26@gmail.com.

[@darktmac](http://bit.ly/1RDynUF)