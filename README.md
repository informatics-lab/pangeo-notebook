# pangeo-notebook

[![Build Status](https://travis-ci.com/informatics-lab/pangeo-notebook.svg?branch=master)](https://travis-ci.com/informatics-lab/pangeo-notebook)
[![Docker Image](https://img.shields.io/badge/docker-ready-blue.svg)](https://hub.docker.com/r/informaticslab/pangeo-notebook/)
[![Docker Layers](https://images.microbadger.com/badges/image/informaticslab/pangeo-notebook.svg)](https://microbadger.com/#/images/informaticslab/pangeo-notebook)
[![Docker Layers](https://img.shields.io/github/release/informatics-lab/pangeo-notebook.svg)](https://hub.docker.com/r/informaticslab/pangeo-notebook/tags/)

This image was previously called `singleuser-notebook`.

This is a docker image which contains [Jupyter Notebook](https://github.com/jupyter/notebook) and [Jupyter Lab](https://github.com/jupyterlab/jupyterlab) along with a sensible Python environment for performing environmental science analysis activities.

## Usage

### Local

You can run this image locally in docker. You should mount your home directory into the container, expose the jupyter port and run the `jupyter lab` command if you wish to use Jupyter Lab (the default is `jupyter notebook`).

```
docker run --rm -v $HOME:/home/jovyan -p 8888:8888 informaticslab/pangeo-notebook:latest jupyter lab
```

### Pangeo

Follow the instructions for installing the [Pangeo helm chart](https://github.com/pangeo-data/helm-chart) and be sure to set the following in your `values.yaml`.

```yaml
jupyterhub:
  singleuser:
    image:
      name: informaticslab/pangeo-notebook
      tag: 'latest'
```
