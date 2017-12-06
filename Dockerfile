FROM jupyter/scipy-notebook:c7fb6660d096

# Root
USER root
RUN apt-get update -y && apt-get install -y libfuse-dev

USER jovyan

# Python 3 packages
RUN conda install -y boto3
RUN conda install -y -c scitools iris cartopy
RUN conda install -y dask distributed
RUN conda install -y -c conda-forge jupyter_contrib_nbextensions jupyter_dashboards nbpresent

# s3-fuse
RUN conda install -c bioconda -c anaconda -c conda-forge  -y fusepy boto3


RUN bash -c "conda create -y -n python2 python=2.7.14 anaconda"

# Python 2 packages
RUN bash -c "source activate python2 && \
             conda install -y -c scitools iris cartopy"
RUN bash -c "source activate python2 && pip install ipykernel && python -m ipykernel install --user"

# SHARPpy - https://github.com/sharppy/SHARPpy
RUN bash -c "source activate python2 && \
                conda install -y PySide"
RUN bash -c "source activate python2 && \
                pip install git+git://github.com/sharppy/SHARPpy.git@47ab1a683a631506be9770ad4b68e36e1268a5b7"

# R
RUN conda install -y -c r r-essentials

#Clojure
# RUN update-ca-certificates -f
# RUN curl -k https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > /usr/local/bin/lein
# RUN apt-get update
# RUN chmod +x /usr/local/bin/lein
# RUN apt-get install -y default-jre
# RUN git clone https://github.com/roryk/clojupyter
# RUN mkdir -p /etc/pki/tls/certs && ln -s /etc/ssl/certs/ca-certificates.crt /etc/pki/tls/certs/ca-bundle.crt
# RUN apt-get -y install make cmake
# RUN cd clojupyter && make && make install && cd .. && rm -rf clojupyter


# Scala
# RUN curl -L -o coursier https://git.io/vgvpD && chmod +x coursier && mv ./coursier /bin/
# RUN curl -L -o jupyter-scala https://git.io/vrHhi && \
#     chmod +x jupyter-scala && \
#     ./jupyter-scala && rm -f jupyter-scala

# custom JADE extions
RUN pip install --upgrade git+https://github.com/met-office-lab/jade_utils
RUN bash -c "source activate python2 && pip install --upgrade git+https://github.com/met-office-lab/jade_utils"
