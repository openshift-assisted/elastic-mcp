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

USER 0
RUN pip3 install opensearch-mcp-server-py
RUN sed -i 's/query: Any = Field/query: str = Field/g' $(pip show opensearch-mcp-server-py|grep 'Location:'|tr -s ' '|cut -d ' ' -f2)/tools/tool_params.py
RUN sed -i "/'description': BODY_DESCRIPTIONS.get(op_group, 'Request body'),/a \                'type': 'string'," $(pip show opensearch-mcp-server-py|grep 'Location:'|tr -s ' '|cut -d ' ' -f2)/tools/tool_generator.py


RUN mkdir /licenses/ && chown 1001:0 /licenses/
USER 1001
COPY LICENSE /licenses/

EXPOSE 9900

ENTRYPOINT ["python", "-m", "mcp_server_opensearch", "--transport", "stream"]
CMD ["--host", "localhost", "--port", "9901"]

