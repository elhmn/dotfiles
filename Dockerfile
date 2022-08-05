FROM ubuntu:focal

#Create user `user`
RUN useradd -ms /bin/bash user

#Delete `user` password
RUN passwd -d user

#Add sudo privilige to `user`
RUN usermod -aG sudo user

RUN apt-get update
RUN apt -y install curl dirmngr apt-transport-https lsb-release ca-certificates
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
git \
sudo \
wget \
neovim \
make \
zsh

# Install yarn
USER user
WORKDIR /user/dotfiles
COPY . ./
RUN ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ""
RUN ./install.sh
RUN sudo npm install -g yarn

# We are exposing a range of 11 ports that can later be used for, to run your applications.
# To check what localhost port these ports are bound to, use the `docker ps` or `docker port <container>` commands
EXPOSE 3000-3010

# We expose common ports
EXPOSE 80
EXPOSE 8080

ENTRYPOINT ["./entrypoint.sh"]
# RUN sudo deluser user sudo
