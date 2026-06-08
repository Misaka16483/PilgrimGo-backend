# Xunli-backend (PilgrimGo)

基于 Spring Boot 3 的「动漫圣地巡礼」后端服务，为前端 / 移动端提供番剧、巡礼地标（Spot）、路线、打卡、用户与成就等核心能力，并对接 [Anitabi](https://anitabi.cn/) 开放数据。

## 一、项目简介

PilgrimGo 让动漫爱好者可以按番剧查找现实中的取景地、规划巡礼路线并进行打卡分享。后端职责：

- 用户体系：注册 / 登录 / JWT 鉴权 / 个人资料
- 番剧与地标：从 Anitabi 同步番剧元数据与地理坐标，提供检索、列表、详情接口
- 路线 & 巡礼：用户自建路线、路线点 / 途径点、评分、巡礼记录、打卡
- 会员与成就：会员订阅状态、成就解锁
- 空间检索：基于 PostGIS（`geometry(Point,4326)`）支持按经纬度 / 范围检索 Spot

主要包结构（`com.misaka.demo`）：

| 包 | 职责 |
| --- | --- |
| `controller` | REST 接口（`AuthController` / `AnimeController` / `SpotController` …） |
| `service`    | 业务逻辑 |
| `mapper`     | MyBatis-Plus Mapper |
| `entity`     | 数据库实体 |
| `dto`        | 请求 / 响应对象、统一返回 `ApiResponse`、分页 `PageResult` |
| `config`     | Spring Security、JWT 过滤器、MyBatis-Plus、RestTemplate |
| `client`     | 外部服务调用（`ExternalAnimeClient` 调 Anitabi） |
| `util`       | `JwtUtil` 等工具类 |

## 二、技术栈

| 类别 | 选型 |
| --- | --- |
| 语言 / 运行时 | Java 17 |
| 框架 | Spring Boot 3.5.8 / Spring Web / Spring Security |
| 持久层 | MyBatis-Plus 3.5.12（含 jsqlparser） |
| 连接池 | Druid 1.1.10 |
| 数据库 | PostgreSQL 16 + PostGIS 扩展 |
| 鉴权 | JWT（jjwt 0.12.6） |
| 工具 | Lombok |
| 构建 | Maven（含 `mvnw` Wrapper） |
| 测试 | spring-boot-starter-test、spring-security-test |

## 三、环境要求

- JDK 17+
- Maven 3.8+（或直接使用项目内置 `./mvnw`）
- PostgreSQL 16，已启用 `postgis` 扩展
- 可访问 `https://api.anitabi.cn/`（用于番剧 / 地标数据同步）

## 四、数据库初始化

仓库根目录提供了完整 schema：`BJTU2026_schema.sql`，已包含 `CREATE EXTENSION postgis`、所有表、序列、索引（含 `idx_spot_location` GiST 空间索引）和外键。

```bash
# 1. 创建数据库
createdb -U postgres BJTU2026

# 2. 启用 PostGIS（若 schema 文件因权限无法创建扩展，可先手动启用）
psql -U postgres -d BJTU2026 -c "CREATE EXTENSION IF NOT EXISTS postgis;"

# 3. 导入表结构
psql -U postgres -d BJTU2026 -f BJTU2026_schema.sql
```

核心表：`user` / `anime` / `spot` / `route` / `route_point` / `route_spot` / `route_rating` / `waypoint` / `check_in` / `pilgrimage_record` / `membership` / `achievement` / `user_achievement`。

## 五、配置说明

主配置文件：`src/main/resources/application.properties`

```properties
spring.application.name=pilgrimgo
server.port=8080

# PostgreSQL
spring.datasource.url=jdbc:postgresql://<host>:5432/BJTU2026
spring.datasource.username=<your-user>
spring.datasource.password=<your-password>
spring.datasource.driver-class-name=org.postgresql.Driver

# Druid 连接池
spring.datasource.druid.initial-size=5
spring.datasource.druid.max-active=20
spring.datasource.druid.min-idle=5

# MyBatis-Plus
mybatis-plus.configuration.log-impl=org.apache.ibatis.logging.stdout.StdOutImpl
mybatis-plus.configuration.map-underscore-to-camel-case=true

# JWT
jwt.secret=<至少 32 字节的随机密钥>
jwt.expiration=86400000

# 阿里云 OSS（转折点图片直传，使用 STS 临时凭证）
oss.access-key-id=<RAM 用户 AK>
oss.access-key-secret=<RAM 用户 SK>
oss.role-arn=acs:ram::<accountId>:role/<RoleName>
oss.role-session-name=pilgrimgo-waypoint
oss.bucket=<bucket 名>
oss.region=<例如 cn-beijing>
oss.endpoint=https://oss-<region>.aliyuncs.com
oss.sts-endpoint=sts.<region>.aliyuncs.com
oss.path-prefix=waypoints
oss.duration-seconds=3600
```

### OSS 准备步骤

1. 在阿里云控制台创建 bucket（建议「私有」读写，前端通过签名 URL 访问；如果要直接公网展示巡礼图片可设为「公共读」）。
2. 在 RAM 控制台创建一个角色（普通角色，受信主体选当前主账号），策略需要包含 `oss:PutObject` 到目标 bucket 的权限，把生成的 ARN 填到 `oss.role-arn`。
3. 创建一个 RAM 用户并授予 `AliyunSTSAssumeRoleAccess` 系统策略，用它的 AK/SK 填到 `oss.access-key-id` / `oss.access-key-secret`。
4. 接口 `GET /api/oss/sts`（需登录）会签发一份只能 `PutObject` 到 `{bucket}/waypoints/{userId}/*` 的临时凭证；前端拿到后用 `ali-oss` 直传，再把返回的 URL 写到 `waypoint.photo_url`。

要点：

- 默认端口 `8080`，可按需修改 `server.port`。
- 生产环境请勿在仓库中明文保存数据库密码与 JWT 密钥，建议通过环境变量或外置配置文件覆盖（`--spring.config.location=...` 或 `SPRING_DATASOURCE_PASSWORD` 等环境变量）。
- `jwt.expiration` 单位为毫秒（默认 24 小时）。
- `mybatis-plus.configuration.map-underscore-to-camel-case=true` 将数据库 `snake_case` 自动映射为实体 `camelCase`。

测试环境另有 `src/test/resources/application.properties`，单测时使用，互不影响。

## 六、运行与构建

```bash
# 启动开发服务（首次会下载依赖）
./mvnw spring-boot:run

# 跑测试
./mvnw test

# 打包成可执行 jar
./mvnw clean package
java -jar target/demo2-0.0.1-SNAPSHOT.jar
```

服务启动后默认监听 `http://localhost:8080`。

## 七、外部 API

番剧与巡礼地标数据来源于 Anitabi 开放 API（详见仓库内 `api.md`）：

- 数据 API：`https://api.anitabi.cn/`
- 图片 API：`https://image.anitabi.cn/`

由 `client/ExternalAnimeClient.java` 通过 `RestTemplate` 调用，请勿请求其主域 `https://anitabi.cn/`。

## 八、鉴权说明

- 注册 / 登录接口位于 `AuthController`，登录成功返回 `LoginResponse`（含 JWT）。
- 受保护接口需在请求头携带 `Authorization: Bearer <token>`。
- 鉴权由 `SecurityConfig` + `JwtAuthFilter` 实现，`JwtUtil` 负责签发与校验。

## 九、目录速览

```
.
├── BJTU2026_schema.sql      # PostgreSQL + PostGIS 建表脚本
├── api.md                   # Anitabi 外部 API 说明
├── pom.xml
├── mvnw / mvnw.cmd
├── readme.md
└── src
    ├── main
    │   ├── java/com/misaka/demo/{controller,service,mapper,entity,dto,config,client,util}
    │   └── resources/application.properties
    └── test
        ├── java/...
        └── resources/application.properties
```
