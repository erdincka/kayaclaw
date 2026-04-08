FROM ubuntu:24.04

RUN apt update && apt upgrade -y
RUN apt install -y curl apt-utils fuse-overlayfs
# RUN curl -fsSL https://get.docker.com -o install-docker.sh && chmod +x install-docker.sh
RUN sh -c "curl -fsSL https://get.docker.com | bash"
# RUN install-docker.sh && sed -i 's/ulimit -Hn 524288/ulimit -n 524288/' /etc/init.d/docker
RUN sh -c "sed -i 's/ulimit -Hn 524288/ulimit -n 524288/' /etc/init.d/docker"

# RUN sh -c "curl -fsSL https://www.nvidia.com/nemoclaw.sh | bash"
RUN curl -fsSL https://nvidia.com/nemoclaw.sh -o /tmp/nemoclaw-install.sh
RUN sed -i 's/^  run_onboard$/# run_onboard (skipped)/' /tmp/nemoclaw-install.sh

EXPOSE 18789

COPY docker-entrypoint.sh /

# Enable fuse-overlayfs for docker-in-docker
COPY daemon.json /etc/docker

ENTRYPOINT [ "./docker-entrypoint.sh" ]
