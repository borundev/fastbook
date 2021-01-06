FROM ubuntu:21.04
RUN apt-get update
RUN apt-get install -y git
RUN apt-get install -y wget


RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN bash Miniconda3-latest-Linux-x86_64.sh -b -p /miniconda
ENV PATH=/miniconda/bin:$PATH
COPY packages packages

RUN conda env update -f packages/environment.yml
RUN jupyter kernelspec remove -f python3

RUN git clone https://github.com/fastai/fastbook.git ./fastbook
RUN conda env create -f fastbook/environment.yml
SHELL ["conda","run","-n","fastbook","/bin/bash","-c"]
RUN python -m ipykernel install --name python3 --display-name "Python 3"
RUN pip install fastbook

SHELL ["/bin/bash","-c"]

RUN rm -rf packages
RUN rm -rf fastbook
RUN rm Miniconda3-latest-Linux-x86_64.sh

RUN mkdir -pv /etc/ipython/
COPY ipython/ipython_config.py /etc/ipython/ipython_config.py

# install jupyter extensions
RUN pip install -U jupyter_contrib_nbextensions
RUN pip install -U jupyter_nbextensions_configurator
RUN pip install -U jupyter
RUN pip install -U ipywidgets

# enable jupyter extensions
RUN jupyter contrib nbextension install
RUN jupyter nbextensions_configurator enable

# turn on extensions
RUN jupyter nbextension enable collapsible_headings/main
RUN jupyter nbextension enable rubberband/main
RUN jupyter nbextension enable toc2/main
RUN jupyter nbextension enable codefolding/main
RUN jupyter nbextension enable scratchpad/main
RUN jupyter nbextension enable --py widgetsnbextension

ENV NB_USER feynman
ENV NB_UID 1000

RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER

WORKDIR /home/${NB_USER}
USER $NB_USER

RUN git clone https://github.com/fastai/fastbook.git ./fastbook
WORKDIR /home/${NB_USER}/fastbook

EXPOSE 8888
ENTRYPOINT ["jupyter", "notebook", "--no-browser", "--ip=0.0.0.0","--NotebookApp.token=''", "--NotebookApp.password=''"]
