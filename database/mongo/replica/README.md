```shell
docker exec -it mongo-rs1 bash

mongo -u root -p 123456

rs.initiate(
  {
    _id : 'rs0',
    members: [
      { _id : 1, host : "mongo-rs1:27017" },
      { _id : 2, host : "mongo-rs2:27017" },
      { _id : 3, host : "mongo-rs3:27017" }
    ]
  }
)

rs.status()
```

```shell
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
