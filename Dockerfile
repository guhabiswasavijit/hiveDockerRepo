FROM hadoop-3.3.1:1.1

MAINTAINER Avijit GuhaBiswas <guhabiswas.avijit@gmail.com>
ENV HIVE_VERSION=${HIVE_VERSION:-3.1.2}

ENV HIVE_HOME /opt/hive
ENV PATH $HIVE_HOME/bin:$PATH


WORKDIR /opt


RUN apt-get update && apt-get install -y wget procps && \
	wget https://archive.apache.org/dist/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz && \
	tar -xzvf apache-hive-$HIVE_VERSION-bin.tar.gz && \
	mv apache-hive-$HIVE_VERSION-bin hive
	
	
ADD conf/hive-site.xml $HIVE_HOME/conf
ADD conf/hive-env.sh $HIVE_HOME/conf
ADD conf/hive-log4j2.properties $HIVE_HOME/conf
ADD lib/mysql-connector-java-8.0.27.jar $HIVE_HOME/lib/mysql-connector-java-8.0.27.jar

EXPOSE 10000
CMD schematool -dbType mysql -initSchema &&\
	hiveserver2 --hiveconf hive.server2.enable.doAs=false
