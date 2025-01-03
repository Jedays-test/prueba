FROM jenkins/jenkins:lts
 #https://updates.jenkins.io/download/plugins/
 #docker build -t jenkins .
 #docker run  -p "80:8080" jenkins
USER root

RUN apt-get update -qq \
    && apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common 
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
RUN apt-get update  -qq \
    && apt-get install docker-ce=17.12.1~ce-0~debian -y


RUN apt install awscli -y
RUN apt-get install python3-pip -y
RUN pip3 install --upgrade awscli
RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
RUN apt install nodejs
RUN usermod -aG docker jenkins