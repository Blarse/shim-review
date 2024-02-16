## (c)2024 Egor Ignatov <egori@altlinux.org>
## Create an ALT docker image for reproducible build of shim binaries
FROM alt:sisyphus

# install required packages
RUN apt-get update && \
    apt-get install -y \
    vim-console git patch make gcc binutils libelf-devel dos2unix xxd wget openssl gnupg2

RUN useradd builder
USER builder
WORKDIR /home/builder

# copy shim binaries provided for review
RUN mkdir shim-review
COPY shimia32.efi shimx64.efi shim-review

# copy our CA certificate
COPY altlinux-ca.cer shim-review

# copy our SBAT file
COPY sbat.altlinux.csv shim-review

# copy our patches
COPY shim-patches shim-review

# download upstream traball
RUN wget https://github.com/rhboot/shim/releases/download/15.8/shim-15.8.tar.bz2 \
    && tar -xjvf shim-15.8.tar.bz2
WORKDIR shim-15.8

# apply our patches
RUN for i in $(ls ~/shim-review/*.patch); do patch -p1 < $i; done

# put our sbat.csv
RUN cp -f ~/shim-review/sbat.altlinux.csv data/sbat.csv

# avoid BuildMachine difference breaking resulting sha256sum after we changed
# "rpmbuild" to just "make"
# https://github.com/rhboot/shim-review/issues/156#issuecomment-819631537
ENV SOURCE_DATE_EPOCH=foo

# build shimia32.efi and shimx64.efi
RUN mkdir -p build-ia32 build-x64
RUN cd build-ia32 && \
    make VENDOR_CERT_FILE=/home/builder/shim-review/altlinux-ca.cer TOPDIR=.. \
    DISABLE_REMOVABLE_LOAD_OPTIONS=1 \
    ARCH=ia32 -f ../Makefile 2>&1 | tee /home/builder/build-ia32.log

RUN cd build-x64 && \
    make VENDOR_CERT_FILE=/home/builder/shim-review/altlinux-ca.cer TOPDIR=.. \
    DISABLE_REMOVABLE_LOAD_OPTIONS=1 \
    -f ../Makefile 2>&1 | tee /home/builder/build-x64.log

# get back to home directory containing log files now for potential manual review
# shim-15.8/ - rebuild tree based on upstream tarball
# shim-review/ - submitted files and comparison results
WORKDIR /home/builder
RUN sha256sum shim-review/*.efi shim-15.8/build-*/shim*.efi
