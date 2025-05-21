import request from './request'

export const roleApi = {
  // 获取所有角色
  getAllRoles() {
    return request.get('/roles')
  },

  // 根据角色名称获取角色
  getRoleById(id, roleName) {
    if (!roleName) {
      return Promise.reject(new Error('角色名称不能为空'))
    }
    return request.get(`/roles/${roleName}`)
  },

  // 根据角色名称获取角色
  getRoleByName(roleName) {
    return request.get(`/roles/${roleName}`)
  },

  // 创建角色
  createRole(data) {
    if (!data.roleName || !data.roleCode) {
      return Promise.reject(new Error('角色名称和编码不能为空'))
    }
    // 确保日期格式正确
    const roleData = {
      ...data,
      createTime: data.createTime ? new Date(data.createTime).toISOString() : new Date().toISOString()
    }
    console.log('Creating role with data:', roleData)
    return request.post('/roles', roleData)
  },

  // 更新角色
  updateRole(id, data) {
    if (!id) {
      return Promise.reject(new Error('角色ID不能为空'))
    }
    if (!data.roleName || !data.roleCode) {
      return Promise.reject(new Error('角色名称和编码不能为空'))
    }
    // 确保日期格式正确
    const roleData = {
      ...data,
      createTime: data.createTime ? new Date(data.createTime).toISOString() : new Date().toISOString()
    }
    console.log('Updating role with data:', roleData)
    return request.put(`/roles/${id}`, roleData)
  },

  // 删除角色
  deleteRole(id) {
    if (!id) {
      return Promise.reject(new Error('角色ID不能为空'))
    }
    return request.delete(`/roles/${id}`)
  }
} 