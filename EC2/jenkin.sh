#! /bin/bash

curl -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
yum upgrade -y
# Add required dependencies for the jenkins package
yum install fontconfig java-17-openjdk -y
yum install jenkins
systemctl daemon-reload
systemctl enable jenkins
systemctl start jenkins