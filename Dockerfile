# Build a container with sbt, SpinalHDL, and Verilator for building, linting,
# and testing FPGA designs.

# sbt provides nice images already
FROM sbtscala/scala-sbt:eclipse-temurin-25.0.1_8_1.12.2_2.12.21

# verilator does too but it's easier to just build it here
# (BEGIN section modified from Dockerfile for verilator/verilator)
RUN apt update && apt install --no-install-recommends -y autoconf bc bison build-essential ca-certificates ccache flex git help2man libfl2 libfl-dev libgoogle-perftools-dev numactl perl perl-doc python3 zlib1g zlib1g-dev && apt clean -y
WORKDIR /tmp
ARG REPO=https://github.com/verilator/verilator
ARG SOURCE_COMMIT=v5.044
RUN git clone "${REPO}" verilator && cd verilator && git checkout "${SOURCE_COMMIT}" && autoconf && ./configure && make -j `nproc` && make install && cd .. && rm -r verilator && ccache -C
# (END section modified from Dockerfile for verilator/verilator)

# prefetch SpinalHDL and other dependencies
COPY ./build.sbt .
RUN sbt clean
RUN rm ./build.sbt

# TODO(jmeifert): CMD is probably redundant
# (BEGIN section modified from Dockerfile for sbtscala/scala-sbt)
WORKDIR /root
CMD ["sbt"]
# (END section modified from Dockerfile for sbtscala/scala-sbt)
