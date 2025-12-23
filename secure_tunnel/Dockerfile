
FROM ubuntu:latest

# 安装 OpenSSH 和一些必要的工具
RUN \
    sed -i "s@http://.*archive.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list.d/ubuntu.sources && \
    sed -i "s@http://.*security.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list.d/ubuntu.sources && \
    apt-get update && \
    apt-get install -y --no-install-recommends  openssh-server \
    sudo \
    lsof \
    && rm -rf /var/log/* /var/cache/apt/*


# 创建用户并设置密码
RUN deluser ubuntu
RUN useradd -m miniadm -s /bin/bash && echo "miniadm:'TT&7lv>8H6j" | chpasswd && usermod -aG sudo miniadm
RUN useradd -m user -s /sbin/nologin && echo "user:dc9e1e80a5b8" | chpasswd

# 创建 SSH 目录并设置权限
RUN mkdir /home/miniadm/.ssh && chown miniadm:miniadm /home/miniadm/.ssh && \
    echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC2F7+0Ewp8aJGbIJ4DdX4as/rH6lNPtFwj4NCbcYam4wi/YgCrHlSkL1WXUH4YjXkpleM9lHMc/9SBI04y8P/KRNhVUumBzGAFh5YXLIU79xxYXFlI4ChKGfWA9pXuVm3MMDCXf8UO50OdSkISIC5hvD2b6ZaYIaYCJqk7bO8sWTk6qSv56UsMfo3xEq09ic8l8/Ctk3CrbTiPL1BeWdYf0yVT1FrG2XyIRWdwc9BOjuGGs2MRAs+f/9GVkDxqcrrFu3jnmpgpj3CiHt9CS6+Kmvmt00LYoHLLvyvM1vu+uIANAAqQRGQ1eypjSACyAN3q075xqOZgHZ7Q1nhnMiqX mengxp@inspur.com" >> /home/miniadm/.ssh/authorized_keys


RUN mkdir /home/user/.ssh && chown user:user /home/user/.ssh

# 复制 SSH 公钥（如果使用密钥认证）
# 将你的公钥复制到容器中
COPY files/user/id_ecdsa /home/user/.ssh/
COPY files/user/id_ecdsa.pub /home/user/.ssh/
COPY files/user/authorized_keys /home/user/.ssh/
RUN chown user:user /home/user/.ssh/id_ecdsa && chmod 600 /home/user/.ssh/id_ecdsa
RUN chown user:user /home/user/.ssh/id_ecdsa.pub && chmod 644 /home/user/.ssh/id_ecdsa.pub
RUN chown user:user /home/user/.ssh/authorized_keys && chmod 600 /home/user/.ssh/authorized_keys

# 启用 SSH 服务
# RUN ssh-keygen -A  # 生成 SSH host 密钥
COPY files/host/ssh_host_* /etc/ssh/
RUN chmod 600 /etc/ssh/ssh_host_* && chmod 644 /etc/ssh/ssh_host_*.pub

# 使用 sed 修改 /etc/ssh/sshd_config 配置
RUN sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config \
    && sed -i 's/^#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config \
    && sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config \
    && sed -i '/^#MaxAuthTries/d' /etc/ssh/sshd_config \
    && echo 'MaxAuthTries 3' >> /etc/ssh/sshd_config \
    && sed -i '/^#Protocol/d' /etc/ssh/sshd_config \
    && echo 'Protocol 2' >> /etc/ssh/sshd_config \
    && sed -i 's/^#PrintMotd yes/PrintMotd no/' /etc/ssh/sshd_config \
    && sed -i '/^#AllowUsers/d' /etc/ssh/sshd_config \
    && echo 'AllowUsers miniadm user' >> /etc/ssh/sshd_config

# 暴露 22 端口
EXPOSE 22

RUN mkdir -p /run/sshd

# 启动 SSH 服务
CMD ["/usr/sbin/sshd", "-D"]

