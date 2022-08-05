# dotfiles

```
curl https://raw.githubusercontent.com/elhmn/dotfiles/main/install.sh | bash
```

# How to run a local dev environment

The local dev environment is based on docker.

### Build the dev-container

```console
docker build .  -t dev-container
```

You can build without cache using

```console
docker build .  -t dev-container --no-cache
```

### Run the dev-container with a volume

```console
docker run --rm -v "$(echo $HOME)/local-dev:/home/user/local-dev" -p 80:80 -p 8080:8080 -p 3000-3010:3000-3010 -P -dt dev-container
```


### Exec in the container and use it for your development

```console
docker exec -it $(docker ps | grep dev-container | head -n1 | cut -d " " -f 1) /bin/bash
```

Note: if `:GoInstallBinaries` does not work try adding the `export GOBIN=$GOPATH/bin` to your `.zshrc` or `.bashrc`
