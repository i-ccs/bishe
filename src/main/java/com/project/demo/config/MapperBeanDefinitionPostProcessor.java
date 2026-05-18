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

public class MapperBeanDefinitionPostProcessor implements BeanDefinitionRegistryPostProcessor, Ordered {

    private static final String FACTORY_BEAN_OBJECT_TYPE = "factoryBeanObjectType";
    private static final Logger logger = LoggerFactory.getLogger(MapperBeanDefinitionPostProcessor.class);

    @Override
    public void postProcessBeanFactory(ConfigurableListableBeanFactory beanFactory) throws BeansException {
        // Also attempt conversion here to catch bean definitions registered after
        // registry phase
        String[] names = beanFactory.getBeanDefinitionNames();
        for (String name : names) {
            BeanDefinition bd = beanFactory.getBeanDefinition(name);
            Object attr = bd.getAttribute(FACTORY_BEAN_OBJECT_TYPE);
            handleAttributeConversion(attr, bd);
        }
    }

    @Override
    public void postProcessBeanDefinitionRegistry(BeanDefinitionRegistry registry) throws BeansException {
        String[] names = registry.getBeanDefinitionNames();
        for (String name : names) {
            BeanDefinition bd = registry.getBeanDefinition(name);
            Object attr = bd.getAttribute(FACTORY_BEAN_OBJECT_TYPE);
            handleAttributeConversion(attr, bd);
        }
    }

    private void handleAttributeConversion(Object attr, BeanDefinition bd) {
        if (attr == null)
            return;

        ClassLoader cl = Thread.currentThread().getContextClassLoader();

        try {
            if (attr instanceof Class) {
                return; // already correct
            }

            if (attr instanceof String) {
                String className = (String) attr;
                try {
                    Class<?> cls = Class.forName(className, false, cl);
                    bd.setAttribute(FACTORY_BEAN_OBJECT_TYPE, cls);
                    logger.debug("Converted factoryBeanObjectType string '{}' to Class for beanDef", className);
                } catch (ClassNotFoundException e) {
                    // ignore - leave attribute as-is if class not found
                    logger.debug("Could not load class '{}' for factoryBeanObjectType", className);
                }
                return;
            }

            if (attr instanceof String[]) {
                String[] arr = (String[]) attr;
                if (arr.length > 0) {
                    try {
                        Class<?> cls = Class.forName(arr[0], false, cl);
                        bd.setAttribute(FACTORY_BEAN_OBJECT_TYPE, cls);
                        logger.debug("Converted factoryBeanObjectType String[] to Class '{}'", arr[0]);
                    } catch (ClassNotFoundException e) {
                        logger.debug("Could not load class '{}' from String[]", arr[0]);
                    }
                }
                return;
            }

            if (attr instanceof Collection) {
                Collection<?> coll = (Collection<?>) attr;
                if (!coll.isEmpty()) {
                    Object first = coll.iterator().next();
                    if (first instanceof String) {
                        String className = (String) first;
                        try {
                            Class<?> cls = Class.forName(className, false, cl);
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
            // Be defensive: never let this post-processor break startup
            logger.debug("Exception while converting factoryBeanObjectType attribute", t);
        }
    }

    @Override
    public int getOrder() {
        return Ordered.HIGHEST_PRECEDENCE;
    }
}
