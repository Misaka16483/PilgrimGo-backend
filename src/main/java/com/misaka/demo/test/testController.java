package com.misaka.demo.test;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api")
public class testController {
    @Autowired
    private testService testService;
    @GetMapping("/hello")
    public List<testEntity> hello(){
        QueryWrapper<testEntity> queryWrapper = new QueryWrapper<testEntity>();
        queryWrapper.select();
        return testService.list(queryWrapper);
    }
}
