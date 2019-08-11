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
COPY --chown=jenkins:jenkins config.xml ${JENKINS_HOME}/config.xml
COPY --chown=jenkins:jenkins jenkins.model.JenkinsLocationConfiguration.xml ${JENKINS_HOME}/jenkins.model.JenkinsLocationConfiguration.xml
COPY --chown=jenkins:jenkins scriptApproval.xml ${JENKINS_HOME}/scriptApproval.xml
COPY --chown=jenkins:jenkins hudson.tasks.Mailer.xml ${JENKINS_HOME}/hudson.tasks.Mailer.xml

COPY jobs /usr/share/jenkins/ref/jobs

COPY --chown=jenkins:jenkins m2/settings.xml ${JENKINS_HOME}/.m2/settings.xml

USER jenkins
