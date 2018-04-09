# singleuser-notebook

[![Docker Image](https://img.shields.io/badge/docker-ready-blue.svg)](https://hub.docker.com/r/informaticslab/singleuser-notebook/) [![Docker Layers](https://images.microbadger.com/badges/image/informaticslab/singleuser-notebook.svg)](https://microbadger.com/#/images/informaticslab/singleuser-notebook)

This is a docker image which containers [Jupyter Notebook](https://github.com/jupyter/notebook) and [Jupyter Lab](https://github.com/jupyterlab/jupyterlab) along with a sensible Python envirnoment for performing environmental science analysis activities.

## Usage

### Local

You can run this image locally in docker. You should mount your home directory into the container, expose the jupyter port and run the `jupyter lab` command if you wish to use Jupyter Lab (the default is `jupyter notebook`).

```
docker run --rm -v $HOME:/home/jovyan -p 8888:8888 informaticslab/singleuser-notebook:0.3.4 jupyter lab
```

### Pangeo

Follow the instructions for installing the [Pangeo helm chart](https://github.com/pangeo-data/helm-chart) and be sure to set the following in your `values.yaml`.

```yaml
jupyterhub:
  singleuser:
    image:
      name: informaticslab/singleuser-notebook
      tag: '0.3.4'
```
