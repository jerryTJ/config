FROM ubuntu:latest

# 设置环境变量，防止交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 更新系统并安装 Ansible 及相关依赖
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    apt-add-repository --yes --update ppa:ansible/ansible && \
    apt-get install -y ansible sshpass && \
    apt-get clean

# 创建 Ansible 目录
RUN mkdir -p /etc/ansible/

# 设置默认工作目录
WORKDIR /ansible

# 复制 inventory 文件
COPY inventory /etc/ansible/hosts

# 复制 Ansible Playbook（如果有）
COPY playbook.yml /ansible/playbook.yml

# 运行 Ansible 命令
CMD ["ansible-playbook", "/ansible/playbook.yml"]
