# Base OS
FROM shaunol/centos-mono:centos6.4-mono.afa2f52
MAINTAINER shaunol

# Env setup
ENV HOME /root
WORKDIR ~/

# Build deps
# required for xsp: pkgconfig
# required for nginx: pcre-devel, zlib-devel
RUN yum install -y pkgconfig pcre-devel zlib-devel

# Install xsp, requires to provide fastcgi-mono-server for nginx to serve asp.net requests
ENV PKG_CONFIG_PATH /usr/lib/pkgconfig
RUN git clone git://github.com/mono/xsp ~/xsp && \
	cd ~/xsp && \
	git reset --hard 8a31bc6 && \
	./autogen.sh --prefix=/usr && \
	./configure --prefix=/usr && \
	make && \
	make install && \
	cd ~/ && \
	rm -rf ~/xsp

# fastcgi-mono-server is ready to start now, so create a directory for our single application environment and start it up
ENV LD_LIBRARY_PATH /usr/lib
# TODO: Use the init script for fast-cgi-monoserver
RUN mkdir /usr/aspnet && \
	/usr/bin/fastcgi-mono-server4 /applications=/:/usr/aspnet/ /socket=tcp:127.0.0.1:9000 &

# nginx install
RUN cd ~/ && \
	wget http://nginx.org/download/nginx-1.7.2.tar.gz && \
	tar -zxf nginx-1.7.2.tar.gz && \
	cd ~/nginx-1.7.2/ && \
	./configure --prefix=/usr && \
	make && \
	make install && \
	cd ~/ && \
	rm -rf ./nginx-1.7.2/ ./nginx-1.7.2.tar.gz

# Download and load the sample MVC4 application
RUN cd ~/ && \
	wget --no-check-certificate https://github.com/shaunol/docker-nginx-aspnet/raw/master/HelloWorldMvc4-Deploy.tar.gz && \
	tar -zxf HelloWorldMvc4-Deploy.tar.gz && \
	mv ~/HelloWorldMvc4-Deploy/* /usr/aspnet/ && \
	rm -rf ~/HelloWorldMvc4-Deploy/ ~/HelloWorldMvc4-Deploy.tar.gz

# Configure nginx
RUN wget --no-check-certificate https://raw.githubusercontent.com/shaunol/docker-nginx-aspnet/master/nginx-fastcgi_params.conf -O /usr/conf/nginx-fastcgi_params.conf && \
	wget --no-check-certificate https://raw.githubusercontent.com/shaunol/docker-nginx-aspnet/master/nginx.conf -O /usr/conf/nginx.conf

# Start nginx
RUN /usr/sbin/nginx