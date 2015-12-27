== Redis-cluster in Docker ==

# current: using redis cluster 3.0.5

# build
* put Dockerfile and manage.sh in the same directory
* sudo docker build -t redis-cluster:3.0.5 .

# redis datastore dir
* mkdir /srv/redis/7000

# run, please notice that data port and communicate port (date port + 10000) should be opened
* sudo docker run -d -p 7000:7000 -p 17000:17000 --net=host -v /srv/redis/7000:/app/redis/database --name redis_cluster_7000 redis-cluster:3.0.5 7000

# test 
* sudo redis-cli -h BLAH -p 7000

# build redis cluster
* At least 3 masters and 3 slaves.

* run 6 redis-cluster docker instances, for example, running at 127.0.0.1:700[0-5]

* use redis-trib.rb (in redis-cluster source, # http://download.redis.io/releases/redis-3.0.5.tar.gz) to build up cluster
 
 sudo ./redis-trib.rb create --replicas 1 127.0.0.1:7000 127.0.0.1:7001 127.0.0.1:7002 127.0.0.1:7003 127.0.0.1:7004 127.0.0.1:7005

# cluster handling
* http://redis.io/topics/cluster-tutorial
