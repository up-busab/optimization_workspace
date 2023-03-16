#following https://github.com/SG2B/gurobi
#FROM python:3.6.10-alpine
FROM python:3.6.10

ARG GUROBI_MAJOR_VERSION=9.0
ARG GUROBI_VERSION=9.0.0
ARG GUROBI_DIR=gurobi900
ARG user=youser
ARG group=youser
ARG uid=1000
ARG gid=1000

ENV GUROBI_INSTALL /opt/gurobi
ENV GUROBI_HOME $GUROBI_INSTALL/linux64
ENV USER_HOME /home/${user}/

ENV PATH $PATH:$GUROBI_HOME/bin/:${USER_HOME}/.local/bin/
ENV LD_LIBRARY_PATH $GUROBI_HOME/lib

RUN addgroup --gid ${gid} ${group}                                                                      
RUN adduser --system --disabled-password --home ${USER_HOME} --uid ${uid} --gid ${gid} --shell /bin/bash ${user} 

# Install latest glibc
# export GLIBC_VERSION=2.23-r3                                                                                                  
# apk --no-cache add ca-certificates                                                                                            
# wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub 
# wget -P /tmp https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk       
# wget -P /tmp https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk   
# wget -P /tmp https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-i18n-${GLIBC_VERSION}.apk  
# apk add /tmp/glibc-${GLIBC_VERSION}.apk /tmp/glibc-bin-${GLIBC_VERSION}.apk /tmp/glibc-i18n-${GLIBC_VERSION}.apk              
#/usr/glibc-compat/bin/localedef -i en_US -f UTF-8 en_US.UTF-8                                                                  
# Install gurobi

RUN mkdir -p ${GUROBI_INSTALL}                                                                                      
RUN wget -q -P ${USER_HOME} http://packages.gurobi.com/${GUROBI_MAJOR_VERSION}/gurobi${GUROBI_VERSION}_linux64.tar.gz 
RUN tar xfz ${USER_HOME}/gurobi${GUROBI_VERSION}_linux64.tar.gz                                                    
RUN mv /${GUROBI_DIR}/linux64/ ${GUROBI_INSTALL}                                                                    

#COPY scripts/docker-entrypoint.sh ${GUROBI_HOME}/bin

RUN cd ${GUROBI_HOME} && python3 setup.py install

RUN # Clean up
RUN rm -rf ${GUROBI_HOME}/docs                             
RUN rm -rf ${GUROBI_HOME}/examples                         
RUN rm -rf ${GUROBI_HOME}/src                              
RUN rm -rf /tmp/*                                          
RUN rm -rf /var/log/*                                      
RUN rm -rf /${GUROBI_DIR}                                  
RUN rm ${USER_HOME}/gurobi${GUROBI_VERSION}_linux64.tar.gz 

# Set permissions
RUN chown -R youser ${GUROBI_HOME}

WORKDIR /usr/src/gurobi/scripts

RUN pip install wheel
RUN pip install pandas
RUN pip install httplib2 
RUN pip install portalocker 
RUN pip install psutil
RUN pip install openpyxl

RUN pip install docplex
RUN pip install docloud

RUN pip install networkx
RUN pip install sklearn
RUN pip install distance

USER youser

