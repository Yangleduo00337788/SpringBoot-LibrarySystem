<template>
  <div class="user-detail-container">
    <el-card v-loading="loading">
      <template #header>
        <div class="card-header">
          <span>用户详情</span>
          <div class="action-buttons">
            <el-button type="primary" @click="handleEdit">
              <el-icon><Edit /></el-icon> 编辑
            </el-button>
            <el-button @click="goBack">
              <el-icon><Back /></el-icon> 返回
            </el-button>
          </div>
        </div>
      </template>
      
      <div v-if="user" class="user-info">
        <el-row :gutter="20">
          <el-col :span="6">
            <div class="avatar-container">
              <el-avatar :size="120" :src="user.avatar || 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png'" />
              <div class="status-indicator" :class="{ 'active': user.status === 1 }">
                {{ user.status === 1 ? '在线' : '离线' }}
              </div>
            </div>
          </el-col>
          <el-col :span="18">
            <div class="user-detail-header">
              <h2>{{ user.name || '未设置姓名' }} <span class="username">({{ user.username }})</span></h2>
              <el-tag :type="getRoleType(user.role)">{{ getRoleText(user.role) }}</el-tag>
            </div>
            <el-divider />
            <el-descriptions :column="2" border>
              <el-descriptions-item label="用户ID">{{ user.id }}</el-descriptions-item>
              <el-descriptions-item label="用户名">{{ user.username }}</el-descriptions-item>
              <el-descriptions-item label="姓名">{{ user.name || '未设置' }}</el-descriptions-item>
              <el-descriptions-item label="性别">
                <el-tag size="small" :type="user.gender === 'M' ? 'primary' : 'success'">
                  {{ user.gender === 'M' ? '男' : (user.gender === 'F' ? '女' : '其他') }}
                </el-tag>
              </el-descriptions-item>
              <el-descriptions-item label="年龄">{{ user.age || '未设置' }}</el-descriptions-item>
              <el-descriptions-item label="角色">{{ getRoleText(user.role) }}</el-descriptions-item>
              <el-descriptions-item label="电子邮箱" :span="2">
                <el-link v-if="user.email" type="primary" :href="'mailto:' + user.email">{{ user.email }}</el-link>
                <span v-else>未设置</span>
              </el-descriptions-item>
              <el-descriptions-item label="手机号码">
                <el-link v-if="user.phone" type="primary" :href="'tel:' + user.phone">{{ user.phone }}</el-link>
                <span v-else>未设置</span>
              </el-descriptions-item>
              <el-descriptions-item label="账号状态">
                <el-tag :type="user.status === 1 ? 'success' : 'danger'">
                  {{ user.status === 1 ? '正常' : '禁用' }}
                </el-tag>
              </el-descriptions-item>
              <el-descriptions-item label="创建时间">{{ formatDate(user.createTime) }}</el-descriptions-item>
              <el-descriptions-item label="最后更新">{{ formatDate(user.updateTime) }}</el-descriptions-item>
              <el-descriptions-item label="最后登录">{{ formatDate(user.lastLoginTime) }}</el-descriptions-item>
              <el-descriptions-item label="注册天数">{{ getDaysSinceRegistration(user.createTime) }}天</el-descriptions-item>
              <el-descriptions-item label="地址" :span="2">{{ user.address || '未设置' }}</el-descriptions-item>
            </el-descriptions>
          </el-col>
        </el-row>
      </div>
      
      <div v-else-if="!loading" class="no-data">
        <el-empty description="未找到用户数据" />
      </div>
    </el-card>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { Edit, Back } from '@element-plus/icons-vue'
import { userApi } from '../api/user'

const route = useRoute()
const router = useRouter()
const loading = ref(true)
const user = ref(null)
const userId = route.params.id

// 获取用户详情
const fetchUserDetail = async () => {
  loading.value = true
  try {
    const res = await userApi.getUserById(userId)
    user.value = res.data.data
  } catch (error) {
    ElMessage.error('获取用户详情失败: ' + error.message)
  } finally {
    loading.value = false
  }
}

// 处理编辑用户
const handleEdit = () => {
  router.push(`/users/edit/${userId}`)
}

// 返回用户列表
const goBack = () => {
  router.push('/users')
}

// 格式化日期
const formatDate = (dateStr) => {
  if (!dateStr) return '未设置'
  const date = new Date(dateStr)
  return new Intl.DateTimeFormat('zh-CN', {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit'
  }).format(date)
}

// 获取角色类型
const getRoleType = (role) => {
  switch (role) {
    case 'admin':
      return 'danger'
    case 'editor':
      return 'warning'
    case 'user':
      return 'info'
    default:
      return ''
  }
}

// 获取角色文本
const getRoleText = (role) => {
  switch (role) {
    case 'admin':
      return '管理员'
    case 'editor':
      return '编辑'
    case 'user':
      return '普通用户'
    default:
      return role || '未知'
  }
}

// 计算从注册到现在的天数
const getDaysSinceRegistration = (createTime) => {
  if (!createTime) return '未知'
  const createdDate = new Date(createTime)
  const now = new Date()
  const diffTime = Math.abs(now - createdDate)
  const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24))
  return diffDays
}

onMounted(() => {
  fetchUserDetail()
})
</script>

<style scoped>
.user-detail-container {
  padding: 20px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.action-buttons {
  display: flex;
  gap: 10px;
}

.user-info {
  padding: 20px 0;
}

.avatar-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 20px;
  background-color: #f9fafc;
  border-radius: 10px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.05);
}

.status-indicator {
  margin-top: 10px;
  padding: 2px 10px;
  border-radius: 10px;
  font-size: 12px;
  background-color: #f56c6c;
  color: white;
}

.status-indicator.active {
  background-color: #67c23a;
}

.user-detail-header {
  display: flex;
  align-items: center;
  margin-bottom: 20px;
}

.user-detail-header h2 {
  margin-right: 15px;
  color: #303133;
}

.username {
  color: #909399;
  font-weight: normal;
  font-size: 0.8em;
}

.no-data {
  padding: 40px 0;
  text-align: center;
}
</style> 