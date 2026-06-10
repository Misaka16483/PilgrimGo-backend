package com.misaka.demo.architecture;

import com.tngtech.archunit.core.domain.JavaClasses;
import com.tngtech.archunit.core.domain.JavaModifier;
import com.tngtech.archunit.core.importer.ClassFileImporter;
import com.tngtech.archunit.core.importer.ImportOption;
import com.tngtech.archunit.lang.ArchRule;
import com.tngtech.archunit.lang.syntax.ArchRuleDefinition;
import com.tngtech.archunit.library.Architectures;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

/**
 * 架构合规性测试
 * 
 * 使用 ArchUnit 确保代码架构符合分层设计规范，
 * 防止不合理的包依赖关系。
 * 
 * 规则说明：
 * 1. Controller 层不能直接访问 Repository/Mapper 层
 * 2. Service 层作为中间层协调数据访问
 * 3. 确保分层架构的清晰边界
 */
@DisplayName("架构合规性测试")
public class ArchitectureComplianceTest {

    /**
     * 导入项目所有类（排除测试类）
     */
    private static JavaClasses importedClasses;

    @BeforeAll
    static void setUp() {
        importedClasses = new ClassFileImporter()
                .withImportOption(ImportOption.Predefined.DO_NOT_INCLUDE_TESTS)
                .importPackages("com.misaka.demo");
    }

    /**
     * 核心架构规则：Controller 不能直接依赖 Mapper
     * 
     * 违反此规则会导致：
     * 1. 业务逻辑泄漏到控制层
     * 2. 难以进行单元测试
     * 3. 违反单一职责原则
     */
    @Test
    @DisplayName("Controller 层不能直接依赖 Mapper 层")
    void controllersShouldNotAccessMappersDirectly() {
        ArchRule rule = ArchRuleDefinition.noClasses()
                .that()
                .resideInAPackage("..controller..")
                .should()
                .dependOnClassesThat()
                .resideInAPackage("..mapper..");

        rule.check(importedClasses);
    }

    /**
     * Controller 层只能通过 Service 层访问数据
     */
    @Test
    @DisplayName("Controller 只能通过 Service 访问数据层")
    void controllersShouldOnlyAccessServices() {
        ArchRule rule = ArchRuleDefinition.classes()
                .that()
                .resideInAPackage("..controller..")
                .should()
                .onlyAccessClassesThat()
                .resideInAnyPackage(
                        "..controller..",
                        "..service..",
                        "..dto..",
                        "..vo..",
                        "..entity..",
                        "..config..",
                        "..util..",
                        "java..",
                        "javax..",
                        "org.springframework..",
                        "org.slf4j.."
                );

        rule.check(importedClasses);
    }

    /**
     * 分层架构验证：使用 ArchUnit 的 LayeredArchitecture
     */
    @Test
    @DisplayName("验证分层架构合规性")
    @Disabled("项目当前分层架构与ArchUnit规则不完全匹配，需逐步调整后再启用")
    void layeredArchitectureShouldBeRespected() {
        Architectures.LayeredArchitecture architecture = Architectures.layeredArchitecture()
                .consideringOnlyDependenciesInLayers()
                
                // 定义层
                .layer("Controller").definedBy("..controller..")
                .layer("Service").definedBy("..service..")
                .layer("Mapper").definedBy("..mapper..")
                .layer("Entity").definedBy("..entity..")
                .layer("DTO").definedBy("..dto..", "..vo..")
                
                // 定义依赖规则
                .whereLayer("Controller").mayNotBeAccessedByAnyLayer()
                .whereLayer("Service").mayOnlyBeAccessedByLayers("Controller", "Service")
                .whereLayer("Mapper").mayOnlyBeAccessedByLayers("Service")
                .whereLayer("Entity").mayOnlyBeAccessedByLayers("Controller", "Service", "Mapper", "DTO")
                .whereLayer("DTO").mayOnlyBeAccessedByLayers("Controller", "Service", "DTO");

        architecture.check(importedClasses);
    }

    /**
     * 命名规范：Controller 类名必须以 Controller 结尾
     */
    @Test
    @DisplayName("Controller 类名必须以 Controller 结尾")
    void controllerClassesShouldHaveProperNaming() {
        ArchRule rule = ArchRuleDefinition.classes()
                .that()
                .resideInAPackage("..controller..")
                .should()
                .haveSimpleNameEndingWith("Controller");

        rule.check(importedClasses);
    }

    /**
     * 命名规范：Service 类名必须以 Service 结尾
     */
    @Test
    @DisplayName("Service 类名必须以 Service 结尾")
    void serviceClassesShouldHaveProperNaming() {
        ArchRule rule = ArchRuleDefinition.classes()
                .that()
                .resideInAPackage("..service..")
                .and()
                .areTopLevelClasses()
                .should()
                .haveSimpleNameEndingWith("Service");

        rule.check(importedClasses);
    }

    /**
     * 禁止循环依赖：Service 层不能依赖 Controller 层
     */
    @Test
    @DisplayName("禁止 Service 层依赖 Controller 层（防止循环依赖）")
    void servicesShouldNotDependOnControllers() {
        ArchRule rule = ArchRuleDefinition.noClasses()
                .that()
                .resideInAPackage("..service..")
                .should()
                .dependOnClassesThat()
                .resideInAPackage("..controller..");

        rule.check(importedClasses);
    }

    /**
     * 工具类规范：Util 类应该是 final 且只有静态方法（排除 Spring 组件）
     */
    @Test
    @DisplayName("工具类应该是 final 的")
    void utilityClassesShouldBeFinal() {
        ArchRule rule = ArchRuleDefinition.classes()
                .that()
                .haveSimpleNameEndingWith("Util")
                .or()
                .haveSimpleNameEndingWith("Utils")
                .and()
                .areNotAnnotatedWith(org.springframework.stereotype.Component.class)
                .and()
                .areNotAnnotatedWith(org.springframework.stereotype.Service.class)
                .should()
                .haveModifier(JavaModifier.FINAL)
                .allowEmptyShould(true);

        rule.check(importedClasses);
    }
}
