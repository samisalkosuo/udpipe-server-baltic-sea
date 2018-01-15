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
ADD models/sv_20180112.model .
ADD models/lv_20180115.model .
ADD models/et_20180115.model

EXPOSE 8080

#start udpipe REST server
#add language models to be started with server
CMD ./udpipe_server 8080 fi \
fi ./fi_20180111.model "Finnish model trained 2018-01-11 using https://github.com/UniversalDependencies/UD_Finnish" \
sv ./sv_20180112.model "Swedish model trained 2018-01-11 using https://github.com/UniversalDependencies/UD_Swedish" \
lv ./lv_20180115.model "Latvian model trained 2018-01-15 using https://github.com/UniversalDependencies/UD_Latvian" \
et ./et_20180115.model "Estonian model trained 2018-01-15 using https://github.com/UniversalDependencies/UD_Estonian"


#CMD ["/bin/bash"]

