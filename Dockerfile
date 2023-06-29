ARG VERSION

FROM couchbase/server:community-${VERSION}

ENV CLUSTER_ADMIN_USERNAME couchbase-admin
ENV CLUSTER_ADMIN_PASSWORD couchbase
ENV CLUSTER_NAME defaultCluster
ENV CLUSTER_MEMORY_SIZE 1024
ENV CLUSTER_INDEX_MEMORY_SIZE 512
ENV BUCKET_USERNAME couchbase
ENV BUCKET_PASSWORD couchbase 

COPY ./configure.sh /configure.sh
RUN chmod +x /configure.sh
CMD ["/configure.sh"]
