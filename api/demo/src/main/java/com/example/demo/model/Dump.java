package com.example.demo.model;

public class Dump { //table 객체 이름과 동일하게 column도 멤버 변수 명과 동일하게
    private String data;

    public Dump(String data) {
        this.data = data;
    }

    public String getDumpData() {
        return data;
    }

    public void setDumpData(String data) {
        this.data = data;
    }
}
