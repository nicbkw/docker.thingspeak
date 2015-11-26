# thingspeak.server for ARM architecture
ThingSpeak server (platform for IoT devices)

The original Dockerfile and docker-compose.yml have been update to run with ARM base images.

Expose :

tcp/3000: HTTP port

Run containers :

    docker-compose up -d

Init DB (just for first use):

    docker-compose run --rm web rake db:create
    docker-compose run --rm web rake db:schema:load
