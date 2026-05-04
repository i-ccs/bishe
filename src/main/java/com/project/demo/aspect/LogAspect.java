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

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
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

        // 获取 token 并解析用户信息 (这里简单模拟，实际项目中应从 SecurityContext 或 AccessToken 表获取)
        String token = request.getHeader("x-auth-token");
        // 注意：由于切面无法直接访问 BaseService 的 baseMapper，这里建议通过注入 AccessToken 相关的 Service 或直接查询
        // 为了保持简单且不引入循环依赖，我们这里尝试从 request 属性或直接通过日志打印基础信息
        // 如果需要更详细的用户信息，可以在拦截器中将用户信息存入 request 属性
        
        // 记录内容
        Object content = null;
        if ("insert".equals(methodName) && args.length > 0) {
            content = args[0]; // body
        } else if ("update".equals(methodName) && args.length > 2) {
            content = args[2]; // body
        } else if ("delete".equals(methodName) && args.length > 0) {
            content = args[0]; // query
        }

        String logDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        String logTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
        
        String logStr = String.format("[%s] [%s] [%s] %s: %s\n",
                logTime, tableName, methodName, methodName, JSON.toJSONString(content));

        writeToLogFile(logDate, logStr);
    }

    private void writeToLogFile(String date, String content) {
        try {
            String folderPath = "logs";
            File folder = new File(folderPath);
            if (!folder.exists()) {
                folder.mkdirs();
            }

            File logFile = new File(folderPath + File.separator + date + ".log");
            FileWriter fw = new FileWriter(logFile, true);
            fw.write(content);
            fw.close();
        } catch (IOException e) {
            log.error("写入日志文件失败", e);
        }
    }

    private String humpToLine(String str) {
        if (str == null) return null;
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < str.length(); i++) {
            char c = str.charAt(i);
            if (Character.isUpperCase(c)) {
                if (i > 0) sb.append("_");
                sb.append(Character.toLowerCase(c));
            } else {
                sb.append(c);
            }
        }
        return sb.toString();
    }
}
