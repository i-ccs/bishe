package com.project.demo;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.context.annotation.Bean;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.beans.factory.support.BeanDefinitionRegistryPostProcessor;
import com.project.demo.config.MapperBeanDefinitionPostProcessor;

/**
 */
@SpringBootApplication
@EnableJpaRepositories
@MapperScan("com.project.demo.dao")
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

    @Bean
    public static BeanDefinitionRegistryPostProcessor mapperBeanDefinitionPostProcessor() {
        return new MapperBeanDefinitionPostProcessor();
    }
}
