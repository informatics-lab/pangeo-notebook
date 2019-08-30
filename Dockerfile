FROM pangeo/pangeo-notebook:2019.08.26

#####################################################################
# Root                                                              #
#####################################################################

USER root

# Install system packages
RUN apt-get update -y && apt-get install -y \
    less \
    sudo \
    ssh \
    vim-tiny \
    libgl1-mesa-glx \
    texlive-xetex

RUN curl -L https://github.com/jacobtomlinson/krontab/releases/download/v0.1.6/krontab-linux-x86_64 -o /usr/local/bin/krontab && \
    chmod +x /usr/local/bin/krontab && \
    ln -s /usr/local/bin/krontab /usr/local/bin/crontab

# Add Tini - see https://github.com/krallin/tini#using-tini.
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

# Add USER to sudo
RUN echo "$USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/notebook
RUN sed -ri "s#Defaults\s+secure_path=\"([^\"]+)\"#Defaults secure_path=\"\1:$CONDA_DIR/bin\"#" /etc/sudoers

# Add prepare script for copying examples dir to single user homespaces.
COPY prepare_homespace.sh /usr/bin/prepare_homespace.sh
RUN chmod +x /usr/bin/prepare_homespace.sh

# Update conda
RUN conda update -n base conda --yes

#####################################################################
# User                                                              #
#####################################################################

USER $USER

# Install extra Python 3 packages
RUN conda install  -n notebook --yes \
    -c conda-forge \
    -c informaticslab \
    -c defusco \
    -c zeus1942 \
    awscli \
    "bokeh>=1.1.0" \
    boto3  \
    cartopy \
    contextily \
    "cryptography>=2.3" \
    dask \
    "dask-kubernetes>=0.8.0" \
    data_ncic_pangeo \
    "datashader>=0.6.8" \
    "distributed>=1.24.0" \
    fiona \
    fusepy \
    gdal \
    geopandas \
    geoviews \
    h5netcdf \
    "holoviews>=1.12.0" \
    hvplot \
    "intake>=0.4.2" \
    intake_dynamodb \
    intake_geopandas \
    "intake_hypothetic>=0.1.4" \
    intake_iris \
    intake_s3_manifests \
    ipyleaflet \
    iris \
    "iris_hypothetic>=0.1.8" \
    itkwidgets \
    jade_utils \
    jupyterlab \
    jupyter_dashboards \
    mo_pack \
    "mo_aws_earth>=0.2.3" \
    nbpresent \
    nbresuse \
    nc-time-axis \
    ncurses \
    papermill \
    "pandas>=0.23.4" \
    "panel>=0.5.1" \
    plotly \
    "pyviz_comms>=0.7.0" \
    qrcode \
    sidecar \
    voila \
    && conda clean --tarballs -y

# Install jupyter server extentions. Want to ensure we are doing this in the "notebook" env
SHELL ["/bin/bash", "-c"]
RUN source activate notebook && \
    jupyter labextension update --all && \
    jupyter labextension install \
    @informaticslab/henry \
    @jupyterlab/hub-extension \
    @jupyterlab/plotly-extension \
    @jupyter-widgets/jupyterlab-manager \
    @jupyter-widgets/jupyterlab-sidecar \
    @pyviz/jupyterlab_pyviz \
    dask-labextension \
    itk-jupyter-widgets \
    jupyterlab_bokeh \
    jupyter-leaflet

# Prepare script added above in the root commands section.
ENTRYPOINT ["/tini", "--", "/usr/bin/prepare_homespace.sh"]
