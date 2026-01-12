## AI Codereview Pro版部署

### 1. 准备环境
- 创建目录
```aiignore
mkdir -p {data,logs}
```

- 创建docker-compose.yml文件

```yaml
services:
  mysql:
    image: mysql:8.0
    container_name: codereview-mysql
    environment:
      MYSQL_ROOT_PASSWORD: u9QdPyXM
      MYSQL_DATABASE: codereview
      TZ: Asia/Shanghai
    command:
      - --character-set-server=utf8mb4
      - --collation-server=utf8mb4_general_ci
      - --default-authentication-plugin=mysql_native_password
      - --max_connections=50
    ports:
      - "13306:3306"
    volumes:
      - ./data/mysql:/var/lib/mysql
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost", "-uroot", "-pu9QdPyXM"]
      interval: 10s
      timeout: 5s
      retries: 5

  app:
    image: registry.cn-hangzhou.aliyuncs.com/stanley-public/ai-codereview-pro:1.0.3
    container_name: codereview-app
    ports:
      - "81:80"
    environment:
      APP_USERNAME: admin
      APP_PASSWORD: admin
      JWT_SECRET: ChangeThisSecretKeyInProduction
      JAVA_OPTS: -Xms256m -Xmx512m
      DB_HOST: mysql
      DB_PORT: 3306
      DB_NAME: codereview
      DB_USERNAME: root
      DB_PASSWORD: u9QdPyXM
    volumes:
      - ./data:/app/data
      - ./logs:/app/logs
    depends_on:
      mysql:
        condition: service_healthy
    restart: unless-stopped
```

### 2. 启动服务
```bash
docker-compose up -d
```

### 3. 访问服务
打开浏览器，访问 http://localhost:81 ，使用用户名 `admin` 和密码 `admin` 登录。