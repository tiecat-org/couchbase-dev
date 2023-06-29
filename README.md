# Couchbase Dev Docker Image

Couchbase image for local development.
This docker image extends the official [Couchbase](https://hub.docker.com/r/couchbase/server) docker image Community Edition (`couchbase/server:community`).


## Running :fire:
Just paste in you terminal the following:
```console
docker run --name db -p 8091-8097:8091-8097 -p 9123:9123 -p 11207:11207 -p 11210:11210 -p 11280:11280 -p 18091-18097:18091-18097 --rm ghcr.io/tiecat-org/couchbase-dev:latest
```

## Supported Env Vars :book:

| Key                         | Description                                                            | Default           |
|-----------------------------|------------------------------------------------------------------------|-------------------|
| `CLUSTER_ADMIN_USERNAME`    | Cluster admin username                                                 | `couchbase-admin` |
| `CLUSTER_ADMIN_PASSWORD`    | Cluster admin password                                                 | `couchbase`       |
| `CLUSTER_NAME`              | Cluster name                                                           | `defaultCluster`  |
| `CLUSTER_MEMORY_SIZE`       | Cluster memory size                                                    | `1024`            |
| `CLUSTER_INDEX_MEMORY_SIZE` | Cluster index memory quota                                             | `512`             |
| `BUCKET_NAME`               | Cluster default bucket name, if not providedbucket will not be created | --                |
| `BUCKET_USERNAME`           | Username to access buckets                                             | `couchbase`       |
| `BUCKET_PASSWORD`           | password to access buckets                                             | `couchbase`       |
