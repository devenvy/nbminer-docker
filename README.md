Docker image for NBMiner with CUDA support.

docker

```
docker run --gpus 'all,capabilities=utility' -v ./config.json:/app/config.json -p 80:80 devenvy/nbminer
```

docker compose

```
version: "3.9"
services:
  nbminer_eth:
    image: devenvy/nbminer
    privileged: true
    ports:
      - "80:80" # this depends on what is in your config.json
    deploy:
      replicas: 1
      restart_policy:
        condition: any
      resources:
        reservations:
          devices:
          - driver: nvidia
            capabilities: [gpu, utility, video, compute]
    volumes:
      - ./config.json:/app/config.json
```
