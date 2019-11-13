# DockerSSH
DockerSSH Centos 6.10

Build <code>docker build -t docker_ssh .</code>
<br>
Run <code>docker run -p 222:22 -d --name centos_ssh docker_ssh</code>
<br>
Remove <code>docker container stop centos_ssh && docker container rm centos_ssh  && docker image rm docker_ssh</code>
