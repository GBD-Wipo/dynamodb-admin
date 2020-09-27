FROM amazonlinux:latest
RUN yum install -y gcc-c++ make net-tools procps
RUN amazon-linux-extras install -y nginx1
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python get-pip.py
RUN pip install supervisor
RUN curl -sL https://rpm.nodesource.com/setup_14.x | bash -
RUN yum install -y nodejs
RUN node -v

# setup all the configfiles
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN mkdir -p /etc/supervisor/conf.d/
COPY supervisor-app.conf /etc/supervisord.conf


RUN mkdir -p /data/dynamodb_admin/ && cd /data/dynamodb_admin
WORKDIR /data/dynamodb_admin

COPY ./ /data/dynamodb_admin/
RUN npm install

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
CMD ["supervisord", "-n"]
