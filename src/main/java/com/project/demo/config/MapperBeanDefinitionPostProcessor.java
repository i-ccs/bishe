package com.project.demo.config;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.beans.factory.config.ConfigurableListableBeanFactory;
import org.springframework.beans.factory.support.BeanDefinitionRegistry;
import org.springframework.beans.factory.support.BeanDefinitionRegistryPostProcessor;
import org.springframework.core.Ordered;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.util.Collection;

/**
 * Spring Bean定义后处理器 - Mapper Bean属性转换
 * 
 * 功能说明：
 * 在Spring容器启动过程中，对Mapper Bean定义的factoryBeanObjectType属性进行类型转换。
 * 将字符串类型（或字符串数组/集合）的类名称转换为真实的Class对象。
 * 
 * 处理流程：
 * 1. 在Bean定义注册阶段执行postProcessBeanDefinitionRegistry方法
 * 2. 在Bean工厂处理阶段执行postProcessBeanFactory方法
 * 3. 两个方法都会调用handleAttributeConversion进行属性转换
 * 
 * 转换对象类型：
 * - String: 单个类名字符串 → Class对象
 * - String[]: 字符串数组第一个元素 → Class对象
 * - Collection: 集合中第一个String元素 → Class对象
 * - 已是Class类型: 保持不变
 * 
 * 异常处理：
 * - ClassNotFoundException时保留原属性值，不影响应用启动
 * - 所有异常都被捕获并记录日志，确保后处理器不会中断Spring启动
 */
public class MapperBeanDefinitionPostProcessor implements BeanDefinitionRegistryPostProcessor, Ordered {

    /** Bean定义属性键名 - 用于标识工厂Bean的对象类型属性 */
    private static final String FACTORY_BEAN_OBJECT_TYPE = "factoryBeanObjectType";

    /** 日志记录器 - 用于记录属性转换过程的调试信息 */
    private static final Logger logger = LoggerFactory.getLogger(MapperBeanDefinitionPostProcessor.class);

    /**
     * Bean工厂后处理阶段 - 处理Bean工厂中的Bean定义
     * 
     * 此方法在Bean定义注册完成后、Bean实例化前执行。
     * 主要用于捕获在注册阶段之后才注册的Bean定义。
     * 
     * @param beanFactory 可配置的Bean工厂，用于获取Bean定义
     * @throws BeansException Spring Bean处理异常
     */
    @Override
    public void postProcessBeanFactory(ConfigurableListableBeanFactory beanFactory) throws BeansException {
        // 获取所有已注册的Bean定义名称
        String[] names = beanFactory.getBeanDefinitionNames();
        // 遍历所有Bean定义并进行属性类型转换
        for (String name : names) {
            BeanDefinition bd = beanFactory.getBeanDefinition(name); // 获取Bean定义对象
            Object attr = bd.getAttribute(FACTORY_BEAN_OBJECT_TYPE); // 获取factoryBeanObjectType属性值
            handleAttributeConversion(attr, bd); // 执行属性类型转换
        }
    }

    /**
     * Bean定义注册后处理阶段 - 处理Bean定义注册中心的Bean定义
     * 
     * 此方法在Bean定义注册完成后立即执行，优先级高于postProcessBeanFactory。
     * 用于在Spring容器初始化早期处理Bean属性转换。
     * 
     * @param registry Bean定义注册中心，用于管理Bean定义
     * @throws BeansException Spring Bean处理异常
     */
    @Override
    public void postProcessBeanDefinitionRegistry(BeanDefinitionRegistry registry) throws BeansException {
        // 获取所有已注册的Bean定义名称
        String[] names = registry.getBeanDefinitionNames();
        // 遍历所有Bean定义并进行属性类型转换
        for (String name : names) {
            BeanDefinition bd = registry.getBeanDefinition(name); // 获取Bean定义对象
            Object attr = bd.getAttribute(FACTORY_BEAN_OBJECT_TYPE); // 获取factoryBeanObjectType属性值
            handleAttributeConversion(attr, bd); // 执行属性类型转换
        }
    }

    /**
     * 处理属性类型转换 - 将字符串类型的类名转换为Class对象
     * 
     * 此方法支持多种类型的属性值：
     * - String: 直接转换为Class
     * - String[]: 获取第一个元素转换为Class
     * - Collection: 获取第一个String元素转换为Class
     * - Class: 已是正确类型，保持不变
     * 
     * @param attr 原始属性值（可能是String、String[]、Collection或Class）
     * @param bd   Bean定义对象，用于更新属性值
     */
    private void handleAttributeConversion(Object attr, BeanDefinition bd) {
        // 如果属性为null，直接返回（无需处理）
        if (attr == null)
            return;

        // 获取当前线程的上下文类加载器，用于加载类
        ClassLoader cl = Thread.currentThread().getContextClassLoader();

        try {
            // 情况1: 属性已是Class类型，不需要转换
            if (attr instanceof Class) {
                return; // 属性已经是正确的类型，直接返回
            }

            // 情况2: 属性是String类型 - 将类名字符串转换为Class对象
            if (attr instanceof String) {
                String className = (String) attr;
                try {
                    // 使用类加载器加载指定的类（false表示不初始化类）
                    Class<?> cls = Class.forName(className, false, cl);
                    // 更新Bean定义中的属性为转换后的Class对象
                    bd.setAttribute(FACTORY_BEAN_OBJECT_TYPE, cls);
                    logger.debug("Converted factoryBeanObjectType string '{}' to Class for beanDef", className);
                } catch (ClassNotFoundException e) {
                    // 如果找不到类，保留原属性值不做处理
                    logger.debug("Could not load class '{}' for factoryBeanObjectType", className);
                }
                return;
            }

            // 情况3: 属性是String[]数组类型 - 取第一个元素转换为Class对象
            if (attr instanceof String[]) {
                String[] arr = (String[]) attr;
                // 检查数组是否非空
                if (arr.length > 0) {
                    try {
                        // 获取数组第一个元素（类名）并转换为Class对象
                        Class<?> cls = Class.forName(arr[0], false, cl);
                        // 更新Bean定义中的属性为转换后的Class对象
                        bd.setAttribute(FACTORY_BEAN_OBJECT_TYPE, cls);
                        logger.debug("Converted factoryBeanObjectType String[] to Class '{}'", arr[0]);
                    } catch (ClassNotFoundException e) {
                        logger.debug("Could not load class '{}' from String[]", arr[0]);
                    }
                }
                return;
            }

            // 情况4: 属性是Collection集合类型 - 获取集合中第一个元素转换为Class对象
            if (attr instanceof Collection) {
                Collection<?> coll = (Collection<?>) attr;
                // 检查集合是否非空
                if (!coll.isEmpty()) {
                    // 获取集合中的第一个元素
                    Object first = coll.iterator().next();
                    // 检查第一个元素是否为String类型
                    if (first instanceof String) {
                        String className = (String) first;
                        try {
                            // 将类名字符串转换为Class对象
                            Class<?> cls = Class.forName(className, false, cl);
                            // 更新Bean定义中的属性为转换后的Class对象
                            bd.setAttribute(FACTORY_BEAN_OBJECT_TYPE, cls);
                            logger.debug("Converted factoryBeanObjectType Collection to Class '{}'", className);
                        } catch (ClassNotFoundException e) {
                            logger.debug("Could not load class '{}' from Collection", className);
                        }
                    }
                }
                return;
            }
        } catch (Throwable t) {
            // 防御性编程：捕获所有异常，确保后处理器的异常不会中断Spring应用启动
            logger.debug("Exception while converting factoryBeanObjectType attribute", t);
        }
    }

    /**
     * 获取处理器的执行顺序优先级
     * 返回值越小，优先级越高（越早执行）
     * 设置最高优先级可确保此后处理器在其他后处理器之前执行
     * 
     * @return 处理器执行优先级（HIGHEST_PRECEDENCE = Integer.MIN_VALUE）
     */
    @Override
    public int getOrder() {
        return Ordered.HIGHEST_PRECEDENCE; // 设置最高优先级，确保最早执行
    }
}
