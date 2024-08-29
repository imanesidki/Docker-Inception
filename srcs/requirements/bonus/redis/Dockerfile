FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y redis-server

# Modify the Redis configuration to unbind from localhost
# Comment out the bind directive to allow Redis to accept connections from any IP address
RUN sed -i "s|bind 127.0.0.1|#bind 127.0.0.1|g" /etc/redis/redis.conf

# Set a maxmemory limit of 20MB in the Redis configuration
RUN sed -i "s|# maxmemory <bytes>|maxmemory 20mb|g" /etc/redis/redis.conf

# Add a policy to evict keys using the allkeys-lru algorithm when maxmemory is reached
RUN echo "maxmemory-policy allkeys-lru" >> /etc/redis/redis.conf

# Ensures Redis runs in the foreground, as Docker expects the main process to remain active.
RUN echo "daemonize no" >> /etc/redis/redis.conf

CMD [ "redis-server", "/etc/redis/redis.conf" ]
