package com.example.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data       //lombok构建函数注解
@AllArgsConstructor         //全参构造
@NoArgsConstructor          //无参构造
public class User {
    private Integer id;     //用户唯一ID，主键自增
    private String username;        //登录用户名
    private String password;        //加密后的密码
    private String name;        //用户真实姓名
    private Integer age;        //用户年龄
    private String gender;      //性别（M-男/F-女/O-其他）
    private String role;        //用户角色（user/admin/editor）
    private String email;       //电子邮箱地址
    private String phone;       //联系电话
    private String address;     //详细地址
    private String avatar;      //头像url地址
    private Integer status;     //账号状态（0-禁用/1-正常）
    private Date createTime;        //创建时间
    private Date updateTime;        //最后更新时间
    private Date lastLoginTime;     //最后登录时间
}
