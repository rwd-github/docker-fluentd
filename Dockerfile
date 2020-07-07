#FROM fluent/fluentd:v1.2.2-onbuild
FROM fluent/fluentd:v1.11-1 as base-fluentd
USER root

RUN apk add --update --virtual .build-deps \
        sudo build-base ruby-dev \
        && sudo gem install \
        fluent-plugin-elasticsearch \
        fluent-plugin-multiline-parser \
        fluent-plugin-rewrite-tag-filter \
        fluent-plugin-concat  \
        fluent-plugin-detect-exceptions \
        fluent-plugin-forest \
        fluent-plugin-record-reformer \
        fluent-plugin-filter-docker_metadata \
        fluent-plugin-filter_typecast \
        fluent-plugin-filter_empty_keys \
 && sudo gem sources --clear-all \
 && apk del .build-deps \
 && rm -rf /var/cache/apk/* \
           /home/fluent/.gem/ruby/2.3.0/cache/*.gem

FROM base-fluentd

#COPY ./config/*.conf /etc/fluent/
COPY entrypoint.sh /bin/
RUN chmod +x /bin/entrypoint.sh


#USER fluent
