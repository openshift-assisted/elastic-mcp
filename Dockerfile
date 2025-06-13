FROM registry.fedoraproject.org/fedora:latest

RUN dnf install -y pip3 python3; \
    pip3 install opensearch-mcp-server-py

EXPOSE 9900

ENTRYPOINT ["python", "-m", "mcp_server_opensearch", "--transport", "sse"]

