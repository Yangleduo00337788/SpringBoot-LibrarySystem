package com.example.mapper;

import com.example.entity.User;
import org.apache.ibatis.annotations.*;

import java.util.List;
@Mapper
public interface UserMapper {
    /*
        查询所有用户
     */
    @Select("select * from users")
    List<User> findAll();

    /*
        根据ID删除用户
     */
    @Delete("delete from users where id = #{id}")
    void deleteById(Integer id);

    /*
        新增用户
     */
    @Insert("insert into users(username, password, name, age,email,phone,gender,create_time,update_time,status,address,avatar,last_login_time,role) VALUES (#{username},#{password},#{name},#{age},#{email},#{phone},#{gender},#{createTime},#{updateTime},#{status},#{address},#{avatar},#{lastLoginTime},#{role})")
    void insert(User user);

    /*
        根据ID查询用户数据
     */
    @Select("select users.id,users.username,users.password,users.name,users.age,users.email,users.phone,users.gender,users.create_time,users.update_time,users.status,users.address,users.avatar,users.last_login_time,users.role from users where id = #{id}")
    User getById(Integer id);

    /*
        更新用户
     */
    @Update("update users set username = #{username},password = #{password},name = #{name},age = #{age},email = #{email},phone = #{phone},gender = #{gender},create_time = #{createTime},update_time = #{updateTime},status = #{status},address = #{address},avatar = #{avatar},last_login_time = #{lastLoginTime},role = #{role} where id = #{id}")
    void update(User user);
}
