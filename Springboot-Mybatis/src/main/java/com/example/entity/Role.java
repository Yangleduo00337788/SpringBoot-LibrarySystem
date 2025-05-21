package com.example.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data       //lombok构建函数注解
@AllArgsConstructor     //全参构造
@NoArgsConstructor      //无参构造
public class Role {
    private Integer id;     //用户id
    private String roleName;        //角色名称
    private String roleCode;        //角色编码
    private String description;     //角色描述
    private Integer status;     //状态（0-禁用，1-启用）
    private Date createTime;        //创建时间
}
