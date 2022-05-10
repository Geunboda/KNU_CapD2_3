package com.example.demo;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/mysql_test2")
public class MySqlTest2Controller {
    @GetMapping
    public String mySqlTest2() {
        return "mysql_test2";
    }
}

