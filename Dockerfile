FROM python:3

ENV DEBIAN_FRONTEND=noninteractive

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

ENV PIP_TARGET=/usr/local/share/pip-global
ENV PYTHONPATH=${PYTHONPATH}:${PIP_TARGET}
ENV PATH=${PATH}:${PIP_TARGET}/bin

RUN apt-get update \
    && apt-get -y install --no-install-recommends apt-utils dialog 2>&1 \
    && apt-get -y install git iproute2 procps lsb-release \
    && pip --disable-pip-version-check --no-cache-dir install pylint \
    && groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME\
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && mkdir -p /usr/local/share/pip-global \
    && chown ${USERNAME}:root /usr/local/share/pip-global \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /home/vscode/work \
ENV DEBIAN_FRONTEND=dialog