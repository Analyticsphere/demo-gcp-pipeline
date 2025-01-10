# Load base image
FROM rocker/tidyverse:latest

# Set the correct path for xelatex
ENV PATH="$PATH:/root/bin:/usr/local/lib"

# Install tinytex linux dependencies, pandoc, and rmarkdown
# Reference: https://github.com/csdaw/rmarkdown-tinytex/blob/master/Dockerfile
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    wget \
    graphviz \ 
    imagemagick \
    perl && \
    /rocker_scripts/install_pandoc.sh && \
    install2.r rmarkdown 
    
# Install tinytex
RUN Rscript -e 'tinytex::install_tinytex(repository = "illinois")'

# Install R libraries
RUN install2.r --error plumber bigrquery dplyr glue googleCloudStorageR gargle tools 

# Copy R code to working directory in container
COPY ./plumber_api.R .
COPY ./report_iris.Rmd .
COPY ./report_penguins.Rmd .
COPY ./report_participant_count.Rmd .

# Run R code
ENTRYPOINT ["R", "-e", "pr <- plumber::plumb('plumber_api.R'); pr$run(host='0.0.0.0', port=as.numeric(Sys.getenv('PORT')))"]