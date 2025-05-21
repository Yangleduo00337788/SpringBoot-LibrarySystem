	package com.example.service.impl;

import com.example.entity.User;
import com.example.mapper.UserMapper;
import com.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;

    /*
            查询用户
     */
    public List<User> findAll(){
        return userMapper.findAll();
    }
    /*
            根据ID删除用户
     */
    public void deleteById(Integer id){
        userMapper.deleteById(id);
    }

    public void save(User user){
        //保存用户
        userMapper.insert(user);
    }

    /**
     *      根据ID查询用户
      * @param id
     * @return
     */
    public User getById(Integer id){
        return userMapper.getById(id);
    }

    /**
     *      修改用户
     * @param user
     */
    @Override
    public void update(User user) {
        userMapper.update(user);
    }
}
