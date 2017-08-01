FROM midlayer:latest

RUN su -c '/opt/arcsight/manager/bin/arcsight firstbootsetup -boxster -soft -f "/tmp/firstboot_responses.txt" -i silent' arcsight

RUN /opt/arcsight/manager/bin/setup_services.sh

RUN rm /tmp/installer_responses.txt /tmp/arcsight.lic /tmp/firstboot_responses.txt /tmp/ArcSightESMSuite.bin

ENTRYPOINT /bin/bash
