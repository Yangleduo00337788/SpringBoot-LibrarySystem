package com.example.controller;

import com.example.entity.Result;
import com.example.entity.User;
import com.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
/*
    用户管理控制层
 */
@RequestMapping("/users")
@RestController
public class UserController {
    @Autowired
    private UserService userService;

    /*
        查询用户列表
     */
    @GetMapping
    public Result list(){
        List<User> userList = userService.findAll();
        return Result.success(userList);
    }
    /*
        根据ID删除用户
     */
    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id){
        System.out.println("根据ID删除用户，id="+id);
        userService.deleteById(id);
        return Result.success();
    }
    /*
        新增用户
     */
    @PostMapping
    public Result save(@RequestBody User user){
        System.out.println("新增用户，user="+user);
        userService.save(user);
        return Result.success();
    }

    /*
        根据ID查询用户
     */
    @GetMapping("/{id}")
    public Result getById(@PathVariable Integer id){
        System.out.println("根据ID查询，id="+id);
        User user = userService.getById(id);
        return Result.success(user);
    }

    /*
        修改用户
     */
    @PutMapping("/{id}")
    public Result update(@PathVariable Integer id,@RequestBody User user){
        user.setId(id);
        System.out.println("修改用户,user="+user+",修改用户的id="+id);
        userService.update(user);
        return Result.success();
    }
}
