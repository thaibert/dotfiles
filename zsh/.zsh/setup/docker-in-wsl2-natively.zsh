# More or less stolen from https://docs.docker.com/config/daemon/remote-access/
#
# To get the maven target jib:dockerBuild to build (also through intellij -> powershell -> docker),
# the `docker` binary (not the docker engine) is needed.
# This can be installed from https://docs.docker.com/engine/install/binaries/#install-server-and-client-binaries-on-windows
# The Path on windows needs to be updated to point to this binary.
# I did both System EnvVar and User EnvVar ("Edit the system environment variables").
# I placed the `docker` executable at C:\Program Files\docker\docker and added C:\Program Files\docker to the Path.
# 
# The Windows System EnvVar `DOCKER_HOST` needed to be set to `localhost:2375`.
#
# Moreover, the /etc/docker/daemon.json file was added with .hosts = [<unix socket>, "tcp://127.0.0.1:2375"]
# This means the docker daemon listens over TCP as well as the standard unix socket.
#
# Note: arguments to `dockerd` can be passed in /etc/init.d/docker as DOCKER_OPTS
#

if grep -q "microsoft" /proc/version > /dev/null 2>&1; then
    if service docker status 2>&1 | grep -q "is not running"; then
        echo "Starting docker service..."
        wsl.exe \
          --distribution "${WSL_DISTRO_NAME}" \
          --user root \
          --exec /usr/sbin/service \
          docker start > /dev/null 2>&1
        echo "Started docker service!"
    fi
fi

