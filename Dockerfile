ARG DOCKER_IMAGE=alpine:3.16
FROM $DOCKER_IMAGE AS builder

ENV FREECRAFT_GAME_VERSION master
ENV IRRLICHT_VERSION master
ENV SPATIALINDEX_VERSION 1.9.3
ENV LUAJIT_VERSION v2.1

RUN apk add --no-cache git build-base cmake curl-dev zlib-dev zstd-dev \
		sqlite-dev postgresql-dev hiredis-dev leveldb-dev \
		gmp-dev jsoncpp-dev ninja ca-certificates

WORKDIR /usr/src/
RUN git clone --recursive https://github.com/jupp0r/prometheus-cpp/ && \
		cd prometheus-cpp && \
		cmake -B build \
			-DCMAKE_INSTALL_PREFIX=/usr/local \
			-DCMAKE_BUILD_TYPE=Release \
			-DENABLE_TESTING=0 \
			-GNinja && \
		cmake --build build && \
		cmake --install build && \
	cd /usr/src/ && \
	git clone --recursive https://github.com/libspatialindex/libspatialindex -b ${SPATIALINDEX_VERSION} && \
		cd libspatialindex && \
		cmake -B build \
			-DCMAKE_INSTALL_PREFIX=/usr/local && \
		cmake --build build && \
		cmake --install build && \
	cd /usr/src/ && \
	git clone --recursive https://luajit.org/git/luajit.git -b ${LUAJIT_VERSION} && \
		cd luajit && \
		make && make install && \
	cd /usr/src/ && \
	git clone --depth=1 https://github.com/minetest/irrlicht/ -b ${IRRLICHT_VERSION} && \
		cp -r irrlicht/include /usr/include/irrlichtmt

COPY .git /usr/src/freecraft/.git
COPY CMakeLists.txt /usr/src/freecraft/CMakeLists.txt
COPY README.md /usr/src/freecraft/README.md
COPY freecraft.conf.example /usr/src/freecraft/freecraft.conf.example
COPY builtin /usr/src/freecraft/builtin
COPY cmake /usr/src/freecraft/cmake
COPY doc /usr/src/freecraft/doc
COPY fonts /usr/src/freecraft/fonts
COPY lib /usr/src/freecraft/lib
COPY misc /usr/src/freecraft/misc
COPY po /usr/src/freecraft/po
COPY src /usr/src/freecraft/src
COPY textures /usr/src/freecraft/textures

WORKDIR /usr/src/freecraft
RUN git clone --depth=1 -b ${FREECRAFT_GAME_VERSION} https://github.com/KanuX-14/freecraft.git ./games/freecraft && \
		rm -fr ./games/freecraft/.git && \
		cmake -B build \
			-DCMAKE_INSTALL_PREFIX=/usr/local \
			-DCMAKE_BUILD_TYPE=Release \
			-DBUILD_SERVER=TRUE \
			-DENABLE_PROMETHEUS=TRUE \
			-DBUILD_UNITTESTS=FALSE \
			-DBUILD_CLIENT=FALSE \
			-GNinja && \
		cmake --build build && \
		cmake --install build

ARG DOCKER_IMAGE=alpine:3.16
FROM $DOCKER_IMAGE AS runtime

RUN apk add --no-cache curl gmp libstdc++ libgcc libpq jsoncpp zstd-libs \
				sqlite-libs postgresql hiredis leveldb && \
	adduser -D freecraft --uid 30000 -h /var/lib/freecraft && \
	chown -R freecraft:freecraft /var/lib/freecraft

WORKDIR /var/lib/freecraft

COPY --from=builder /usr/local/share/freecraft /usr/local/share/freecraft
COPY --from=builder /usr/local/bin/freecraftserver /usr/local/bin/freecraftserver
COPY --from=builder /usr/local/share/doc/freecraft/freecraft.conf.example /etc/freecraft/freecraft.conf
COPY --from=builder /usr/local/lib/libspatialindex* /usr/local/lib/
COPY --from=builder /usr/local/lib/libluajit* /usr/local/lib/
USER freecraft:freecraft

EXPOSE 30000/udp 30000/tcp
VOLUME /var/lib/freecraft/ /etc/freecraft/

ENTRYPOINT ["/usr/local/bin/freecraftserver"]
CMD ["--config", "/etc/freecraft/freecraft.conf"]
