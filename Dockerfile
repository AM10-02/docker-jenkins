FROM jenkins/jenkins:2.176.2

# プラグインのインストール
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

USER root

ENV JAVA_OPTS=-Duser.timezone=Asia/Tokyo
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN apt-get update \
	&& apt-get install -y sudo git ruby make maven vim

# Jenkinsの設定ファイルのコピー
# overwriteだと起動時に毎回更新されるため、直接コピーします
COPY config.xml /var/jenkins_home/config.xml
COPY scriptApproval.xml /var/jenkins_home/scriptApproval.xml
COPY hudson.tasks.Mailer.xml /var/jenkins_home/hudson.tasks.Mailer.xml

COPY jobs /usr/share/jenkins/ref/jobs

USER jenkins
