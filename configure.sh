#!/bin/bash

# Credits: https://www.couchbase.com/forums/t/how-to-create-preconfigured-couchbase-docker-image-with-data/17004
set -e
set -m

/entrypoint.sh couchbase-server &


logger.info() {
    echo "$(date) [INFO]: $@" 
}
logger.warn() {
    echo "$(date) [WARN]: $@"
}


couchbase.is-ready() {
    curl --silent http://127.0.0.1:8091/pools > /dev/null
    echo $?
}

until [[ $(couchbase.is-ready) = 0 ]]; do
    logger.warn "Waiting for Couchbase Server to accept connections..."
    sleep 1
done

logger.info "Couchbase server is ready to accept connections!"
logger.info "Starting setup..."


logger.info "Setting up cluster < $CLUSTER_NAME >..."
couchbase-cli cluster-init -c 127.0.0.1 --cluster-username $CLUSTER_ADMIN_USERNAME --cluster-password $CLUSTER_ADMIN_PASSWORD \
--cluster-name $CLUSTER_NAME --cluster-ramsize $CLUSTER_MEMORY_SIZE --cluster-index-ramsize $CLUSTER_INDEX_MEMORY_SIZE --services data,index,query,fts \
--index-storage-setting default

if [[ -v BUCKET_NAME ]]; then
    logger.info "Creating bucket < $BUCKET_NAME >..."
        couchbase-cli bucket-create -c 127.0.0.1 --username $CLUSTER_ADMIN_USERNAME --password $CLUSTER_ADMIN_PASSWORD \
        --bucket-type couchbase --bucket-ramsize 250 --bucket $bucket
fi

couchbase-cli user-manage -c 127.0.0.1:8091 -u $CLUSTER_ADMIN_USERNAME -p $CLUSTER_ADMIN_PASSWORD --set \
--rbac-username $BUCKET_USERNAME --rbac-password $BUCKET_PASSWORD \
--rbac-name "$BUCKET_USER" --roles bucket_full_access[*] --auth-domain local

fg 1