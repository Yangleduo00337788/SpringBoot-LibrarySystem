package com.example.controller;

import com.example.entity.Result;
import com.example.entity.Role;
import com.example.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/*
        角色管理控制层
 */
@RequestMapping("/roles")
@RestController
public class RoleController {
    @Autowired
    private RoleService roleService;
    /*
            查询用户角色列表
     */
    @GetMapping
    public Result list(){
        List<Role> roleList = roleService.findAll();
        return Result.success(roleList);
    }
    /*
            根据ID删除用户角色
     */
    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id){
        System.out.println("根据ID删除用户，id="+id);
        roleService.deleteById(id);
        return Result.success();
    }
    /**
     *      新增用户角色
     */
    @PostMapping
    public Result save(@RequestBody Role role){
        System.out.println("新增用户，user="+role);
        roleService.save(role);
        return Result.success();
    }
    /**
     * 根据角色名称查询用户角色
     */
    @GetMapping("/{roleName}")
    public Result getByroleName(@PathVariable String roleName){
        System.out.println("根据ID查询，id="+roleName);
        Role role = roleService.getByroleName(roleName);
        return Result.success(role);
    }

    /**
     *      修改用户角色
     */
    @PutMapping("/{id}")
    public Result update(@PathVariable Integer id,@RequestBody Role role){
        role.setId(id);
        System.out.println("修改用户,user="+role+",修改用户的id="+id);
        roleService.update(role);
        return Result.success();
    }
}
