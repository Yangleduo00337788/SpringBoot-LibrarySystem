<template>
  <div class="user-list-container">
    <el-card class="box-card">
      <template #header>
        <div class="card-header">
          <span>用户管理</span>
        </div>
      </template>

      <!-- 搜索区域 -->
      <el-form :inline="true" :model="searchForm" class="search-form">
        <el-form-item label="用户ID">
          <el-input
            v-model="searchForm.id"
            placeholder="请输入用户ID"
            clearable
            @keyup.enter="handleSearch"
          />
        </el-form-item>
        <el-form-item label="用户名">
          <el-input
            v-model="searchForm.username"
            placeholder="请输入用户名"
            clearable
            @keyup.enter="handleSearch"
          />
        </el-form-item>
        <el-form-item label="状态">
          <el-select v-model="searchForm.status" placeholder="请选择状态" clearable>
            <el-option label="全部" value="" />
            <el-option label="启用" :value="1" />
            <el-option label="禁用" :value="0" />
          </el-select>
        </el-form-item>
        <el-form-item>
          <div class="button-group">
            <el-button type="primary" @click="handleSearch">
              <el-icon><Search /></el-icon> 搜索
            </el-button>
            <el-button @click="handleReset">
              <el-icon><Refresh /></el-icon> 重置
            </el-button>
            <el-button type="primary" @click="handleAdd">
              <el-icon><Plus /></el-icon> 新增用户
            </el-button>
          </div>
        </el-form-item>
      </el-form>

      <!-- 表格 -->
      <el-table
        v-loading="loading"
        :data="filteredList"
        border
        stripe
        style="width: 100%"
      >
        <el-table-column prop="id" label="ID" width="80" align="center" />
        <el-table-column prop="username" label="用户名" width="150" align="center" />
        <el-table-column prop="name" label="姓名" width="150" align="center" />
        <el-table-column prop="age" label="年龄" width="80" align="center" />
        <el-table-column prop="gender" label="性别" width="100" align="center">
          <template #default="scope">
            <el-tag
              :type="getGenderType(scope.row.gender)"
              size="small"
            >
              {{ getGenderText(scope.row.gender) }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="email" label="邮箱" min-width="200" align="center" />
        <el-table-column prop="phone" label="电话" width="150" align="center" />
        <el-table-column prop="role" label="角色" width="100" align="center">
          <template #default="scope">
            <el-tag :type="getRoleType(scope.row.role)" size="small">
              {{ getRoleText(scope.row.role) }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="status" label="状态" width="100" align="center">
          <template #default="scope">
            <el-switch
              v-model="scope.row.status"
              :active-value="1"
              :inactive-value="0"
              @change="handleStatusChange(scope.row)"
            />
          </template>
        </el-table-column>
        <el-table-column label="操作" fixed="right" width="280" align="center">
          <template #default="scope">
            <el-button-group class="operation-buttons">
              <el-button
                type="primary"
                :icon="View"
                size="small"
                @click="handleView(scope.row)"
              >
                查看
              </el-button>
              <el-button
                type="warning"
                :icon="Edit"
                size="small"
                @click="handleEdit(scope.row)"
              >
                编辑
              </el-button>
              <el-button
                type="danger"
                :icon="Delete"
                size="small"
                @click="handleDelete(scope.row)"
              >
                删除
              </el-button>
            </el-button-group>
          </template>
        </el-table-column>
      </el-table>

      <!-- 分页 -->
      <div class="pagination-container">
        <el-pagination
          v-model:current-page="currentPage"
          v-model:page-size="pageSize"
          :page-sizes="[10, 20, 50, 100]"
          :total="total"
          layout="total, sizes, prev, pager, next, jumper"
          :background="true"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
        />
      </div>
    </el-card>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Plus, Search, Refresh, View, Edit, Delete } from '@element-plus/icons-vue'
import { userApi } from '../api/user'

const router = useRouter()
const loading = ref(false)
const userList = ref([])
const filteredList = ref([])
const total = ref(0)
const currentPage = ref(1)
const pageSize = ref(10)

// 性别显示辅助函数
const getGenderText = (gender) => {
  const genderMap = {
    'M': '男',
    'F': '女'
  }
  return genderMap[gender] || '其他'
}

const getGenderType = (gender) => {
  const typeMap = {
    'M': 'primary',
    'F': 'success'
  }
  return typeMap[gender] || 'info'
}

const searchForm = ref({
  id: '',
  username: '',
  status: ''
})

// 获取用户列表
const fetchUserList = async () => {
  loading.value = true
  try {
    const response = await userApi.getAllUsers()
    console.log('获取到的用户列表数据:', response.data)
    
    // 确保数据是数组
    if (response.data && response.data.data) {
      userList.value = Array.isArray(response.data.data) ? response.data.data : []
    } else {
      userList.value = Array.isArray(response.data) ? response.data : []
    }
    
    console.log('处理后的用户列表:', userList.value)
    filterAndPaginateData() // 过滤和分页数据
  } catch (error) {
    console.error('获取用户列表失败:', error)
    ElMessage({
      message: error.message || '获取用户列表失败',
      type: 'error',
      duration: 5000,
      showClose: true
    })
    userList.value = []
    filterAndPaginateData() // 重置表格显示
  } finally {
    loading.value = false
  }
}

// 过滤和分页数据
const filterAndPaginateData = () => {
  console.log('开始过滤数据, 当前搜索条件:', searchForm.value)
  // 1. 应用搜索过滤
  let filtered = userList.value.filter(item => {
    const matchId = !searchForm.value.id || item.id.toString().includes(searchForm.value.id)
    const matchUsername = !searchForm.value.username || 
                        item.username.toLowerCase().includes(searchForm.value.username.toLowerCase())
    const matchStatus = searchForm.value.status === '' || 
                       searchForm.value.status === null || 
                       item.status === searchForm.value.status
    return matchId && matchUsername && matchStatus
  })

  console.log('过滤后的数据条数:', filtered.length)

  // 2. 更新总数
  total.value = filtered.length

  // 3. 应用分页
  const start = (currentPage.value - 1) * pageSize.value
  const end = start + pageSize.value
  filteredList.value = filtered.slice(start, end)
  console.log('当前页数据:', filteredList.value)
}

// 搜索
const handleSearch = () => {
  currentPage.value = 1 // 搜索时重置到第一页
  filterAndPaginateData()
}

// 重置搜索
const handleReset = () => {
  searchForm.value = {
    id: '',
    username: '',
    status: ''
  }
  currentPage.value = 1
  filterAndPaginateData()
}

// 新增用户
const handleAdd = () => {
  router.push('/users/add')
}

// 查看用户
const handleView = async (row) => {
  try {
    console.log('查看用户详情:', row.id)
    if (!row.id) {
      ElMessage.error('无效的用户ID')
      return
    }

    // 先验证用户是否存在
    try {
      await userApi.getUserById(row.id)
      router.push(`/users/${row.id}`).catch(err => {
        console.error('路由跳转失败:', err)
        ElMessage.error('页面跳转失败，请稍后重试')
      })
    } catch (error) {
      console.error('获取用户详情失败:', error)
      ElMessage.error('用户不存在或已被删除')
    }
  } catch (error) {
    console.error('查看用户详情失败:', error)
    ElMessage.error('操作失败，请稍后重试')
  }
}

// 编辑用户
const handleEdit = (row) => {
  router.push(`/users/edit/${row.id}`)
}

// 删除用户
const handleDelete = (row) => {
  ElMessageBox.confirm(
    `确认删除用户"${row.username}"吗？`,
    '警告',
    {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning',
    }
  ).then(async () => {
    try {
      await userApi.deleteUser(row.id)
      ElMessage.success('删除成功')
      fetchUserList()
    } catch (error) {
      ElMessage.error('删除失败：' + error.message)
    }
  })
}

// 修改用户状态
const handleStatusChange = async (row) => {
  try {
    const updateData = {
      id: row.id,
      username: row.username,
      password: row.password,
      name: row.name,
      age: row.age,
      gender: row.gender,
      email: row.email,
      phone: row.phone,
      status: row.status,
      address: row.address,
      avatar: row.avatar,
      role: row.role,
      createTime: row.createTime || new Date(),
      updateTime: new Date(),
      lastLoginTime: row.lastLoginTime
    }
    console.log('Updating user status:', updateData)
    
    const response = await userApi.updateUser(row.id, updateData)
    if (response.data && response.data.code === 1) {
      ElMessage.success('状态更新成功')
      // 更新成功后重新获取列表
      await fetchUserList()
    } else {
      throw new Error(response.data?.msg || '更新失败')
    }
  } catch (error) {
    console.error('Status update error:', error)
    // 恢复原状态
    row.status = row.status === 1 ? 0 : 1
    ElMessage.error('状态更新失败：' + error.message)
  }
}

// 角色类型
const getRoleType = (role) => {
  const types = {
    admin: 'danger',
    editor: 'warning',
    user: ''
  }
  return types[role] || ''
}

// 角色文本
const getRoleText = (role) => {
  const texts = {
    admin: '管理员',
    editor: '编辑者',
    user: '普通用户'
  }
  return texts[role] || role
}

// 分页大小改变
const handleSizeChange = (val) => {
  pageSize.value = val
  currentPage.value = 1 // 重置到第一页
  filterAndPaginateData()
}

// 页码改变
const handleCurrentChange = (val) => {
  currentPage.value = val
  filterAndPaginateData()
}

// 头像加载失败处理
const handleAvatarError = () => {
  console.warn('Avatar loading failed, using default avatar')
}

onMounted(() => {
  fetchUserList()
})
</script>

<style scoped>
.user-list-container {
  padding: 20px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.search-form {
  margin-bottom: 20px;
  background-color: #fff;
  padding: 20px;
  border-radius: 4px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

.button-group {
  display: flex;
  gap: 10px;
  align-items: center;
}

:deep(.el-form-item) {
  margin-bottom: 18px;
  margin-right: 20px;
}

:deep(.el-form-item__label) {
  padding-right: 12px;
}

:deep(.el-input) {
  width: 220px;
}

:deep(.el-select) {
  width: 220px;
}

.pagination-container {
  margin-top: 20px;
  display: flex;
  justify-content: center;
}

.operation-buttons {
  display: inline-flex;
  white-space: nowrap;
}

.operation-buttons .el-button {
  margin-right: 0;
  padding: 5px 10px;
}

.operation-buttons .el-button + .el-button {
  margin-left: -1px;
}
</style> 