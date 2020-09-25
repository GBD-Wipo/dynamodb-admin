FROM amazonlinux:latest
RUN yum install -y gcc-c++ make
RUN curl -sL https://rpm.nodesource.com/setup_14.x | bash -
RUN yum install -y nodejs
RUN node -v
RUN mkdir -p /data/dynamodb_admin/ && cd /data/dynamodb_admin
WORKDIR /data/dynamodb_admin

COPY ./ /data/dynamodb_admin/
RUN npm install

EXPOSE 8001
CMD ["node", "bin/dynamodb-admin.js"]
