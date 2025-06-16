FROM registry.access.redhat.com/ubi9/python-311:latest

ARG release=main
ARG version=latest

LABEL com.redhat.component opensearch-mcp-server
LABEL description "ElasticSearch/OpenSearch MCP server"
LABEL summary "ElasticSearch/OpenSearch MCP server"
LABEL io.k8s.description "ElasticSearch/OpenSearch MCP server"
LABEL distribution-scope public
LABEL name opensearch-mcp-server
LABEL release ${release}
LABEL version ${version}
LABEL url https://github.com/openshift-assisted/elastic-mcp
LABEL vendor "Red Hat, Inc."
LABEL maintainer "Red Hat"

RUN pip3 install opensearch-mcp-server-py

EXPOSE 9900

ENTRYPOINT ["python", "-m", "mcp_server_opensearch", "--transport", "sse"]

