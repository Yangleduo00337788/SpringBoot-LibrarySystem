package com.example.entity;

import lombok.Data;
/*
    后端同意返回结果
 */
@Data
public class Result {
    private Integer code;           //编码：1成功，0失败
    private String msg;             //错误信息
    private Object data;            //数据
    //创建静态成功方法并返回
    public static Result success(){
        Result result = new Result();
        result.code = 1;
        result.msg = "success";
        return result;
    }

    public static Result success(Object object){
        Result result = new Result();
        result.data = object;
        result.code = 1;
        result.msg = "success";
        return result;
    }
    public static Result fail(String msg){
        Result result = new Result();
        result.msg = msg;
        result.code = 0;
        return  result;
    }
}
