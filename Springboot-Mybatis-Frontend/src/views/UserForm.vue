<template>
  <div class="user-form-container">
    <el-card class="box-card">
      <template #header>
        <div class="card-header">
          <span>{{ isEdit ? '编辑用户' : '新增用户' }}</span>
          <el-button @click="goBack">
            <el-icon><Back /></el-icon> 返回
          </el-button>
        </div>
      </template>

      <el-form
        ref="formRef"
        :model="userForm"
        :rules="rules"
        label-width="100px"
        class="user-form"
      >
        <el-form-item label="用户名" prop="username">
          <el-input v-model="userForm.username" placeholder="请输入用户名" />
        </el-form-item>

        <el-form-item label="密码" prop="password" v-if="!isEdit">
          <el-input
            v-model="userForm.password"
            type="password"
            placeholder="请输入密码"
            show-password
          />
        </el-form-item>

        <el-form-item label="姓名" prop="name">
          <el-input v-model="userForm.name" placeholder="请输入姓名" />
        </el-form-item>

        <el-form-item label="年龄" prop="age">
          <el-input-number
            v-model="userForm.age"
            :min="1"
            :max="120"
            placeholder="请输入年龄"
          />
        </el-form-item>

        <el-form-item label="性别" prop="gender">
          <el-radio-group v-model="userForm.gender">
            <el-radio label="M">男</el-radio>
            <el-radio label="F">女</el-radio>
            <el-radio label="O">其他</el-radio>
          </el-radio-group>
        </el-form-item>

        <el-form-item label="角色" prop="role">
          <el-select v-model="userForm.role" placeholder="请选择角色">
            <el-option label="管理员" value="admin" />
            <el-option label="编辑" value="editor" />
            <el-option label="用户" value="user" />
          </el-select>
        </el-form-item>

        <el-form-item label="邮箱" prop="email">
          <el-input v-model="userForm.email" placeholder="请输入邮箱" />
        </el-form-item>

        <el-form-item label="电话" prop="phone">
          <el-input v-model="userForm.phone" placeholder="请输入电话号码" />
        </el-form-item>

        <el-form-item label="地址" prop="address">
          <el-input
            v-model="userForm.address"
            type="textarea"
            placeholder="请输入地址"
          />
        </el-form-item>

        <el-form-item label="头像" prop="avatar">
          <div class="avatar-uploader">
            <el-upload
              class="avatar-uploader"
              :auto-upload="false"
              :show-file-list="false"
              :on-change="handleAvatarChange"
              :before-upload="beforeAvatarUpload"
            >
              <img v-if="userForm.avatar" :src="userForm.avatar" class="avatar" />
              <el-icon v-else class="avatar-uploader-icon"><Plus /></el-icon>
            </el-upload>
            <div class="avatar-tip" v-if="!userForm.avatar">
              点击上传头像
            </div>
          </div>
        </el-form-item>

        <el-form-item label="状态" prop="status">
          <el-switch
            v-model="userForm.status"
            :active-value="1"
            :inactive-value="0"
            active-text="启用"
            inactive-text="禁用"
          />
        </el-form-item>

        <el-form-item>
          <el-button type="primary" @click="handleSubmit">
            {{ isEdit ? '保存修改' : '立即创建' }}
          </el-button>
          <el-button @click="goBack">取消</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { Back, Plus } from '@element-plus/icons-vue'
import { userApi } from '../api/user'

const route = useRoute()
const router = useRouter()
const formRef = ref(null)

// 判断是否为编辑模式
const isEdit = computed(() => route.name === 'UserEdit')

// 表单数据
const userForm = ref({
  username: '',
  password: '',  // 仅在新增时使用
  name: '',
  age: 18,
  gender: 'M',
  role: 'user',
  email: '',
  phone: '',
  address: '',
  avatar: '',  // 新增头像字段
  status: 1,
  createTime: null,  // 新增创建时间
  updateTime: null,  // 新增更新时间
  lastLoginTime: null  // 新增最后登录时间
})

// 表单验证规则
const rules = {
  username: [
    { required: true, message: '请输入用户名', trigger: 'blur' },
    { min: 3, max: 20, message: '长度在 3 到 20 个字符', trigger: 'blur' }
  ],
  password: [
    { required: !isEdit.value, message: '请输入密码', trigger: 'blur' },
    { min: 6, max: 20, message: '长度在 6 到 20 个字符', trigger: 'blur' }
  ],
  name: [
    { required: true, message: '请输入姓名', trigger: 'blur' },
    { min: 1, max: 50, message: '长度在 1 到 50 个字符', trigger: 'blur' }
  ],
  age: [
    { required: true, message: '请输入年龄', trigger: 'blur' },
    { type: 'number', message: '年龄必须为数字', trigger: 'blur' },
    { validator: (rule, value, callback) => {
      const age = Number(value)
      if (!Number.isInteger(age) || age < 1 || age > 120) {
        callback(new Error('年龄必须是1-120之间的整数'))
      } else {
        callback()
      }
    }, trigger: 'blur' }
  ],
  gender: [
    { required: true, message: '请选择性别', trigger: 'change' }
  ],
  role: [
    { required: true, message: '请选择角色', trigger: 'change' }
  ],
  email: [
    { type: 'email', message: '请输入正确的邮箱地址', trigger: 'blur' }
  ],
  phone: [
    { pattern: /^1[3-9]\d{9}$/, message: '请输入正确的手机号码', trigger: 'blur' }
  ],
  avatar: [
    { type: 'url', message: '请输入正确的URL地址', trigger: 'blur' }
  ]
}

// 获取用户详情
const getUserDetail = async (id) => {
  try {
    const response = await userApi.getUserById(id)
    const userData = response.data.data
    // 不显示密码字段
    delete userData.password
    Object.assign(userForm.value, userData)
  } catch (error) {
    ElMessage.error('获取用户信息失败：' + error.message)
    goBack()
  }
}

// 头像上传前的验证
const beforeAvatarUpload = (file) => {
  const isImage = file.type.startsWith('image/')
  const isLt2M = file.size / 1024 / 1024 < 2

  if (!isImage) {
    ElMessage.error('上传头像图片只能是图片格式!')
    return false
  }
  if (!isLt2M) {
    ElMessage.error('上传头像图片大小不能超过 2MB!')
    return false
  }
  return true
}

// 头像上传相关
const handleAvatarChange = async (file) => {
  if (!beforeAvatarUpload(file)) {
    return
  }

  try {
    const response = await userApi.uploadAvatar(file.raw)
    if (response.data.code === 200) {
      userForm.value.avatar = response.data.data.url
      ElMessage.success('头像上传成功')
    } else {
      ElMessage.error('头像上传失败：' + response.data.message)
    }
  } catch (error) {
    ElMessage.error('头像上传失败：' + error.message)
  }
}

// 提交表单
const handleSubmit = async () => {
  if (!formRef.value) return
  
  try {
    const valid = await formRef.value.validate()
    if (!valid) {
      ElMessage.warning('请检查表单填写是否正确')
      return false
    }

    if (isEdit.value) {
      const id = route.params.id
      if (!id || !/^\d+$/.test(id)) {
        ElMessage.error('无效的用户ID')
        return
      }

      // 获取原始数据
      const originalData = { ...userForm.value }

      // 规范化表单数据
      const formData = {
        username: originalData.username?.trim(),
        name: originalData.name?.trim(),
        age: Number(originalData.age),
        gender: originalData.gender,
        role: originalData.role,
        email: originalData.email?.trim(),
        phone: originalData.phone?.trim(),
        address: originalData.address?.trim(),
        status: Number(originalData.status)
      }

      // 验证必填字段
      const requiredFields = ['username', 'name', 'age', 'gender', 'role']
      const missingFields = requiredFields.filter(field => {
        const value = formData[field]
        return value === undefined || value === null || value === '' ||
               (typeof value === 'number' && isNaN(value))
      })

      if (missingFields.length > 0) {
        ElMessage.error(`请填写必填字段: ${missingFields.join(', ')}`)
        return
      }

      try {
        ElMessage({
          message: '正在更新用户信息...',
          type: 'info',
          duration: 1000
        })

        await userApi.updateUser(id, formData)
        
        ElMessage.success({
          message: '修改成功',
          type: 'success',
          duration: 2000
        })

        setTimeout(() => {
          goBack()
        }, 1000)
      } catch (error) {
        console.error('更新用户失败:', error)
        ElMessage.error({
          message: `修改失败: ${error.message}`,
          duration: 5000,
          showClose: true
        })
      }
    } else {
      // 添加用户时需要密码字段
      if (!userForm.value.password) {
        ElMessage.error('请输入密码')
        return
      }
      
      ElMessage({
        message: '正在添加用户...',
        type: 'info',
        duration: 1000
      })

      await userApi.addUser(userForm.value)
      ElMessage.success('添加成功')
      goBack()
    }
  } catch (error) {
    console.error('操作失败:', error)
    ElMessage({
      message: `操作失败: ${error.message}`,
      type: 'error',
      duration: 5000,
      showClose: true,
      grouping: true
    })
  }
}

// 返回上一页
const goBack = () => {
  router.push('/users')
}

// 如果是编辑模式，获取用户详情
onMounted(() => {
  if (isEdit.value && route.params.id) {
    getUserDetail(route.params.id)
  }
})
</script>

<style scoped>
.user-form-container {
  padding: 20px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.user-form {
  max-width: 600px;
  margin: 0 auto;
  padding: 20px;
}

:deep(.el-form-item__content) {
  justify-content: flex-start;
}

.avatar-uploader {
  text-align: center;
}

.avatar-uploader :deep(.el-upload) {
  border: 1px dashed var(--el-border-color);
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  transition: var(--el-transition-duration-fast);
}

.avatar-uploader :deep(.el-upload:hover) {
  border-color: var(--el-color-primary);
}

.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 100px;
  height: 100px;
  text-align: center;
  line-height: 100px;
}

.avatar {
  width: 100px;
  height: 100px;
  display: block;
  object-fit: cover;
}

.avatar-tip {
  font-size: 12px;
  color: #909399;
  margin-top: 8px;
}
</style> 