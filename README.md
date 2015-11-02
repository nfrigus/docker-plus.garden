plus.garden docker
==================


## Usage

1. Test remote service:
  
  mount garden folder to garden container and run it with `test` command:

        docker run --rm -tv $YOUR_PROJECT_GARDEN_DIR:/app nfrigus/plus.garden test

  npm dependencies will be installed if required.

2. Test another container:

  can be done by using `--link`:

        docker run --rm --link $YOUR_CONTAINER_ID:$HOSTNAME -tv $YOUR_PROJECT_GARDEN_DIR:/app nfrigus/plus.garden test

3. Generate garden project:

        docker run --rm -tv $DIR_TO_GENERATE:/app nfrigus/plus.garden init
