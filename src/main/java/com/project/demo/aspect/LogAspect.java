package com.project.demo.aspect;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import jakarta.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 操作日志切面
 */
@Aspect
@Component
@Slf4j
public class LogAspect {

    @Autowired(required = false)
    private HttpServletRequest request;

    @Pointcut("execution(* com.project.demo.service.base.BaseService.insert(..)) || " +
            "execution(* com.project.demo.service.base.BaseService.update(..)) || " +
            "execution(* com.project.demo.service.base.BaseService.delete(..))")
    public void operationLog() {
    }

    @AfterReturning(pointcut = "operationLog()")
    public void doAfterReturning(JoinPoint joinPoint) {
        if (request == null) {
            return;
        }

        String methodName = joinPoint.getSignature().getName();
        Object[] args = joinPoint.getArgs();
        String tableName = joinPoint.getTarget().getClass().getSimpleName().replace("Service", "");

        // 转换表名为下划线格式 (模拟 BaseService 中的 humpToLine)
        tableName = humpToLine(tableName);

        String username = "未知用户";
        String userGroup = "未知组";

        // 记录内容
        Object content = null;
        if ("insert".equals(methodName) && args.length > 0) {
            content = args[0]; // body
        } else if ("update".equals(methodName) && args.length > 2) {
            content = args[2]; // body
        } else if ("delete".equals(methodName) && args.length > 0) {
            content = args[0]; // query
        }

        String logStr = String.format("[%s] [%s] %s: %s",
                tableName, methodName, methodName, JSON.toJSONString(content));

        log.info(logStr);
    }

    private String humpToLine(String str) {
        if (str == null)
            return null;
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < str.length(); i++) {
            char c = str.charAt(i);
            if (Character.isUpperCase(c)) {
                if (i > 0)
                    sb.append("_");
                sb.append(Character.toLowerCase(c));
            } else {
                sb.append(c);
            }
        }
        return sb.toString();
    }
}
