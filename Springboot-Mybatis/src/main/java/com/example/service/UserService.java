package com.example.service;

import com.example.entity.User;

import java.util.List;

public interface UserService {
    /*
        查询所有用户
     */
    List<User> findAll();

    /*
        根据ID删除用户
     */
    void deleteById(Integer id);

    /*
        新增用户
     */
    void save(User user);

    /*
        根据ID查询用户
     */
    User getById(Integer id);

    /*
        修改用户
     */
    void update(User user);
}
