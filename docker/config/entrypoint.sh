## change ownwer from home
chown -R USER:USER /home/USER

## Configure DoH
printf 'nameserver 127.0.0.1' >/etc/resolv.conf
cloudflared --config /etc/cloudflared/config.yaml proxy-dns >/dev/null 2>&1 &

## Update username if different to USER
if [ "$USERNAME" != "USER" ];then
        mv /home/USER /home/${USERNAME}
        perl -pi -e 'BEGIN{$newuser=$ENV{"USERNAME"}}s/USER/$newuser/g' /etc/group /etc/passwd /etc/shadow /etc/sudoers.d/unprivileged
fi

## Eject tmux and zsh process
su -l ${USERNAME} -g ${USERNAME} -s /usr/bin/tmux
