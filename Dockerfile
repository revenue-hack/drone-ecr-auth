FROM docker:18.09.3

RUN apk --update add \
    python \
    curl \
    groff; \
    set -ex; \
    wget -O get-pip.py 'https://bootstrap.pypa.io/get-pip.py' \
    && python get-pip.py --disable-pip-version-check --no-cache-dir \
    && pip install awscli
ADD docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

