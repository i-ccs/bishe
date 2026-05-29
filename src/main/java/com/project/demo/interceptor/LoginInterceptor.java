package com.project.demo.interceptor;

import lombok.extern.slf4j.Slf4j;

import org.springframework.http.HttpStatus;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 登录拦截器
 * 用于拦截请求、验证用户认证令牌、处理跨域请求等
 * 
 * 功能：
 * 1. 验证用户令牌（令牌为空时排除特定路径）
 * 2. 设置跨域响应头
 * 3. 记录请求信息
 */
@Slf4j
public class LoginInterceptor implements HandlerInterceptor {

    /** 认证令牌的头名称 */
    private String tokenName = "x-auth-token";

    /**
     * 拦截请求的预处理方法
     * 在请求传送到Controller之前调用
     * 
     * 功能：
     * 1. 从请求头中获取认证令牌
     * 2. 设置跨域响应头
     * 3. 记录请求信息
     * 4. 排除特定路径（登陆、查询用户状态、注册）
     *
     * @param request  HTTP请求
     * @param response HTTP响应对象
     * @param handler  处理程序
     * @return true表示继续执行，false表示拦断请求
     * @throws Exception 可能抛出的异常
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        // 从请求头中获取认证令牌
        String token = request.getHeader(this.tokenName);

        // 设置跨域响应头
        setHeader(request, response);
        // 记录请求的URL和请求方法
        log.info("[请求接口] - {} , [请求类型] - {}", request.getRequestURL().toString(), request.getMethod());
        // 排除登陆接口，允许直接访问
        if (request.getRequestURL().toString().contains("/api/user/login")) {
            return true;
        } else if (request.getRequestURL().toString().contains("/api/user/state")) {
            // 排除查询上线状态接口，允许直接访问
            return true;
        } else if (request.getRequestURL().toString().contains("/api/user/register")) {
            // 排除注册接口，允许直接访问
            return true;
        }
        // 预留备注：下列认证令牌的验证逻辑往后封底
        // if (token == null || "".equals(token)){
        // if ("POST".equals(request.getMethod())){
        // return false;
        // }else {
        // return true;
        // }
        // }else {
        return true;
        // }
    }

    /**
     * 拦截请求的后处理（拦截器之后，Controller之前）
     * 用于消息上下文初始化执行、之后返回控制器视图
     * 
     * 此次处理：更新认证令牌
     * 
     * @param request      HTTP请求
     * @param response     HTTP响应对象
     * @param handler      处理程序
     * @param modelAndView Controller返回的视图模型
     */
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
            ModelAndView modelAndView) {
        // 更新认证令牌
    }

    /**
     * 拦截请求的完成处理（当传出视图或输出了数据到客户端时调用）
     * 适合资源释放的操作、如关闭输入流等
     *
     * @param request  HTTP请求
     * @param response HTTP响应对象
     * @param handler  处理程序
     * @param ex       处理时抛出的任意异常
     * @throws Exception 可能抛出的异常
     */
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
            throws Exception {
    }

    /**
     * 处理用户认证失败的情况
     * 返回401错误状态码或重定向到登陆页面
     *
     * @param request  HTTP请求
     * @param response HTTP响应对象
     * @throws IOException 输出流异常
     */
    private void failure(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // 设置JSON响应格式
        response.setHeader("Content-type", "application/json;charset=UTF-8");
        // 设置响应状态为401（未授权）
        response.setStatus(401);
        // 可以返回一个错误页面，此处转向百度
        // response.getWriter().write("");
        response.sendRedirect("https://www.baidu.com");
    }

    /**
     * 设置跨域响应头
     * 处理跨域请求（CORS）需要的响应头配置
     * 确保前端可以超越同源限制发起远程请求
     *
     * @param request  HTTP请求
     * @param response HTTP响应对象
     */
    private void setHeader(HttpServletRequest request, HttpServletResponse response) {
        // 设置跨域访问源（自动获取请求中的Origin字段）
        response.setHeader("Access-control-Allow-Origin", request.getHeader("Origin"));
        // 设置允许的HTTP方法
        response.setHeader("Access-Control-Allow-Methods", "GET, HEAD, POST, PUT, DELETE, TRACE, OPTIONS, PATCH");
        // 设置是否允许发送会话信息（Cookie等）
        response.setHeader("Access-Control-Allow-Credentials", "true");
        // 设置允许的响应头（自动获取请求中的请求头）
        response.setHeader("Access-Control-Allow-Headers", request.getHeader("Access-Control-Request-Headers"));
        // 设置预检请求的有效时间，单位为秒
        response.setHeader("Access-Control-Max-Age", "1800");
        // 设置中文编码，防止传输JSON数据时乱码
        response.setHeader("Content-Type", "application/json;charset=UTF-8");
        // 设置响应状态为200（OK）
        response.setStatus(HttpStatus.OK.value());
    }

}
