package com.misaka.demo.integration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.transaction.annotation.Transactional;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;
import org.testcontainers.utility.DockerImageName;

import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * 后端集成测试基类
 * 
 * 使用 Testcontainers 提供真实的 PostgreSQL 数据库环境，
 * 确保集成测试在接近生产环境的数据库中运行。
 * 
 * 特性：
 * 1. 复用同一个 Spring 上下文和数据库容器（提升性能）
 * 2. 自动回滚测试数据（@Transactional）
 * 3. 自动配置 MockMvc 用于 HTTP 测试
 * 4. 提供通用的 JSON 序列化工具
 * 
 * 使用方法：
 * <pre>
 * public class UserApiTest extends AbstractIntegrationTest {
 *     @Test
 *     void testSomething() throws Exception {
 *         mockMvc.perform(get("/api/users"))
 *                .andExpect(status().isOk());
 *     }
 * }
 * </pre>
 */
@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("test")
@Testcontainers
@Transactional
public abstract class AbstractIntegrationTest {

    /**
     * 共享的 PostgreSQL 容器实例
     * 
     * static 修饰符确保所有子类共享同一个容器，
     * 大幅提升测试执行速度。
     */
    @Container
    protected static final PostgreSQLContainer<?> POSTGRESQL_CONTAINER =
            new PostgreSQLContainer<>(DockerImageName.parse("postgres:15-alpine"))
                    .withDatabaseName("xunli_test")
                    .withUsername("test")
                    .withPassword("test")
                    .withReuse(true); // 启用容器复用，加速后续测试

    /**
     * HTTP 测试客户端
     */
    @Autowired
    protected MockMvc mockMvc;

    /**
     * JSON 序列化/反序列化工具
     */
    @Autowired
    protected ObjectMapper objectMapper;

    /**
     * 动态配置数据源属性
     * 
     * 将 Testcontainers 提供的连接信息注入到 Spring 环境中，
     * 替换 application-test.yml 中的数据库配置。
     * 
     * @param registry Spring 动态属性注册器
     */
    @DynamicPropertySource
    static void configureProperties(DynamicPropertyRegistry registry) {
        // 等待容器启动完成
        if (!POSTGRESQL_CONTAINER.isRunning()) {
            POSTGRESQL_CONTAINER.start();
        }

        // 注入数据库连接配置
        registry.add("spring.datasource.url", POSTGRESQL_CONTAINER::getJdbcUrl);
        registry.add("spring.datasource.username", POSTGRESQL_CONTAINER::getUsername);
        registry.add("spring.datasource.password", POSTGRESQL_CONTAINER::getPassword);
        registry.add("spring.datasource.driver-class-name", () -> "org.postgresql.Driver");

        // 配置连接池（测试环境优化）
        registry.add("spring.datasource.hikari.maximum-pool-size", () -> "5");
        registry.add("spring.datasource.hikari.minimum-idle", () -> "1");
        registry.add("spring.datasource.hikari.connection-timeout", () -> "10000");

        // JPA/Hibernate 配置
        registry.add("spring.jpa.hibernate.ddl-auto", () -> "create-drop");
        registry.add("spring.jpa.show-sql", () -> "true");
        registry.add("spring.jpa.properties.hibernate.format_sql", () -> "true");
        registry.add("spring.jpa.properties.hibernate.dialect", () -> "org.hibernate.dialect.PostgreSQLDialect");
    }

    /**
     * 获取容器的 JDBC URL（用于调试）
     * 
     * @return JDBC 连接字符串
     */
    protected static String getJdbcUrl() {
        return POSTGRESQL_CONTAINER.getJdbcUrl();
    }

    /**
     * 检查容器是否运行中
     * 
     * @return true 如果容器正在运行
     */
    protected static boolean isContainerRunning() {
        return POSTGRESQL_CONTAINER.isRunning();
    }
}
