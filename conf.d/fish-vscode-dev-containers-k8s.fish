# fish2.2

if test "$SYNC_LOCALHOST_KUBECONFIG" = true \
    -a -d /usr/local/share/kube-localhost
  mkdir -p "$HOME/.kube"
  sudo cp -r /usr/local/share/kube-localhost/* "$HOME/.kube"
  sudo chown -R (id -u) "$HOME/.kube"
  sed -i -e s/localhost/host.docker.internal/g "$HOME/.kube/config"

  if test -e /usr/local/share/minikube-localhost/ca.crt \
      -a -e /usr/local/share/minikube-localhost/client.crt \
      -a -e /usr/local/share/minikube-localhost/client.key
    mkdir -p "$HOME/.minikube"
    sudo cp /usr/local/share/minikube-localhost/ca.crt "$HOME/.minikube"
    sudo cp /usr/local/share/minikube-localhost/client.crt "$HOME/.minikube"
    sudo cp /usr/local/share/minikube-localhost/client.key "$HOME/.minikube"
    sudo chown -R (id -u) "$HOME/.minikube"
    sed -i -r "s|(\s*certificate-authority:\s).*|\\1$HOME\/.minikube\/ca.crt|g" "$HOME/.kube/config"
    sed -i -r "s|(\s*client-certificate:\s).*|\\1$HOME\/.minikube\/client.crt|g" "$HOME/.kube/config"
    sed -i -r "s|(\s*client-key:\s).*|\\1$HOME\/.minikube\/client.key|g" "$HOME/.kube/config"
  end
end
