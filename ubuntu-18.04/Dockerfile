# mxp, 20200819, add dockerfile

#FROM ubuntu:latest
FROM ubuntu:18.04

ARG U_NAME=admin
ARG U_ID=1000
ARG G_ID=1000

# sed -i "s%http://archive.ubuntu.com/ubuntu/%http://mirrors.aliyun.com/ubuntu/%" /etc/apt/sources.list
#--no-install-recommends 
#gcc-aarch64-linux-gnu

RUN bash -c ' \
    dpkg --add-architecture i386 && \
    sed -i "s@http://.*archive.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list && \
    sed -i "s@http://.*security.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    apt-utils \
    git-core gnupg flex bison build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig doxygen python python3 wget libssl-dev bc cpio sqlite3 \
    bison sed perl gperf gawk unzip zlib1g-dev xsltproc \
    u-boot-tools \
    uuid-dev liblzo2-dev gettext \
    libtool \
    doxygen \
    git \
    libssl-dev bc cpio \
    device-tree-compiler \
    autoconf automake pkg-config \
    mtd-utils squashfs-tools libtool\
    python3-pip \
    lib32stdc++6 \
    sudo rsync neovim vim dos2unix && \
    apt install gcc-aarch64-linux-gnu -y && \
    apt-get install -qy openssh-server && sed -i "s|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g" /etc/pam.d/sshd && mkdir -p /var/run/sshd && \
    wget -q --no-check-certificate https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb -O /tmp/ripgrep.deb && dpkg -i /tmp/ripgrep.deb && rm /tmp/ripgrep.deb && \
    wget -q --no-check-certificate https://github.com/sharkdp/fd/releases/download/v8.7.0/fd_8.7.0_amd64.deb -O /tmp/fd.deb && dpkg -i /tmp/fd.deb && rm /tmp/fd.deb && \
    wget -q --no-check-certificate https://raw.githubusercontent.com/GerritCodeReview/git-repo/main/repo -O /usr/local/bin/repo && chmod 755 /usr/local/bin/repo && \
    wget -q -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | sudo tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null && \
    echo "deb https://apt.kitware.com/ubuntu/ bionic main" > /etc/apt/sources.list.d/kitware.list && \
    apt-get update && apt-get install -y cmake && \
    apt-get autoremove --purge -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /var/log/* /var/tmp/* /tmp/* \
    '

# /etc/hosts is readonly
#RUN bash -c ' \
#    cat >> /etc/hosts << EOF \
#10.110.1.41 mcv.inspur.com \
#10.30.11.113 pms.inspur.com \
#10.180.88.99 ott.inspur.com \
#EOF'


#RUN "dpkg-reconfigure dash <<EOF
#no
#EOF"

RUN bash -c ' \
    groupadd -g $G_ID -o $U_NAME && \
    useradd -d /home/$U_NAME  -s /bin/bash -r -m -p 342b937d -u $U_ID -g $G_ID -G sudo $U_NAME && \
    echo $U_NAME:342b937d | chpasswd \
    '
    


USER $U_NAME

ADD entrypoint.sh /

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
