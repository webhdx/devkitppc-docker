FROM devkitpro/devkitppc

LABEL org.opencontainers.image.authors="Maciej Kobus <webhdx@gmail.com>"

RUN   apt-get update;\
      apt-get install -y --no-install-recommends ccache bc; \
      apt-get autoremove -y; apt-get clean; rm /var/lib/apt/lists/* -r; rm -rf /usr/share/man/*

RUN git clone https://github.com/extremscorner/libogc2.git

WORKDIR "/libogc2"
RUN make install

COPY bg.sh run.sh /

RUN ["chmod", "+x", "/bg.sh"]
RUN ["chmod", "+x", "/run.sh"]

ENTRYPOINT ["/run.sh"]