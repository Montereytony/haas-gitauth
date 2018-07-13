#
#
#
#  manual build   docker build --rm --tag haas-gitauth .
#

FROM jupyter/datascience-notebook
USER root
#
RUN ln -s /bin/tar /bin/gtar
RUN /usr/bin/apt-get install unzip
RUN ln -s /usr/lib/git-core/git-pull /usr/local/bin
RUN /opt/conda/bin/pip install --upgrade pip
RUN conda install -c conda-forge jupyter_contrib_nbextensions 
RUN conda install -c conda-forge jupyter_nbextensions_configurator
RUN jupyter nbextension enable --py jupyter_contrib_nbextensions --sys-prefix

USER jovyan
RUN jupyter nbextension install --py widgetsnbextension --sys-prefix
RUN jupyter nbextension enable  --py widgetsnbextension --sys-prefix
RUN pip3 install oauthenticator
#
RUN pip3 install nbgitpuller
RUN jupyter serverextension enable --sys-prefix nbgitpuller
RUN jupyter serverextension enable --py nbgitpuller --sys-prefix
#
#
RUN pip3 install git+https://github.com/data-8/nbinteract.git
RUN pip3 install nbinteract
RUN jupyter nbextensions_configurator enable --user
#
#
#
#RUN jupyter nbextension install --py nbinteract
#RUN jupyter nbextensions_configurator enable
##
## This should allow users to turn off extension if they do not want them.
##
