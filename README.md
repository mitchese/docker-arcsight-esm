ESM 6.9.1 Docker Image
======================

This provides ArcSight ESM 6.9.1 in a docker container. Because ESM is not open source, this
repository cannot include the binaries or license from HP. See instructions below for info
on how to build and use this container.

Everything assumes the hostname is docker-esm; To change the hostname you'll need to edit
a few of the provided answers files, and replace all "docker-esm" instances with your desired
hostname.

How to build
============

Note that the installation requires at least 50Gb of storage free. Ensure that your build
environment has enough space. It isn't actually used, however the installer verifies
and will fail if <50G is free.

Additionally this has to be built in two layers, as the arcsight installer can't find the
firstboot answers file. The only way I can get this to work is to split into two.

1. Copy the ESM 6.9.1 binary from HP into midlayer/ArcSightESMSuite-6.9.1.2022.0.tar
2. Copy your license file into the midlayer/arcsight.lic
3. Run "docker build -t midlayer ." in the midlayer folder
4. Run "docker build -t mitchese/private:esm691 ." in the finallayer folder

How to run
==========
1. Run the following command:
   docker run -ti --name docker-esm -h docker-esm -p 8443:8443 mitchese/private:esm691
2. In the command line, start all arcsight services:
   /etc/init.d/arcsight_services start

This will take a few minutes to startup (requires >4G of ram). After it is running, you can
connect to https://docker-esm:8443/ with "admin" and "Happy123". All passwords in the container
are set to my test password, Happy123. 

How to connect connectors
=========================

For testing connector containers, you can provide a link in docker. Example

docker run --link docker-esm:docker-esm -ti mitchese/private:connector bash


