# Python_meets_R
🐍🤖 Tutorial on using R and Python together


## Pre-requisites

You will need to have the following installed:
- [Rstudio](https://www.rstudio.com/products/rstudio/) 1.2 recommended
- [Anaconda 3](https://www.anaconda.com/distribution/) 

Additional packages:
- reticulate (CRAN) (we recommend doing `devtools::install_github("rstudio/reticulate")
`)
- tidyverse
- readxl
- matplotlib
- scikit-learn
- pandas
- numpy

You can, alternatively, build and run the Docker image in [./deployments/jupyterhub-cluster/image/Dockerfile](./deployments/jupyterhub-cluster/image/Dockerfile)

```sh 
$ cd deployments/jupyterhub-cluster/image/

$ docker build --rm -f "Dockerfile" -t <username>/jupyter-rserver:tag
```

Then to run:

```sh
$ docker run --rm -it -p 8888:8888/tcp -e JUPYTER_ENABLE_LAB=yes <username>/jupyter-rserver:tag
```
This will spin a Jupyter server with all the dependencies and packages needed including Rstudio server.


## Tutorial materials
Download this repository. You can do this with the green Clone or download button above and selecting Download ZIP.

Extract the files.

