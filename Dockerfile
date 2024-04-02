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

RUN ls -lh

# Set the entrypoint
CMD ["python", "travel.py"]
