# Container image that runs your code
FROM alpine:3

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# RUN wget -qO - "https://api.github.com/repos/cdalar/onctl/releases/latest" | grep tag_name | cut -d':' -f2 | cut -d'"' -f2 > /tmp/version.txt
# RUN LATEST_VERSION=$(cat /tmp/version.txt);wget -q https://github.com/cdalar/onctl/releases/download/${LATEST_VERSION}/onctl-linux-amd64.tar.gz
RUN wget https://www.github.com/cdalar/onctl/releases/latest/download/onctl-linux-amd64.tar.gz
RUN tar zxf onctl-linux-amd64.tar.gz
RUN mv onctl /usr/local/bin/onctl

ENTRYPOINT ["/entrypoint.sh"]
