# dotfiles

```
curl https://raw.githubusercontent.com/elhmn/dotfiles/main/install.sh | bash
```

# How to run a local dev environment

The local dev environment is based on docker.

### Build the dev-container

```bash
docker build .  -t dev-container
```

### Run the dev-container with a volume

```bash
docker run --rm -v "$(echo $HOME)/local-dev:/home/user/local-dev" -p 3000:3000 -dt dev-container
```


### Exec in the container and use it for your development

```bash
docker exec -it $(docker ps | grep dev-container | head -n1 | cut -d " " -f 1) /bin/bash
```
