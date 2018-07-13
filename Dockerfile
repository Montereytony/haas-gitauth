# to do a test build by hand (instead of the automated hub.docker.com build) you
# can do this:
#
#    docker build --rm --tag haas-gitauth .
#

FROM jupyter/datascience-notebook
USER root
RUN ln -s /bin/tar /bin/gtar
RUN /usr/bin/apt-get install unzip
RUN /opt/conda/bin/pip install --upgrade pip
RUN conda install -c conda-forge jupyter_contrib_nbextensions
RUN jupyter nbextension install --py widgetsnbextension --sys-prefix
RUN jupyter nbextension enable  --py widgetsnbextension --sys-prefix
RUN pip3 install oauthenticator
RUN pip3 install nbgitpuller
RUN jupyter serverextension enable --py nbgitpuller --sys-prefix
RUN pip3 install git+https://github.com/data-8/nbpuller.git
#
RUN jupyter serverextension enable --py nbpuller
RUN jupyter nbextension install --py nbpuller
RUN jupyter nbextension enable --py nbpuller
RUN jupyter nbextensions_configurator enable
RUN jupyter serverextension enable --sys-prefix nbgitpuller
##
## This should allow users to turn off extension if they do not want them.
##
USER jovyan
