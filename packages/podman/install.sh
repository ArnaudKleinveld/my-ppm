# podman — override to include vfkit (missing from pdt-ppm, PR #3)

install_linux() {
  install_dep podman podman-compose
}

install_macos() {
  install_dep podman podman-compose vfkit

  if ! podman machine list --format "{{.Name}}" | grep -q "podman-machine-default"; then
    podman machine init
  fi

  if ! podman machine list --format "{{.Running}}" | grep -q "true"; then
    podman machine start
  fi
}


