FROM centos:6.10

RUN yum update -y && yum upgrade -y && yum install -y openssh-server chpasswd
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN cp /etc/localtime /root/old.timezone
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Moscow /etc/localtime

RUN yum install tcpdump mc wget vim git -y

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"

RUN echo "export VISIBLE=now" >> /etc/profile
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -q -P ""
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -q -P "" 


EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
