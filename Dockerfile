FROM ubuntu
MAINTAINER neold2028

RUN apt update
RUN apt install curl -y
RUN curl https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh > Anaconda3-5.2.0-Linux-x86_64.sh
RUN echo "export PATH=\"/root/anaconda3/bin:\$PATH\"" >> /root/.bashrc
RUN export PATH="/root/anaconda3/bin:$PATH"
ENV PATH="/root/anaconda3/bin:${PATH}"
RUN bash Anaconda3-5.2.0-Linux-x86_64.sh -b
RUN /root/anaconda3/bin/jupyter notebook --generate-config
RUN cat /root/.jupyter/jupyter_notebook_config.py | sed "s/^#\?c\.NotebookApp\.ip *= *'.*'/c.NotebookApp.ip = '*'/" | sed "s/^#\?c\.NotebookApp\.open_browser *= .*/c.NotebookApp.open_browser = False/" > /root/.jupyter/jupyter_notebook_config_new.py && mv /root/.jupyter/jupyter_notebook_config_new.py /root/.jupyter/jupyter_notebook_config.py
RUN /root/anaconda3/bin/pip install tensorflow && /root/anaconda3/bin/pip install keras

ENTRYPOINT "jupyter" "notebook" "--allow-root"
