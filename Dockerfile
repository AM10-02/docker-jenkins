FROM jenkins/jenkins:2.176.2

# プラグインのインストール
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

USER root

RUN apt-get update \
	&& apt-get install -y sudo git ruby make maven

# Jenkinsの設定ファイルのコピー
COPY config.xml /usr/share/jenkins/ref/

COPY jobs/declarative_sample/config.xml /usr/share/jenkins/ref/jobs/declarative_sample/config.xml
COPY jobs/scripted_sample/config.xml /usr/share/jenkins/ref/jobs/scripted_sample/config.xml

USER jenkins
