FROM ubuntu

RUN apt-get update
RUN apt-get -y install gcc clang build-essential wget unzip 

#get udpipe code
WORKDIR /udpipe
RUN wget -q https://github.com/ufal/udpipe/archive/master.zip && unzip -q master.zip && rm -f master.zip 
WORKDIR /udpipe/udpipe-master/src

#make udpipe server
RUN make server

WORKDIR /udpipe/udpipe-master/src/rest_server

#add language model
ADD models/fi_20180111.model .
ADD models/se_20180112.model .

EXPOSE 8080

#start udpipe REST server
#add language models to be started with server
CMD ./udpipe_server 8080 fi \
fi ./fi_20180111.model "Finnish model trained 2018-01-11 using https://github.com/UniversalDependencies/UD_Finnish" \
se ./se_20180112.model "Swedish model trained 2018-01-11 using https://github.com/UniversalDependencies/UD_Swedish"

#CMD ["/bin/bash"]

