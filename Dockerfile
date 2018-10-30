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
    -c scitools \
    -c bioconda \
    -c informaticslab \
    -c intake \
    -c pyviz \
    jupyterlab==0.34.5 \
    boto3  \
    bokeh>=0.13.0 \
    cartopy \
    distributed==1.24.0 \
    plotly \
    fusepy \
    hvplot \
    iris \
    intake==0.2.7 \
    intake_iris \
    intake_s3_manifests \
    intake_dynamodb \
    ipyleaflet \
    nc-time-axis \
    jupyter_dashboards \
    nbpresent \
    cryptography>=2.3 \
    jade_utils \
    data_ncic_pangeo \
    mo_pack \
    && conda clean --tarballs -y

RUN pip install --upgrade \
    nbresuse \
    sidecar

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
