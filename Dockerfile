FROM ubuntu

RUN apt-get update && apt-get install -y curl
COPY ./process-logs.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/process-logs.sh
CMD ["process-logs.sh"]