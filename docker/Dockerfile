FROM debian:latest

LABEL maintainer='edeluquez@hotmail.com'
LABEL vendor='Ernesto Deluquez Heilbron'
LABEL source='https://github.com/edelux/zsh'
LABEL description='Docker image for DevOps whit zsh, tmux and vim Environment'

ENV  DEBIAN_FRONTEND noninteractive
ENV  DEBCONF_NOWARNINGS yes

#    Repository setup and package update
RUN  apt update && apt -y reinstall ca-certificates && apt install -y apt-transport-https curl gpg git && \
     perl -pi -e 's/http:/https:/g' /etc/apt/sources.list.d/debian.sources && \
     perl -pi -e 's/main/main contrib non-free non-free-firmware/g' /etc/apt/sources.list.d/debian.sources && \
     apt list --upgradable && apt update && apt -y upgrade && apt install -y sudo man-db manpages info locales locales-all util-linux-locales && \
     locale-gen en_US.UTF-8

#    DoH
COPY config/doh-config.yaml /etc/cloudflared/config.yaml
RUN  curl -s https://pkg.cloudflare.com/cloudflare-main.gpg | gpg --dearmor >/usr/share/keyrings/cloudflare-main.gpg && \
     printf '%s\n' 'Types: deb' 'URIs: https://pkg.cloudflare.com/cloudflared' 'Suites: bookworm' 'Components: main' \
     'Signed-By: /usr/share/keyrings/cloudflare-main.gpg' >/etc/apt/sources.list.d/cloudflared.sources && \
     apt update && apt install -y cloudflared

#    Install vim, tmux, zsh and configugure the environment
ENV  USERUID   1000
ENV  USERNAME  USER

COPY config/vimrc /etc/skel/.vimrc
COPY config/zshrc /etc/skel/.zshrc
COPY config/zshenv /etc/skel/.zshenv
COPY config/zlogout /etc/skel/.zlogout
COPY config/tmux.conf  /etc/skel/.tmux.conf
RUN  groupadd -g ${USERUID} ${USERNAME} && \
     apt install -y zsh vim tmux fonts-fork-awesome fonts-font-awesome zsh-antigen zsh-autosuggestions zsh-syntax-highlighting zsh-theme-powerlevel9k && \
     printf 'USER ALL=(ALL:ALL) NOPASSWD: ALL' >/etc/sudoers.d/unprivileged && chmod 440 /etc/sudoers.d/unprivileged && \
     rm -f /etc/skel/.profile /etc/skel/.bashrc /etc/skel/.bash_logout /root/.profile /root/.bashrc /root/.bash_logout && \
     printf '%s\n' 'LANG=en_US.UTF-8' 'LC_ALL=en_US.UTF-8' 'LANGUAGE=en_US.UTF-8' >/etc/default/locale && \
     perl -pi -e 's/(^.+)(en_US.UTF-8.+)/\2/g' /etc/locale.gen && locale-gen && update-locale && \
     perl -pi -e 's/(mouse)(=[an])/\1-\2/g' /usr/share/vim/vim*/defaults.vim

#    Lastly add user and trow trash
RUN  useradd -m -px -u ${USERUID} -c ${USERNAME} -g ${USERNAME} -s /usr/bin/zsh ${USERNAME} && \
     perl -pi -e 's/bash/sh/g' /etc/passwd && perl -ni -e 'print unless /bash/' /etc/shells && \
     apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#    Configure entrypoint
COPY config/entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
