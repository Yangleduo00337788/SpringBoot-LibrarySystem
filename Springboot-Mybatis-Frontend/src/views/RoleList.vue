<template>
  <div class="role-list-container">
    <el-card class="box-card">
      <template #header>
        <div class="card-header">
          <span>角色管理</span>
        </div>
      </template>

      <!-- 搜索区域 -->
      <el-form :inline="true" :model="searchForm" class="search-form">
        <el-form-item label="角色名称">
          <el-input
            v-model="searchForm.roleName"
            placeholder="请输入角色名称"
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
              <el-icon><Plus /></el-icon> 新增角色
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
        <el-table-column prop="roleName" label="角色名称" width="150" align="center" />
        <el-table-column prop="roleCode" label="角色编码" width="150" align="center" />
        <el-table-column prop="description" label="描述" min-width="200" />
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
        <el-table-column prop="createTime" label="创建时间" width="180" align="center">
          <template #default="scope">
            {{ formatDate(scope.row.createTime) }}
          </template>
        </el-table-column>
        <el-table-column label="操作" fixed="right" width="220" align="center">
          <template #default="scope">
            <el-button-group class="operation-buttons">
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
import { Plus, Search, Refresh, Edit, Delete } from '@element-plus/icons-vue'
import { roleApi } from '../api/role'

const router = useRouter()
const loading = ref(false)
const roleList = ref([])
const filteredList = ref([])
const total = ref(0)
const currentPage = ref(1)
const pageSize = ref(10)

const searchForm = ref({
  roleName: '',
  status: ''
})

// 格式化日期
const formatDate = (date) => {
  if (!date) return ''
  return new Date(date).toLocaleString()
}

// 获取角色列表
const fetchRoleList = async () => {
  loading.value = true
  try {
    const response = await roleApi.getAllRoles()
    if (response.data && response.data.code === 1) {
      roleList.value = response.data.data || []
      handleFilter()
    } else {
      throw new Error(response.data?.msg || '获取数据失败')
    }
  } catch (error) {
    ElMessage.error('获取角色列表失败：' + error.message)
    roleList.value = []
  } finally {
    loading.value = false
  }
}

// 处理筛选和分页
const handleFilter = () => {
  let result = [...roleList.value]
  
  // 按角色名称筛选
  if (searchForm.value.roleName) {
    result = result.filter(item => 
      item.roleName.toLowerCase().includes(searchForm.value.roleName.toLowerCase())
    )
  }
  
  // 按状态筛选
  if (searchForm.value.status !== '' && searchForm.value.status !== null) {
    const status = parseInt(searchForm.value.status)
    result = result.filter(item => item.status === status)
  }
  
  // 计算总数
  total.value = result.length
  
  // 分页处理
  const start = (currentPage.value - 1) * pageSize.value
  const end = start + pageSize.value
  filteredList.value = result.slice(start, end)
}

// 搜索
const handleSearch = () => {
  currentPage.value = 1
  handleFilter()
}

// 重置
const handleReset = () => {
  searchForm.value.roleName = ''
  searchForm.value.status = ''
  currentPage.value = 1
  handleFilter()
}

// 新增角色
const handleAdd = () => {
  router.push('/roles/add')
}

// 编辑角色
const handleEdit = (row) => {
  console.log('Editing role:', row)
  router.push({
    path: `/roles/edit/${row.id}`,
    query: { roleName: row.roleName }
  })
}

// 删除角色
const handleDelete = (row) => {
  ElMessageBox.confirm(
    `确认删除角色"${row.roleName}"吗？`,
    '警告',
    {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning',
    }
  ).then(async () => {
    try {
      const response = await roleApi.deleteRole(row.id)
      if (response.data && response.data.code === 1) {
        ElMessage.success('删除成功')
        fetchRoleList()
      } else {
        throw new Error(response.data?.msg || '删除失败')
      }
    } catch (error) {
      ElMessage.error('删除失败：' + error.message)
    }
  })
}

// 修改角色状态
const handleStatusChange = async (row) => {
  try {
    const updateData = {
      id: row.id,
      roleName: row.roleName,
      roleCode: row.roleCode,
      description: row.description || '',
      status: row.status,
      createTime: row.createTime || new Date()
    }
    console.log('Updating role status:', updateData)
    
    const response = await roleApi.updateRole(row.id, updateData)
    if (response.data && response.data.code === 1) {
      ElMessage.success('状态更新成功')
      // 更新成功后重新获取列表
      await fetchRoleList()
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

// 分页大小改变
const handleSizeChange = (val) => {
  pageSize.value = val
  handleFilter()
}

// 当前页改变
const handleCurrentChange = (val) => {
  currentPage.value = val
  handleFilter()
}

onMounted(() => {
  fetchRoleList()
})
</script>

<style scoped>
.role-list-container {
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