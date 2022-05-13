package com.example.demo.mapper;

import com.example.demo.model.Dump;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper //mapper로 스프링부트가 인식
public class DumpMapper {
//    @Select("SELECT * FROM UserProfile WHERE id=#{id}")
        //param id 전달 - param 연결시 # 으로해야 @Param으로 맵핑
//    Dump getUserProfile(@Param("id") String id) {
//        return null;
//    }
//
//    @Select("SELECT * FROM UserProfile")
//    List<Dump> getUserProfileList() {
//        return null;
//    }
//
//    @Insert("INSERT INTO UserProfile VALUES(#{id}, #{name}, #{phone}, #{address})")
//    int insertUserProfile(@Param("id") String id, @Param("name") String name, @Param("phone") String phone,
//                          @Param("address") String address) {
//        return 0;
//    }
//
//    @Update("UPDATE UserProfile SET name=#{name}, phone=#{phone}, address=#{address} WHERE id=#{id}")
//    int postUserProfile(@Param("id") String id, @Param("name") String name, @Param("phone") String phone,
//                        @Param("address") String address) {
//        return 0;
//    }
//
//    @Delete("DELETE FROM UserProfile WHERE id=#{id}")
//    int deleteUserProfile(@Param("id") String id) {
//        return 0;
//    }

    //성공적으로 수행될 시 1 반환
}
