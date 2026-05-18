package com.project.demo.config;

import com.baomidou.mybatisplus.annotation.DbType;
import com.baomidou.mybatisplus.extension.plugins.MybatisPlusInterceptor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class MybatisPlusConfig {

    /**
     * 分页插件
     */
    @Bean
    public MybatisPlusInterceptor mybatisPlusInterceptor() {
        MybatisPlusInterceptor interceptor = new MybatisPlusInterceptor();
        // 分页拦截器在当前 mybatis-plus 版本中由 starter/其他模块处理。
        // 不使用乐观锁拦截器：项目采用数据库层面的悲观锁（例如在 mapper 中使用 `SELECT ... FOR UPDATE`）。
        // 如需在未来启用乐观锁，可添加 `OptimisticLockerInnerInterceptor`。
        return interceptor;
    }
}
