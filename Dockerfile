FROM pangeo/pangeo-notebook:2019.02.10

#####################################################################
# Root                                                              #
#####################################################################

USER root

# Install system packages
RUN apt-get update -y && apt-get install -y \
    sudo \
    ssh \
    libgl1-mesa-glx \
    texlive-xetex


#####################################################################
# User                                                              #
#####################################################################

USER $NB_USER

# Install extra Python 3 packages
RUN conda install --yes \
    -c conda-forge \
    -c informaticslab \
    bokeh>=0.13.0 \
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
    holoviews \
    hvplot \
    intake>=0.4.2 \
    intake_dynamodb \
    intake_geopandas \
    intake_iris \
    intake_s3_manifests \
    ipyleaflet \
    iris \
    itkwidgets \
    jade_utils \
    jupyterlab>=0.34.5 \
    jupyter_dashboards \
    mo_pack \
    nbpresent \
    nc-time-axis \
    ncurses \
    pandas>=0.23.4 \
    plotly \
    pyviz_comms>=0.7.0 \
    voila \
    && conda clean --tarballs -y

RUN pip install --upgrade \
    awscli \
    dask_kubernetes \
    nbresuse \
    papermill \
    sidecar

# Install jupyter server extentions
RUN jupyter labextension update --all
RUN jupyter labextension install \
    @jupyterlab/hub-extension \
    @jupyterlab/plotly-extension \
    @jupyterlab/statusbar \
    @jupyter-widgets/jupyterlab-manager \
    @jupyter-widgets/jupyterlab-sidecar \
    @pyviz/jupyterlab_pyviz \
    dask-labextension \
    itk-jupyter-widgets \
    jupyterlab_bokeh \
    jupyter-leaflet \
    @informaticslab/henry
