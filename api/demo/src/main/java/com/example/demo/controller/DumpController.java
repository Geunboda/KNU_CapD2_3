package com.example.demo.controller;

import com.example.demo.mapper.DumpMapper;
import com.example.demo.model.Dump;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RestController // 프레임워크가 클래스를 컨트롤러로 인식하고 컨트롤러 인스턴스 생성
public class DumpController {
//    @Autowired // 의존하는 객체 자동으로 삽입
//    private DumpMapper mapper;
//
//    public DumpController(DumpMapper mapper){ //생성자로 내부 레퍼런스에 저장 (알아서 mapper 만들고 컨트롤러랑 연결)
//        this.mapper = mapper;
//    }

    @GetMapping("/api/test")
    public String test(){
        return "test";
    }

    @PostMapping("/api/dump")
    public @ResponseBody String getDumpData(@RequestBody String dump){
        System.out.println(dump);
        return "Successfully Sent";
    }

//    @GetMapping("/user/{id}") //패스의 변수 이용위해 어노테이션
//    public Dump getUserProfile(@PathVariable("id") String id){
//        return mapper.getUserProfile(id); //mapper sql 수행 후 java 객체로 반환 후 json 형태로 전달
//    }
//
//    @PostMapping("/user/{id}") //수정은 주로 Post 방식으로 처리
//    public void postUserProfile(@PathVariable("id") String id, @RequestParam("name") String name,
//                                @RequestParam("phone") String phone, @RequestParam("address")String address){
//        mapper.postUserProfile(id, name, phone, address);
//    }
//
//    @DeleteMapping
//    public void deleteUserProfile(@PathVariable("id") String id) {
//        mapper.deleteUserProfile(id);
//    }
}
