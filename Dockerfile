# to do a test build by hand (instead of the automated hub.docker.com build) you
# can do this:
#
#    docker build --rm --tag haas-sas .

FROM jupyter/datascience-notebook
USER root
RUN ln -s /bin/tar /bin/gtar
RUN /usr/bin/apt-get install unzip
RUN /opt/conda/bin/pip install --upgrade pip
RUN conda install -c conda-forge jupyter_contrib_nbextensions
RUN jupyter nbextension install --py widgetsnbextension --sys-prefix
RUN jupyter nbextension enable  --py widgetsnbextension --sys-prefix
RUN pip3 install oauthenticator
##
## This should allow users to turn off extension if they do not want them.
##
USER jovyan
RUN jupyter nbextensions_configurator enable
