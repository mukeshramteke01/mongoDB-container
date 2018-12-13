FROM centos
MAINTAINER MukeshRahulRamteke@fico.com

RUN yum install epel-release -y

RUN touch /etc/yum.repos.d/mongodb-org.repo

RUN echo [mongodb-org-4.0] >> /etc/yum.repos.d/mongodb-org.repo
RUN echo name=MongoDB Repository >> /etc/yum.repos.d/mongodb-org.repo
RUN echo baseurl=https://repo.mongodb.org/yum/redhat/7Server/mongodb-org/4.0/x86_64/ >> /etc/yum.repos.d/mongodb-org.repo
RUN echo gpgcheck=1 >> /etc/yum.repos.d/mongodb-org.repo
RUN echo enabled=1 >> /etc/yum.repos.d/mongodb-org.repo
RUN echo gpgkey=https://www.mongodb.org/static/pgp/server-4.0.asc >> /etc/yum.repos.d/mongodb-org.repo

RUN yum install mongodb-org -y

CMD systemctl start mongod; systemctl enable mongod
