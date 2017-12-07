FROM centos:7

USER root

COPY docker-entrypoint.sh /
COPY agentx.default.js $HOME/

RUN yum install -y \
	   wget curl g++ cairo cairo-devel cairomm cairomm-devel pixman pixman-devel binutils-gold \
	   jpeg jpeg-devel libjpeg libjpeg-turbo libjpeg-turbo-devel libpng gnupg \
	   imagemagick-devel graphicsmagick-devel imagemagick graphicsmagick \
	   pango pango-devel pangomm pangomm-devel giflib giflib-devel openssl-devel libstdc++ \
	   xproto renderproto kbproto xextproto freetype freetype-devel fontconfig-devel \
	   bison flex gperf icu-devel libc-devel libpng-devel libx11-devel libxext-devel paxctl \
	   git build-base nodejs-devel gcc perl python ruby sqlite-devel linux-headers make \
	   && mkdir -p /root
    
# Change mirrors
RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
RUN wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo

ENV HOME /root
# Install alinode v3.8.1 (node v8.9.1)
ENV ALINODE_VERSION 3.8.1
ENV TNVM_DIR /root/.tnvm

RUN wget -O- https://raw.githubusercontent.com/aliyun-node/tnvm/master/install.sh | bash

RUN source $HOME/.bashrc \
    && tnvm install "alinode-v$ALINODE_VERSION" \
    && tnvm use "alinode-v$ALINODE_VERSION" \
    && npm install -g node-gyp bower grunt-cli canvas@1.6.2 gulp-cli cordova-hot-code-push-cli pm2 agentx commandx --registry=https://registry.npm.taobao.org \
    && npm config set registry https://registry.npm.taobao.org --global \
	&& mkdir -p /root \
	&& chmod 755 /docker-entrypoint.sh

EXPOSE 80
WORKDIR /wwwroot/htdocs/www

ENTRYPOINT ["/docker-entrypoint.sh"]
