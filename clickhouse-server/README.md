```shell
# 生成default用户密码的SHA256摘要
PASSWORD=$(base64 < /dev/urandom | head -c8); echo "default"; echo -n "default" | sha256sum | tr -d '-'
# 生成root用户密码的SHA256摘要
PASSWORD=$(base64 < /dev/urandom | head -c8); echo "root"; echo -n "root" | sha256sum | tr -d '-'
```

# 修改 config.xml

```xml
<!-- /etc/clickhouse-server/config.xml -->

<listen_host>0.0.0.0</listen_host>
```

# 修改 users.xml

```xml
<!-- /etc/clickhouse-server/users.xml -->

<users>
  <default>
    <password></password>
    <networks>
        <ip>::/0</ip>
    </networks>
    <profile>default</profile>
    <quota>default</quota>
  </default>

  <root>
    <password></password>
    <networks>
        <ip>::/0</ip>
    </networks>
    <profile>root</profile>
    <quota>root</quota>
  </root>
</<users>>
```
