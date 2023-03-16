#starting from debian jessie
FROM python:2.7.15-jessie

ARG installer=cplex_studio128.linux-x86-64.bin
ENV PYTHONPATH=/opt/ibm/ILOG/CPLEX_Studio128/cplex/python/2.7/x86-64_linux

#run installer then clean up
COPY $installer /cplex/cplex_installer.bin
COPY response.properties /cplex/response.properties
RUN chmod u+x /cplex/cplex_installer.bin
RUN /cplex/cplex_installer.bin -f /cplex/response.properties
RUN rm -rf /cplex

RUN pip install wheel
RUN pip install pandas
RUN pip install httplib2 
RUN pip install docplex
RUN pip install docloud
RUN pip install Cython


