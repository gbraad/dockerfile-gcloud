FROM debian:jessie
MAINTAINER Gerard Braad <me@gbraad.nl>

RUN apt-get update && apt-get install -y \
        wget \
        python2.7 \
    && \
    rm -rf /var/lib/apt/lists/* && \
    ln -s /usr/bin/python2.7 /usr/bin/python

RUN mkdir -p /workspace && \
    mkdir -p /google && \
    cd /google && \
    wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-146.0.0-linux-x86_64.tar.gz && \
    tar zxvf google-cloud-sdk-146.0.0-linux-x86_64.tar.gz &&\
    /google/google-cloud-sdk/install.sh && \
    ln -s /google/google-cloud-sdk/bin/gcloud /usr/bin/gcloud && \
    rm -f google-cloud-sdk-146.0.0-linux-x86_64.tar.gz && \
    gcloud components install kubectl && \
    gcloud components update

#ENV PATH /google/google-cloud-sdk/bin/bin:$PATH

WORKDIR /workspace

ENTRYPOINT ["/usr/bin/gcloud"]

