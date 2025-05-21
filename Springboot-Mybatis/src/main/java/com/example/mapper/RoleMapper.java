package com.example.mapper;

import com.example.entity.Role;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface RoleMapper {
    /*
            查询所有用户角色列表
     */
    @Select("select * from sys_role")
    List<Role> findAll();

    /**
     *      根据ID删除用户角色
     * @param id
     */
    @Delete("delete from sys_role where id = #{id}")
    void deleteById(Integer id);

    /**
     *      新增用户角色
     * @param role
     */
    @Insert("insert into sys_role(id, role_name, role_code, description, status, create_time) VALUES (#{id},#{roleName},#{roleCode},#{description},#{status},#{createTime})")
    void insert(Role role);

    /**
     *      更新用户角色
     * @param role
     */
    @Update("update sys_role set role_name = #{roleName},role_code = #{roleCode},description = #{description},status = #{status},create_time = #{createTime} where id = #{id}")
    void update(Role role);

    /**
     *      根据角色名称查询用户角色
     * @param roleName
     * @return
     */
    @Select("select sys_role.id,sys_role.role_name,sys_role.role_code,sys_role.description,sys_role.status,sys_role.create_time from sys_role where role_name = #{roleName}")
    Role getByroleName(String roleName);
}

