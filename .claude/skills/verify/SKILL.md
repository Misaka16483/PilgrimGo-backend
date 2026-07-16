---
name: verify
description: Run the Spring Boot API against the isolated H2 test configuration and exercise authentication without external services.
---

# Runtime verification

1. Launch the real application with test dependencies and explicit test resources. Use only public dummy environment values; never connect to the shared PostgreSQL database or invoke OSS/SMS endpoints.

```bash
export SPRING_DATASOURCE_PASSWORD=test-only-database-password
export JWT_SECRET=test-only-jwt-signing-key-32-bytes-minimum
export ALIYUN_OSS_ACCESS_KEY_ID=test-only-access-key-id
export ALIYUN_OSS_ACCESS_KEY_SECRET=test-only-access-key-secret
export ALIYUN_SMS_ACCESS_KEY_ID=test-only-access-key-id
export ALIYUN_SMS_ACCESS_KEY_SECRET=test-only-access-key-secret

./mvnw spring-boot:run \
  -Dspring-boot.run.useTestClasspath=true \
  -Dspring-boot.run.profiles=test \
  '-Dspring-boot.run.arguments=--server.port=18080 --spring.config.additional-location=file:./src/test/resources/ --spring.sql.init.schema-locations=file:./src/test/resources/schema.sql'
```

2. Require startup evidence for the active `test` profile and `jdbc:h2:mem:testdb` before sending requests.
3. Exercise `POST /api/auth/register`, then `POST /api/auth/login`; require API code `200` and a three-segment JWT from both responses.
4. Probe validation with a one-character username; the current API returns HTTP `200` with envelope code `400`.
5. Stop the application and inspect logs for unexpected external database or cloud-service calls.

## Gotcha

`spring-boot.run.useTestClasspath=true` alone does not put this project's test resources ahead of the main resources. Keep the explicit `spring.config.additional-location` and schema-file override in the launch command.
