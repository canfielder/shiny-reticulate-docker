FROM rocker/shiny-verse:latest

RUN apt-get update && \
    apt-get install libcurl4-openssl-dev libv8-3.14-dev -y &&\
    mkdir -p /var/lib/shiny-server/bookmarks/shiny
    
# Download and install library
RUN R -e "install.packages(c('shinydashboard', 'reticulate', 'shiny', 'numpy'))"

# Link Python3 and Pip3 to Python/Pip
RUN ln -s /usr/bin/python3 /usr/bin/python && \
    ln -s /usr/bin/pip3 /usr/bin/pip

## update system libraries
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean
 
# Copy Shiny App Files to Docker Image   
COPY app ./app

# Shiny Default Port
EXPOSE 3838

CMD ["R", "-e", shiny::runApp('/app', host = '0.0.0.0', port = 3838)"]