FROM jupyter/r-notebook:66c99628f4b8

RUN python3 -m pip install jupyter-rsession-proxy
RUN cd /tmp/ && \
    git clone --depth 1 https://github.com/jupyterhub/jupyter-server-proxy && \
    cd jupyter-server-proxy/jupyterlab-server-proxy && \
    npm install && npm run build && jupyter labextension link . && \
    npm run build && jupyter lab build

USER root

ENV RSTUDIO_URL https://download2.rstudio.org/rstudio-server-1.1.453-amd64.deb
ENV RSTUDIO_CHECKSUM 3c546fa9067f48ed1a342f810fca8be6

# install Rstudio dependencies
RUN apt-get -qq update --yes && \
    apt-get -qq install -yes \
    libapparmor1 \
    libedit2 \
    lsb-release \
    libssl1.0.0 \
    libgdal-dev \
    libproj-dev \
    psmisc 

# install rstudio
RUN curl --silent --location --fail ${RSTUDIO_URL} > /tmp/rstudio.deb && \
    echo "${RSTUDIO_CHECKSUM} /tmp/rstudio.deb" | md5sum -c - && \
    dpkg -i /tmp/rstudio.deb && \
    rm /tmp/rstudio.deb && \
    rm -rf /var/lib/apt/lists/*

USER $NB_USER

ENV PATH=$PATH:/usr/lib/rstudio-server/bin
ENV LD_LIBRARY_PATH="/usr/lib/R/lib:/lib:/usr/lib/x86_64-linux-gnu:/usr/lib/jvm/java-7-openjdk-amd64/jre/lib/amd64/server:/opt/conda/lib/R/lib"
