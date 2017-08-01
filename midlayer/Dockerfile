FROM centos:centos7
MAINTAINER sean.mitchell@cspi.com

COPY 90-nproc.conf /etc/security/limits.d/90-nproc.conf
COPY redhat-release /etc/redhat-release
COPY installer_responses.txt /tmp/installer_responses.txt
COPY arcsight.lic /tmp/arcsight.lic
COPY firstboot_responses.txt /tmp/firstboot_responses.txt

RUN yum install -y ping pciutils iputils unzip bind-utils tzdata zip xhost iproute &&\
    groupadd arcsight && useradd -g arcsight -d /home/arcsight -m -s /bin/bash arcsight  &&\
    mkdir /opt/arcsight && chown arcsight /opt/arcsight

COPY ArcSightESMSuite-6.9.1.2022.0.tar /tmp
#COPY ArcSightESMSuite.bin /tmp/ArcSightESMSuite.bin

ENTRYPOINT /bin/bash
RUN ln -s /usr/lib64/libpcre16.so.0 /usr/lib64/libpcre.so.0 && cd /tmp && tar -xvf ArcSightESMSuite-6.9.1.2022.0.tar 
RUN su -c '/tmp/ArcSightESMSuite.bin -i silent -f /tmp/installer_responses.txt' arcsight
#arcsight managersetup -g > /opt/mysetup.file (generates sample to edit)
#arcsight managersetup -i silent -f /opt/mysetup.file (configures system from file)
COPY hostname_ping.sh /opt/arcsight/manager/bin/scripts/hostname_ping.sh
RUN echo "127.0.0.1 docker-esm" >> /etc/hosts
#RUN su -c '/opt/arcsight/manager/bin/arcsight firstbootsetup -boxster -soft -f "/tmp/firstboot_responses.txt" -i silent' arcsight
#RUN /opt/arcsight/manager/bin/setup_services.sh
#RUN rm /tmp/installer_responses.txt /tmp/arcsight.lic /tmp/firstboot_responses.txt /tmp/ArcSightESMSuite.bin

