# random-json-logger

Docker image for a random JSON log generator, based on Alpine Linux.

## What is this?

This image will execute a container which will generate four random log messages:

``` json
{"timestamp": "2018-03-02T22:33:27", "level":"ERROR", "hostname":"my-host", "message": "something happened in this execution."}
{"timestamp": "2018-03-02T22:33:27", "level":"INFO", "hostname":"my-host", "message": "takes the value and converts it to string."}
{"timestamp": "2018-03-02T22:33:27", "level":"WARN", "hostname":"my-host","message": "variable not in use."}
{"timestamp": "2018-03-02T22:33:27", "level":"DEBUG", "hostname":"my-host", "message": "first loop completed."}
```

## How to add an extra field to logs?

You can add an custom field to JSON logs by setting the `CUSTOM_KEY` and `CUSTOM_VAL` environment variables. Let's assume we set the keys as `CUSTOM_KEY=user` and `CUSTOM_VAL=$USER`. The result would be like:

``` json
{"timestamp": "2024-09-24T15:51:31", "level": "INFO", "hostname": "my-host", "user": "debman", "message": "takes the value and converts it to string."}
{"timestamp": "2024-09-24T15:51:33", "level": "ERROR", "hostname": "my-host", "user": "debman", "message": "something happened in this execution."}
{"timestamp": "2024-09-24T15:51:43", "level": "WARN", "hostname": "my-host", "user": "debman", "message": "variable not in use."}
```

Another sample could be using this field as the node name of the pod in a kubernetes cluster, assuming running this image as a pod, you can inject the node name as below:

``` yaml
apiVersion: apps/v1
kind: Deployment
# ...
spec:
  # ...
  template:
    # ...
    spec:
      containers:
      - name: log-generator
        # ...
        image: ghcr.io/debman/random-json-logger:latest
        env:
          - name: CUSTOM_KEY
            value: node
          - name: CUSTOM_VAL
            valueFrom:
              fieldRef:
                fieldPath: spec.nodeName
```

And the output is:

``` json
{"timestamp": "2024-09-24T15:51:31", "level": "INFO", "hostname": "my-host", "node": "worker-1", "message": "takes the value and converts it to string."}
{"timestamp": "2024-09-24T15:51:33", "level": "ERROR", "hostname": "my-host", "node": "worker-1", "message": "something happened in this execution."}
{"timestamp": "2024-09-24T15:51:43", "level": "WARN", "hostname": "my-host", "node": "worker-1", "message": "variable not in use."}
```

It seems interesting, not?

## Why this Image?

I've had the necessity to create a random json logger to test log configurations with containers, this helped me out to do it easily.

## What is inside of this repo?

In this git repository you will find the docker image definitions for the random json Logger for Alpine Linux

* `Dockerfile` -> Contains image definition.
* `entrypoint.sh` -> Shell code to generate log messages.

## How do I use this image?

To use this image you must do as follows:

```bash
# you can use tags latest
docker pull idebman/random-json-logger:latest

# to run the image just execute
docker run -d idebman/random-json-logger:latest
```

You will have now a docker container running and generating json log messages, locate it running:

```bash
docker ps
```

You can see the logs using this command

```bash
docker logs <- container-id ->
```

## How do I build this images?

First things first, you can find these docker images in `sikwan/random-json-logger`
but you can also build a specific version on your own, you only need:

* docker
* git

Clone this repo

`git clone https://github.com/debMan/random-json-logger.git`

Go to the folder in your terminal and type this:

```bash
# cd into folder
cd random-json-logger
# Then build the new image
docker build -f Dockerfile .
```

If you want to tag your image use the following command

```bash
docker build -f Dockerfile -t yourbase/yourname:version .
```

---
For more on docker build reference to the [Documentation](https://docs.docker.com/engine/reference/commandline/build/)

You can get the source from the image in the [Repository](https://github.com/debMan/random-json-logger)
