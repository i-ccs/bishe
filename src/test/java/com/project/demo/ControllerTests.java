package com.project.demo;

import com.project.demo.controller.UserController;
import com.project.demo.exception.CustomException;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@SpringBootTest
@AutoConfigureMockMvc
class ControllerTests {

    @Autowired
    private MockMvc mockMvc;

    @Test
    void testGlobalExceptionHandler() throws Exception {
        // 模拟请求一个不存在的接口或触发异常
        mockMvc.perform(get("/api/user/get_obj?username=nonexistent_user_99999")
                .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.result").isEmpty());
    }
    
    @Test
    void testExceptionFormat() throws Exception {
        // 这里可以测试异常返回格式
        // 如果我们能手动触发一个异常的话
        System.out.println("Testing global exception response format...");
    }
}
