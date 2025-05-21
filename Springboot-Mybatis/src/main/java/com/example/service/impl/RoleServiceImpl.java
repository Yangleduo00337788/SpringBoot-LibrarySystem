package com.example.service.impl;

import com.example.entity.Role;
import com.example.mapper.RoleMapper;
import com.example.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleServiceImpl implements RoleService {
    @Autowired
    private RoleMapper roleMapper;

    /**
     *      查询用户角色
     *
     */

    public List<Role> findAll(){
        return roleMapper.findAll();
    }
    /**
     *      根据ID删除用户角色
     */
    public void deleteById(Integer id){
        roleMapper.deleteById(id);
    }

    /**
     *      新增用户角色
     */
    public void save(Role role){
        //保存用户
        roleMapper.insert(role);
    }

    /**
     *      根据角色名称查询用户角色
     */
    public Role getByroleName(String roleName){
        return roleMapper.getByroleName(roleName);
    }

    /**
     *      修改用户角色
     *
     */
    @Override
    public void update(Role role) {
        roleMapper.update(role);
    }
}
