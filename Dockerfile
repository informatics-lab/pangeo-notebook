FROM pangeo/notebook:2d5c8b4

#####################################################################
# Root                                                              #
#####################################################################

USER root

# Install system packages
RUN apt-get update -y && apt-get install -y ssh

# Install jupyter server extentions
RUN jupyter labextension install @jupyterlab/hub-extension jupyterlab_bokeh


#####################################################################
# User                                                              #
#####################################################################

USER $NB_USER

# Install extra Python 3 packages
RUN conda install --yes \
    -c conda-forge \
    -c scitools \
    -c bioconda \
    boto3  \
    cartopy \
    fusepy \
    iris \
    jupyter_dashboards \
    nbpresent \
    && conda clean --tarballs -y

# RUN pip install --upgrade \
#     git+https://github.com/met-office-lab/jade_utils

# Install R
RUN conda install --yes \
    -c r \
    r-essentials \
    && conda clean --tarballs -y
