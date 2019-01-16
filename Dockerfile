FROM pangeo/notebook:78d567a

#####################################################################
# Root                                                              #
#####################################################################

USER root

# Install system packages
RUN apt-get update -y && apt-get install -y \
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
    -c bioconda \
    -c informaticslab \
    -c intake \
    -c pyviz \
    bokeh>=0.13.0 \
    boto3  \
    cartopy \
    contextily \
    cryptography>=2.3 \
    data_ncic_pangeo \
    datashader==0.6.8 \
    distributed>=1.24.0 \
    fiona \
    fusepy \
    gdal \
    geopandas \
    hvplot \
    intake>=0.2.7 \
    intake_dynamodb \
    intake_geopandas \
    intake_iris \
    intake_s3_manifests \
    ipyleaflet \
    iris \
    jade_utils==0.1.7 \
    jupyterlab==0.34.5 \
    jupyter_dashboards \
    mo_pack \
    nbpresent \
    nc-time-axis \
    ncurses \
    pandas>=0.23.4 \
    plotly \
    pyviz_comms>=0.7.0 \
    && conda clean --tarballs -y

RUN pip install --upgrade \
    awscli \
    dask_kubernetes==0.6.0 \
    nbresuse \
    sidecar \
    papermill

# Install jupyter server extentions
RUN jupyter labextension update --all
RUN jupyter labextension install \
    @jupyterlab/hub-extension \
    @jupyterlab/plotly-extension \
    @jupyterlab/statusbar \
    @jupyter-widgets/jupyterlab-sidecar \
    @pyviz/jupyterlab_pyviz \
    dask-labextension \
    jupyterlab_bokeh \
    jupyter-leaflet

# Add Pete's fork of iris with lazy RMS 3/8/18. Remove after Iris 2.2.
RUN pip install --upgrade \
    https://github.com/dkillick/iris/archive/lazy_rms_agg.zip
