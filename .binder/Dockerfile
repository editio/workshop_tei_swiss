FROM rocker/binder:4.0.3
LABEL maintainer='editio.github.io'
USER root
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}
USER ${NB_USER}



RUN wget https://github.com/editio/workshop_tei_swiss/raw/master/DESCRIPTION && R -e "options(repos = list(CRAN = 'http://mran.revolutionanalytics.com/snapshot/2020-10-21/')); devtools::install_deps()"

RUN rm DESCRIPTION.1; exit 0
