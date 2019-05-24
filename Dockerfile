FROM pangeo/pangeo-notebook:2019.05.19

#####################################################################
# Root                                                              #
#####################################################################

USER root

# Install system packages
RUN apt-get update -y && apt-get install -y \
    less \
    sudo \
    ssh \
    libgl1-mesa-glx \
    texlive-xetex

RUN curl -L https://github.com/jacobtomlinson/krontab/releases/download/v0.1.6/krontab-linux-x86_64 -o /usr/local/bin/krontab && \
    chmod +x /usr/local/bin/krontab && \
    ln -s /usr/local/bin/krontab /usr/local/bin/crontab


#####################################################################
# User                                                              #
#####################################################################

USER $NB_USER

# Install extra Python 3 packages
RUN conda install  -n notebook --yes \
    -c conda-forge \
    -c informaticslab \
    -c creditx \
    -c zeus1942 \
    bokeh>=1.1.0 \
    boto3  \
    cartopy \
    contextily \
    cryptography>=2.3 \
    data_ncic_pangeo \
    datashader>=0.6.8 \
    distributed>=1.24.0 \
    fiona \
    fusepy \
    gdal \
    geopandas \
    geoviews \
    holoviews>=1.12.0 \
    hvplot \
    intake>=0.4.2 \
    intake_dynamodb \
    intake_geopandas \
    intake_hypothetic \
    intake_iris \
    intake_s3_manifests \
    ipyleaflet \
    iris \
    iris_hypothetic \
    itkwidgets \
    jade_utils \
    jupyterlab>=0.35.6 \
    jupyter_dashboards \
    mo_pack \
    mo_aws_earth>=0.1.2 \
    nbpresent \
    nc-time-axis \
    ncurses \
    pandas>=0.23.4 \
    plotly \
    pyviz_comms>=0.7.0 \
    voila \
    papermill \
    dask-kubernetes>=0.8.0 \
    nbresuse \
    sidecar \
    awscli \
    && conda clean --tarballs -y

# Install jupyter server extentions. Want to ensure we are doing this in the "notebook" env
SHELL ["/bin/bash", "-c"]
RUN source activate notebook && \
    jupyter labextension update --all && \
    jupyter labextension install \
    @informaticslab/henry \
    @jupyterlab/hub-extension \
    @jupyterlab/plotly-extension \
    @jupyterlab/statusbar \
    @jupyter-widgets/jupyterlab-manager \
    @jupyter-widgets/jupyterlab-sidecar \
    @pyviz/jupyterlab_pyviz \
    dask-labextension \
    itk-jupyter-widgets \
    jupyterlab_bokeh \
    jupyter-leaflet
