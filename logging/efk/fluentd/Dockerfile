FROM fluentd:v1.14.0-debian-1.0
USER root

RUN gem install elasticsearch -v 7.17 && \
    gem install fluent-plugin-elasticsearch && \
    gem install fluent-plugin-rewrite-tag-filter && \
    gem install fluent-plugin-multi-format-parser  && \
    gem install fluent-plugin-kafka

USER fluent
