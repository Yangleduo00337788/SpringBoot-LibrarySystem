package com.example.service;

import com.example.entity.Role;
import java.util.List;

public interface RoleService {
    /*
            查询所有用户角色
     */
    List<Role> findAll();

    /*
            根据ID删除用户角色
     */
    void deleteById(Integer id);

    /**
     *      新增用户角色
     *
     *
     */
    void save(Role role);

    /**
     *      修改用户角色
     * @param role
     */
    void update(Role role);

    /**
     *      根据角色名称查询用户角色
     * @param roleName
     * @return
     */
    Role getByroleName(String roleName);
}
