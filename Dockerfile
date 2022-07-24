FROM ubuntu:18.04
RUN apt-get update
RUN apt-get install sudo
RUN sudo apt install python3 -y
RUN sudo apt update
RUN sudo apt install software-properties-common -y
RUN sudo add-apt-repository --yes --update ppa:ansible/ansible
RUN sudo apt-get install ansible -y
RUN sed -i.bkp '17c\remote_tmp = ~/tmp' /etc/ansible/ansible.cfg
RUN sed -i.bkp '18c\local_tmp = ~/tmp' /etc/ansible/ansible.cfg
RUN sed -i.bkp '259c\retry_files_save_path = ~/ansible-retry' /etc/ansible/ansible.cfg
RUN sed -i.bkp '381c\control_path_dir = /tmp/ansible/cp' /etc/ansible/ansible.cfg
RUN adduser useraws --uid 1000
RUN usermod -aG sudo useraws
USER 1000