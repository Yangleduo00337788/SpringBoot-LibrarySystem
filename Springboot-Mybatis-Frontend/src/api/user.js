import request from './request'

export const userApi = {
  // 获取所有用户
  getAllUsers() {
    return request.get('/users')
  },

  // 根据ID获取用户
  getById(id) {
    if (!id) {
      return Promise.reject(new Error('用户ID不能为空'))
    }
    return request.get(`/users/${id}`)
  },

  // 创建用户
  createUser(data) {
    if (!data.username || !data.password) {
      return Promise.reject(new Error('用户名和密码不能为空'))
    }
    // 确保日期格式正确
    const userData = {
      ...data,
      createTime: data.createTime ? new Date(data.createTime).toISOString() : new Date().toISOString(),
      updateTime: new Date().toISOString(),
      lastLoginTime: data.lastLoginTime ? new Date(data.lastLoginTime).toISOString() : null
    }
    console.log('Creating user with data:', userData)
    return request.post('/users', userData)
  },

  // 更新用户
  updateUser(id, data) {
    if (!id) {
      return Promise.reject(new Error('用户ID不能为空'))
    }
    // 确保日期格式正确
    const userData = {
      ...data,
      createTime: data.createTime ? new Date(data.createTime).toISOString() : new Date().toISOString(),
      updateTime: new Date().toISOString(),
      lastLoginTime: data.lastLoginTime ? new Date(data.lastLoginTime).toISOString() : null
    }
    console.log('Updating user with data:', userData)
    return request.put(`/users/${id}`, userData)
  },

  // 删除用户
  deleteUser(id) {
    if (!id) {
      return Promise.reject(new Error('用户ID不能为空'))
    }
    return request.delete(`/users/${id}`)
  }
} 