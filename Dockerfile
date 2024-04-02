FROM python:3.9-slim-bullseye

LABEL maintainer="Couchbase"

WORKDIR /app
# Requirements need to be copied over manually as volumes are not created until the container is run
COPY requirements.txt /app

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    libssl-dev \
    jq curl

RUN pip install -r requirements.txt

# Expose ports
EXPOSE 8080

COPY . .

ARG CB_HOST
ENV CB_HOST=CB_HOST
ARG CB_USER
ENV CB_USER=CB_USER
ARG CB_PSWD
ENV CB_PSWD=CB_PSWD

# Set the entrypoint
CMD python travel.py -c $CB_HOST -u $CB_USER -p $CB_PSWD
