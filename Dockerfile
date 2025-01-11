FROM ubuntu:24.04

RUN mkdir -p /ros2_ws/src/ros2_uv_template
WORKDIR /ros2_ws/src/ros2_uv_template
COPY ./ ./

# Setup dependencies
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    locales \
    git \
    curl \
    make \
    software-properties-common \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

# Setup locale
RUN locale-gen en_US en_US.UTF-8 \
&& update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8

# Install ros2
RUN add-apt-repository universe \
&& apt-get update \
&& curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key \
    -o /usr/share/keyrings/ros-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" \
    | tee /etc/apt/sources.list.d/ros2.list > /dev/null \
&& apt-get update && apt-get upgrade -y \
&& apt-get install -y \
    ros-dev-tools \
    ros-jazzy-ros-base \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* \
&& echo "source /opt/ros/jazzy/setup.bash" >> ~/.bashrc \
&& echo 'if [ -f /ros2_ws/install/setup.bash ]; then \
source /ros2_ws/install/setup.bash; \
fi' >> ~/.bashrc

# Setup uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/
ENV UV_LINK_MODE=copy
RUN echo 'eval "$(uv generate-shell-completion bash)"' >> ~/.bashrc \
&& make venv

# Console setup
WORKDIR /ros2_ws
CMD [ "bash" ]