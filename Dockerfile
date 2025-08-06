FROM debian:12-slim AS base

# Install dependencies
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
 && apt-get -y dist-upgrade --no-install-recommends \
 && apt-get install -y --no-install-recommends \
        curl python3 clang valgrind \
        libclang-common-14-dev libclang-rt-14-dev \
        gcc gdb jq python3-pip busybox

# Install dcc + dcc-help
COPY src /opt/dcc-help
RUN bash /opt/dcc-help/build.sh

ENV PATH="/opt/dcc-help/lib:/usr/local/bin:/usr/bin/:$PATH"

FROM base AS ollama
COPY . .
# Install ollama
RUN curl -fsSL https://ollama.com/install.sh | sh \
 && python3 -m pip install --break-system-packages ollama

WORKDIR "/workspace"
