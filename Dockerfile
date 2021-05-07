FROM opensourcery/debian:buster-slim
LABEL maintainer "open.source@opensourcery.uk"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
 && apt-get dist-upgrade -y \
 && apt-get install -y acl attr samba samba-dsdb-modules samba-vfs-modules winbind krb5-config krb5-user dnsutils xattr \
 && apt-get clean \
 && rm /etc/samba/smb.conf \
 && rm -r /var/lib/apt/lists/*

ADD entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh \
 && mkdir /entrypoint.d

EXPOSE 88 88/udp 135 137/udp 138/udp 139 389 389/udp 445 464 464/udp 636 3268 3269 49152-65535

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/samba", "-i"]
