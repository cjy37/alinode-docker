FROM centos:7

USER root

COPY docker-entrypoint.sh /
COPY agentx.default.js $HOME/

RUN yum install -y \
	   wget curl libstdc++-devel gcc gcc-c++ cairo cairo-devel cairomm cairomm-devel pixman pixman-devel binutils-gold gd-devel libgomp \
	   tcl-devel libpng-devel libjpeg-devel ghostscript ghostscript-devel bzip2-devel libtiff libtiff-devel libjpeg libjpeg-turbo \
	   ImageMagick ImageMagick-devel GraphicsMagick GraphicsMagick-devel libjpeg-turbo-devel libpng gnupg \
	   pango pango-devel pangomm pangomm-devel giflib giflib-devel openssl-devel libstdc++ \
	   libXproto libRenderproto libKbproto libXextproto freetype freetype-devel fontconfig-devel \
	   bison flex gperf libicu-devel glibc-devel libX11-devel libXext-devel libPaxctl \
	   git build-base libNodejs-devel gcc perl python ruby sqlite-devel linux-headers make \
	   && mkdir -p /root
    
## Change mirrors
#RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
#RUN wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
#
#ENV HOME /root
## Install alinode v3.8.1 (node v8.9.1)
#ENV ALINODE_VERSION 3.8.1
#ENV TNVM_DIR /root/.tnvm
#
#RUN wget -O- https://raw.githubusercontent.com/aliyun-node/tnvm/master/install.sh | bash
#
#RUN source $HOME/.bashrc \
#    && tnvm install "alinode-v$ALINODE_VERSION" \
#    && tnvm use "alinode-v$ALINODE_VERSION" \
#    && npm config set registry https://registry.npm.taobao.org --global \
#    && npm install --unsafe-perm -g node-gyp bower grunt-cli canvas@1.6.2 gulp-cli cordova-hot-code-push-cli pm2 agentx commandx --registry=https://registry.npm.taobao.org \
#	&& mkdir -p /root \
#	&& chmod 755 /docker-entrypoint.sh
#
#EXPOSE 80
#WORKDIR /wwwroot/htdocs/www
#
#ENTRYPOINT ["/docker-entrypoint.sh"]
