# Use ubuntu-18 as parent image
FROM dokken/ubuntu-18.04
# Install requried libraries
RUN apt-get update && apt-get install -y build-essential libncurses5-dev zlib1g-dev libbz2-dev
RUN apt-get install -y liblzma-dev 
# Make dir for softwares
RUN mkdir /SOFT
# Set working directory
WORKDIR /SOFT
# Load samtools-1.10 tarball of last release
RUN wget https://github.com/samtools/samtools/releases/download/1.10/samtools-1.10.tar.bz2
# Uncompress
RUN tar xjvf samtools-1.10.tar.bz2
# Move the source files to new folder
RUN mv samtools-1.10 samtools-1.10-src
# Make dir where samtools will be installed
RUN mkdir samtools-1.10
# Install samtools 
WORKDIR samtools-1.10-src
RUN ./configure --prefix=/SOFT/samtools-1.10
RUN make
RUN make install
WORKDIR /SOFT
# Update PATH
ENV PATH "$PATH:/SOFT/samtools-1.10/bin"
# Install git
RUN apt-get install -y git
# Load and install last release of libmaus2
RUN wget https://github.com/gt1/libmaus2/archive/2.0.499-release-20180606122508.tar.gz
RUN tar xvzf 2.0.499-release-20180606122508.tar.gz
RUN mkdir libmaus2-2.0.499
WORKDIR libmaus2-2.0.499-release-20180606122508
RUN ./configure --prefix=/SOFT/libmaus2-2.0.499
RUN make
RUN make install
WORKDIR /SOFT
# Install pkg-config
RUN wget https://pkg-config.freedesktop.org/releases/pkg-config-0.29.2.tar.gz
RUN tar xvzf pkg-config-0.29.2.tar.gz
WORKDIR pkg-config-0.29.2
RUN ./configure --with-internal-glib
RUN make
RUN make install
WORKDIR /SOFT
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
RUN ./configure --prefix=/SOFT/hstlib-1.10.2 --enable-plugins 
RUN make
RUN make install
WORKDIR /SOFT
# Update PATH
ENV PATH "$PATH:/SOFT/hstlib-1.10.2/bin"
# Load biobambam2 last release
RUN wget https://github.com/gt1/biobambam2/archive/2.0.89-release-20180518145034.tar.gz
# Uncompress
RUN tar xvzf 2.0.89-release-20180518145034.tar.gz
# Install 
RUN mkdir biobambam2-2.0.89
WORKDIR biobambam2-2.0.89-release-20180518145034
RUN ./configure --with-libmaus2=/SOFT/libmaus2-2.0.499 --prefix=/SOFT/biobambam2-2.0.89
RUN make
RUN make install
WORKDIR /SOFT
# Clean
RUN rm samtools-1.10.tar.bz2
RUN rm 2.0.499-release-20180606122508.tar.gz
RUN rm pkg-config-0.29.2.tar.gz
RUN rm 2.0.89-release-20180518145034.tar.gz
RUN rm htslib-1.10.2.tar.bz2
