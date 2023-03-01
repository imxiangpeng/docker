# mxp, 20200819, add dockerfile

#FROM ubuntu:latest
FROM ubuntu:18.04

ARG U_NAME=admin
ARG U_ID=1000
ARG G_ID=1000

RUN groupadd -g $G_ID -o $U_NAME
RUN useradd -d /home/$U_NAME  -s /bin/bash -r -m -p 123456a! -u $U_ID -g $G_ID $U_NAME

# sed -i "s%http://archive.ubuntu.com/ubuntu/%http://mirrors.aliyun.com/ubuntu/%" /etc/apt/sources.list
#--no-install-recommends 
#gcc-aarch64-linux-gnu

RUN bash -c ' \
    dpkg --add-architecture i386 && \
    sed -i "s@http://.*archive.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list && \
    sed -i "s@http://.*security.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y  --no-install-recommends \
    git-core gnupg flex bison build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig doxygen python python3 wget libssl-dev bc cpio sqlite3 \
    u-boot-tools \
    uuid-dev liblzo2-dev gettext \
    libtool \
    doxygen \
    git tig \
    libssl-dev bc cpio \
    device-tree-compiler \
    rsync neovim vim dos2unix && \
    wget --no-check-certificate https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb -O /tmp/ripgrep.deb && dpkg -i /tmp/ripgrep.deb && rm /tmp/ripgrep.deb && \
    wget --no-check-certificate https://github.com/sharkdp/fd/releases/download/v8.7.0/fd_8.7.0_amd64.deb -O /tmp/fd.deb && dpkg -i /tmp/fd.deb && rm /tmp/fd.deb && \
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


USER $U_NAME

CMD ["/bin/bash"]
