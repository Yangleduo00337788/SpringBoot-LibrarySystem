<template>
  <div class="role-form-container">
    <el-card class="box-card">
      <template #header>
        <div class="card-header">
          <span>{{ isEdit ? '编辑角色' : '添加角色' }}</span>
        </div>
      </template>

      <el-form
        ref="formRef"
        :model="roleForm"
        :rules="rules"
        label-width="100px"
        class="role-form"
      >
        <el-form-item label="角色名称" prop="roleName">
          <el-input v-model="roleForm.roleName" placeholder="请输入角色名称" />
        </el-form-item>

        <el-form-item label="角色编码" prop="roleCode">
          <el-input v-model="roleForm.roleCode" placeholder="请输入角色编码" />
        </el-form-item>

        <el-form-item label="角色描述" prop="description">
          <el-input
            v-model="roleForm.description"
            type="textarea"
            :rows="4"
            placeholder="请输入角色描述"
          />
        </el-form-item>

        <el-form-item label="状态" prop="status">
          <el-switch
            v-model="roleForm.status"
            :active-value="1"
            :inactive-value="0"
            active-text="启用"
            inactive-text="禁用"
          />
        </el-form-item>

        <el-form-item>
          <el-button type="primary" @click="submitForm">保存</el-button>
          <el-button @click="cancel">取消</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { roleApi } from '../api/role'

const route = useRoute()
const router = useRouter()
const formRef = ref(null)
const isEdit = ref(false)

const roleForm = ref({
  roleName: '',
  roleCode: '',
  description: '',
  status: 1,
  createTime: new Date()
})

const rules = {
  roleName: [
    { required: true, message: '请输入角色名称', trigger: 'blur' },
    { min: 2, max: 20, message: '长度在 2 到 20 个字符', trigger: 'blur' }
  ],
  roleCode: [
    { required: true, message: '请输入角色编码', trigger: 'blur' },
    { min: 2, max: 20, message: '长度在 2 到 20 个字符', trigger: 'blur' }
  ],
  description: [
    { max: 200, message: '描述不能超过200个字符', trigger: 'blur' }
  ]
}

const submitForm = async () => {
  if (!formRef.value) return
  
  await formRef.value.validate(async (valid) => {
    if (valid) {
      try {
        let response
        const formData = {
          roleName: roleForm.value.roleName,
          roleCode: roleForm.value.roleCode,
          description: roleForm.value.description || '',
          status: roleForm.value.status,
          createTime: roleForm.value.createTime || new Date()
        }
        
        console.log('Submitting form data:', formData)
        
        if (isEdit.value) {
          const id = route.params.id
          console.log('Updating role with ID:', id, 'Data:', formData)
          response = await roleApi.updateRole(id, formData)
        } else {
          console.log('Creating new role:', formData)
          response = await roleApi.createRole(formData)
        }
        
        console.log('Submit response:', response)
        
        if (response.data && response.data.code === 1) {
          ElMessage.success(isEdit.value ? '角色更新成功' : '角色添加成功')
          router.push('/roles')
        } else {
          throw new Error(response.data?.msg || '操作失败')
        }
      } catch (error) {
        console.error('Submit error:', error)
        ElMessage.error(error.message || '操作失败，请检查表单数据')
      }
    } else {
      ElMessage.warning('请填写必要的表单项')
    }
  })
}

const cancel = () => {
  router.push('/roles')
}

onMounted(async () => {
  const id = route.params.id
  const roleName = route.query.roleName
  
  if (id && roleName) {
    isEdit.value = true
    try {
      console.log('Fetching role data for ID:', id, 'roleName:', roleName)
      const response = await roleApi.getRoleById(id, roleName)
      console.log('Received response:', response)
      
      if (response.data && response.data.code === 1) {
        const roleData = response.data.data
        console.log('Role data:', roleData)
        
        if (!roleData) {
          ElMessage.error('未找到角色数据')
          router.push('/roles')
          return
        }
        
        // 确保所有必要的字段都存在
        roleForm.value = {
          roleName: roleData.roleName || '',
          roleCode: roleData.roleCode || '',
          description: roleData.description || '',
          status: roleData.status ?? 1,
          createTime: roleData.createTime || new Date()
        }
        console.log('Updated form data:', roleForm.value)
      }
    } catch (error) {
      console.error('Error fetching role data:', error)
      ElMessage.error('获取角色数据失败')
      router.push('/roles')
    }
  }
})
</script>

<style scoped>
.role-form-container {
  padding: 20px;
}

.role-form {
  max-width: 600px;
  margin: 0 auto;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}
</style> 