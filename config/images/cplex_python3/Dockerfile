#starting from debian jessie
FROM python:3.6.8-jessie

ARG installer=cplex_studio128.linux-x86-64.bin
ENV PYTHONPATH=/opt/ibm/ILOG/CPLEX_Studio128/cplex/python/3.6/x86-64_linux

ENV PATH=":${PATH}:/opt/ibm/ILOG/CPLEX_Studio128/cpoptimizer/bin/x86-64_linux"

#run installer then clean up
COPY $installer /cplex/cplex_installer.bin
COPY response.properties /cplex/response.properties
RUN chmod u+x /cplex/cplex_installer.bin
RUN /cplex/cplex_installer.bin -f /cplex/response.properties
RUN rm -rf /cplex

RUN pip install wheel
RUN pip install pandas
RUN pip install httplib2 
RUN pip install portalocker

RUN pip install docplex
RUN pip install docloud

RUN pip install networkx
RUN pip install sklearn
RUN pip install distance

