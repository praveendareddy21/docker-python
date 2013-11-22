# Python 3 environment
#
# Version 0.0.1

FROM ubuntu

MAINTAINER Wiliam Souza <wiliamsouza83@gmail.com>

ENV LANG en_US.UTF-8

# Change to the your project name
ENV PROJECT "myproject"

# Add universe 
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get install -y python-software-properties
RUN apt-get install -y wget

# Python3.3
RUN add-apt-repository ppa:fkrull/deadsnakes -y

# Upgrade
RUN apt-get update
RUN apt-get upgrade -y

# Dependencies
RUN apt-get install -y python3.3
RUN apt-get install -y python3.3-dev


# Source
ADD . /srv/@{PROJECT}
RUN cd /srv/@{PROJECT}

# Virtual environment
# Uncomment the following line to run inside a venv.
#pyvenv-3.3 /srv/@{PROJECT}
#source /srv/@{PROJECT}/bin/activate

# Setuptools
RUN wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
RUN python3.3 ez_setup.py

# Pip
RUN wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py
RUN python3.3 get-pip.py

# Project requirements
RUN pip-3.3 install -r /srv/@{PROJECT}/requirements/production.txt

EXPOSE 8000 

CMD ["python3.3", "/srv/@{PROJECT}/start.py"]
