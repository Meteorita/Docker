# Use ubuntu-18 as parent image
FROM dokken/ubuntu-18.04
# Install requried libraries
RUN apt-get update && apt-get install -y build-essential libncurses5-dev zlib1g-dev libbz2-dev
RUN apt-get install -y liblzma-dev 
# Make dir for softwares
RUN mkdir /soft
# Create environment
ENV SOFT_ENV="${SOFT_ENV}"
# Set working directory
WORKDIR /soft
# Load samtools-1.10 tarball of last release
RUN wget https://github.com/samtools/samtools/releases/download/1.10/samtools-1.10.tar.bz2
# Uncompress and clean
RUN tar xjvf samtools-1.10.tar.bz2
RUN rm samtools-1.10.tar.bz2
# Move the source files to new folder
RUN mv samtools-1.10 samtools-1.10-src
# Make dir where samtools will be installed
RUN mkdir samtools-1.10
# Install samtools 
WORKDIR samtools-1.10-src
RUN ./configure --prefix=/soft/samtools-1.10
RUN make
RUN make install
WORKDIR /soft
# Update PATH
ENV PATH "$PATH:/soft/samtools-1.10/bin"
ENV SAMTOOLS "$PATH:/soft/samtools-1.10/bin/samtools"
# Install git
RUN apt-get install -y git
# Load, install and clean last release of libmaus2
RUN wget https://github.com/gt1/libmaus2/archive/2.0.499-release-20180606122508.tar.gz
RUN tar xvzf 2.0.499-release-20180606122508.tar.gz
RUN rm 2.0.499-release-20180606122508.tar.gz
RUN mkdir libmaus2-2.0.499
WORKDIR libmaus2-2.0.499-release-20180606122508
RUN ./configure --prefix=/soft/libmaus2-2.0.499
RUN make
RUN make install
WORKDIR /soft
# Install pkg-config
RUN wget https://pkg-config.freedesktop.org/releases/pkg-config-0.29.2.tar.gz
RUN tar xvzf pkg-config-0.29.2.tar.gz
WORKDIR pkg-config-0.29.2
RUN ./configure --with-internal-glib
RUN make
RUN make install
WORKDIR /soft
# Download hstlib-1.10.2 
RUN wget https://github.com/samtools/htslib/releases/download/1.10.2/htslib-1.10.2.tar.bz2
#Uncompress hstlib
RUN tar xjvf htslib-1.10.2.tar.bz2
# Move the source files to new folder
RUN mv htslib-1.10.2 htslib-1.10.2-src
# Make dir for hstlib
RUN mkdir htslib-1.10.2 
# Install hstlib 
WORKDIR htslib-1.10.2-src
RUN ./configure --prefix=/soft/hstlib-1.10.2 --enable-plugins 
RUN make
RUN make install
# Clean zip file
RUN rm htslib-1.10.2.tar.bz2
WORKDIR /soft
# Update PATH
ENV PATH "$PATH:/soft/hstlib-1.10.2/bin"
# Load biobambam2 last release
RUN wget https://github.com/gt1/biobambam2/archive/2.0.89-release-20180518145034.tar.gz
# Uncompress and clean
RUN tar xvzf 2.0.89-release-20180518145034.tar.gz
RUN rm 2.0.89-release-20180518145034.tar.gz
# Install 
RUN mkdir biobambam2-2.0.89
WORKDIR biobambam2-2.0.89-release-20180518145034
RUN ./configure --with-libmaus2=/soft/libmaus2-2.0.499 --prefix=/soft/biobambam2-2.0.89
RUN make
RUN make install
RUN rm pkg-config-0.29.2.tar.gz
WORKDIR /soft

