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
 * 操作日志切面 - AOP日志记录器
 * 
 * 功能说明：
 * 使用Spring AOP框架对BaseService中的数据库操作（插入、更新、删除）进行拦截和日志记录。
 * 在操作执行后获取相关信息（表名、操作类型、操作数据等）并输出到日志系统。
 * 
 * 监控的操作：
 * - BaseService.insert(..): 数据插入操作
 * - BaseService.update(..): 数据更新操作
 * - BaseService.delete(..): 数据删除操作
 * 
 * 工作流程：
 * 1. @Pointcut定义切点，匹配BaseService中的三种操作方法
 * 2. @AfterReturning在操作执行后进行拦截
 * 3. 提取操作相关信息（表名、方法名、操作数据）
 * 4. 格式化并输出日志记录
 * 
 * 日志格式：
 * [表名] [方法名] 方法名: JSON格式的操作数据
 * 例如：[user] [insert] insert:
 * {"id":1,"username":"admin","email":"admin@example.com"}
 */
@Aspect // 标注为切面类
@Component // 注册为Spring Bean
@Slf4j // Lombok提供的日志注解，自动生成log字段
public class LogAspect {

    /** HTTP请求对象 - 用于获取当前请求的相关信息（如操作用户等） */
    @Autowired(required = false)
    private HttpServletRequest request;

    /**
     * 定义AOP切点 - 匹配BaseService中的增删改操作方法
     * 
     * 切点表达式说明：
     * - execution: 匹配方法执行
     * - com.project.demo.service.base.BaseService: 指定目标类
     * - insert(..) / update(..) / delete(..): 指定三个目标方法
     * - (..): 参数匹配器，匹配任意参数列表
     * - ||: 或操作符，表示匹配三个方法中的任意一个
     * 
     * 处理的方法：
     * - insert(): 数据插入操作 - args[0]为要插入的实体对象
     * - update(): 数据更新操作 - args[2]为要更新的实体对象
     * - delete(): 数据删除操作 - args[0]为查询条件
     */
    @Pointcut("execution(* com.project.demo.service.base.BaseService.insert(..)) || " +
            "execution(* com.project.demo.service.base.BaseService.update(..)) || " +
            "execution(* com.project.demo.service.base.BaseService.delete(..))")
    public void operationLog() {
        // 切点定义方法体为空，仅用于标注切点，实际逻辑在通知方法中执行
    }

    /**
     * 后置通知 - 在操作执行后记录操作日志
     * 
     * 执行时机：
     * - 在BaseService的insert/update/delete方法执行完成后触发
     * - 只有当方法正常返回时才会执行（异常不触发）
     * 
     * 处理流程：
     * 1. 检查HTTP请求是否存在
     * 2. 从连接点获取方法名、参数、目标类
     * 3. 提取并转换表名（驼峰转下划线）
     * 4. 根据方法类型获取操作数据内容
     * 5. 格式化并输出日志记录
     * 
     * @param joinPoint 连接点对象，包含方法调用的相关信息
     */
    @AfterReturning(pointcut = "operationLog()")
    public void doAfterReturning(JoinPoint joinPoint) {
        // 如果没有HTTP请求上下文，则无法记录日志，直接返回
        if (request == null) {
            return;
        }

        // 获取被调用方法的名称（insert/update/delete）
        String methodName = joinPoint.getSignature().getName();
        // 获取被调用方法的所有参数
        Object[] args = joinPoint.getArgs();
        // 获取目标对象的类名，并移除"Service"后缀得到表名（例：UserService → User）
        String tableName = joinPoint.getTarget().getClass().getSimpleName().replace("Service", "");

        // 将表名从驼峰命名转换为下划线格式（例：User → user，UserGroup → user_group）
        tableName = humpToLine(tableName);

        // 操作用户信息（当前代码中为硬编码，实际可从request中获取）
        String username = "未知用户";
        String userGroup = "未知组";

        // 根据操作类型从参数中提取操作数据内容
        Object content = null;
        if ("insert".equals(methodName) && args.length > 0) {
            // insert操作：第一个参数为要插入的实体对象
            content = args[0];
        } else if ("update".equals(methodName) && args.length > 2) {
            // update操作：第三个参数为要更新的实体对象
            content = args[2];
        } else if ("delete".equals(methodName) && args.length > 0) {
            // delete操作：第一个参数为查询条件/ID
            content = args[0];
        }

        // 使用String.format格式化日志信息
        // 格式：[表名] [操作方法] 操作方法: JSON格式的操作数据
        String logStr = String.format("[%s] [%s] %s: %s",
                tableName, methodName, methodName, JSON.toJSONString(content));

        // 使用info级别输出日志
        log.info(logStr);
    }

    /**
     * 将驼峰命名转换为下划线命名 - 字符串格式转换工具方法
     * 
     * 转换规则：
     * - 大写字母转换为下划线 + 小写字母
     * - 第一个字符前不添加下划线
     * - 其他小写字母保持不变
     * 
     * 使用示例：
     * - "User" → "user"
     * - "UserGroup" → "user_group"
     * - "InventoryInformation" → "inventory_information"
     * - "userProfile" → "user_profile"
     * 
     * @param str 驼峰命名的字符串
     * @return 转换后的下划线命名字符串，如果输入为null则返回null
     */
    private String humpToLine(String str) {
        // 检查输入参数，如果为null则直接返回null
        if (str == null)
            return null;

        // 使用StringBuilder构建转换后的字符串
        StringBuilder sb = new StringBuilder();

        // 遍历字符串中的每个字符
        for (int i = 0; i < str.length(); i++) {
            char c = str.charAt(i);
            // 如果当前字符是大写字母
            if (Character.isUpperCase(c)) {
                // 如果不是第一个字符，先添加下划线
                if (i > 0)
                    sb.append("_");
                // 将大写字母转换为小写字母
                sb.append(Character.toLowerCase(c));
            } else {
                // 小写字母或其他字符直接添加
                sb.append(c);
            }
        }

        // 返回转换后的下划线格式字符串
        return sb.toString();
    }
}
