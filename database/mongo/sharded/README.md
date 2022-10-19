```shell
# 创建密钥文件
openssl rand -base64 756 > /tmp/mongo-cluster/config-server/conf/mongo.key
# 设置
chmod 600  /tmp/mongo-cluster/config-server/conf/mongo.key


docker exec -it mongo-sh1r1 bash
mongo -u root -p 123456

#  初始化副本集rs0
rs.initiate(
  {
    _id : 'rs0',
    members: [
      { _id : 0, host : "mongo-sh1r1:27017" },
      { _id : 1, host : "mongo-sh1r2:27017" },
      { _id : 2, host : "mongo-sh1r3:27017" }
    ]
  }
)
rs.status()


docker exec -it mongo-sh2r1 bash
mongo -u root -p 123456

#  初始化副本集rs1
rs.initiate(
  {
    _id : 'rs1',
    members: [
      { _id : 0, host : "mongo-sh2r1:27017" },
      { _id : 1, host : "mongo-sh2r2:27017" },
      { _id : 2, host : "mongo-sh2r3:27017" }
    ]
  }
)
rs.status()

# 初始化配置副本集configReplSet
rs.initiate( {
   _id : "configReplSet",
   members: [
      { _id: 0, host: "mongo-config1:27017" },
      { _id: 1, host: "mongo-config1:27017" },
      { _id: 2, host: "mongo-config1:27017" }
   ]
})
```

```shell
docker exec -it $(docker ps | grep "mongos" | awk '{ print $1 }') bash -c "echo -e 'use admin\n db.createUser({user:\"root\",pwd:\"root\",roles:[{role:\"root\",db:\"admin\"}]})' | mongo"

use admin
db.createUser({
  user: 'root',
  pwd: '123456',
  roles:[{
    role: 'root',
    db: 'admin'
  }]
})
```
