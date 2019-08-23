FROM jupyter/r-notebook

LABEL maintainer="Tania Allard trallard@bitsandchips.me"

USER root

ENV DEBIAN_FRONTEND noninteractive 

# install Rstudio and packages
RUN apt-get update \
    && apt-get install -y gdebi-core \
    && wget https://download2.rstudio.org/server/bionic/amd64/rstudio-server-1.2.1335-amd64.deb \
    && sudo gdebi rstudio-server-1.2.1335-amd64.deb \
    && apt-get install -y --no-install-recommends \
    libapparmor1 \
    libedit2 \
    lsb-release \
    psmisc \
    libssl1.0.0 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# install Pyton3 packages
RUN conda install --quiet --yes \
    'numpy' \
    'pandas' \
    'matplotlib' \
    'r-reticulate' \
    && conda clean --all -f -y \
    && conda install -yq -c conda-forge nbrsessionproxy \
    && conda clean -tipsy 

ENV PATH=$PATH:/usr/lib/rstudio-server/bin
ENV LD_LIBRARY_PATH="/usr/lib/R/lib:/lib:/usr/lib/x86_64-linux-gnu:/usr/lib/jvm/java-7-openjdk-amd64/jre/lib/amd64/server:/opt/conda/lib/R/lib"

USER $NB_USER