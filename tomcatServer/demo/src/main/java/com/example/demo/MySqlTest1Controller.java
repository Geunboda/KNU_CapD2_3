package com.example.demo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/mysql_test1")
public class MySqlTest1Controller {
    @GetMapping
    public String mySqlTest1() {
        return "mysql_test1";
    }
}

