<template>
  <div class="home-container">
    <!-- 统计卡片 -->
    <el-row :gutter="20">
      <el-col :span="6">
        <el-card shadow="hover" class="statistics-card">
          <template #header>
            <div class="card-header">
              <span>用户总数</span>
              <el-icon class="icon"><User /></el-icon>
            </div>
          </template>
          <div class="statistics-value">
            <span class="number">{{ statistics.userCount }}</span>
            <span class="unit">人</span>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card shadow="hover" class="statistics-card">
          <template #header>
            <div class="card-header">
              <span>角色总数</span>
              <el-icon class="icon"><UserFilled /></el-icon>
            </div>
          </template>
          <div class="statistics-value">
            <span class="number">{{ statistics.roleCount }}</span>
            <span class="unit">个</span>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card shadow="hover" class="statistics-card">
          <template #header>
            <div class="card-header">
              <span>今日访问</span>
              <el-icon class="icon"><View /></el-icon>
            </div>
          </template>
          <div class="statistics-value">
            <span class="number">{{ statistics.todayVisits }}</span>
            <span class="unit">次</span>
          </div>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card shadow="hover" class="statistics-card">
          <template #header>
            <div class="card-header">
              <span>系统消息</span>
              <el-icon class="icon"><Message /></el-icon>
            </div>
          </template>
          <div class="statistics-value">
            <span class="number">{{ statistics.messageCount }}</span>
            <span class="unit">条</span>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 快捷操作 -->
    <div class="quick-actions">
      <el-row :gutter="15">
        <el-col :span="12">
          <el-button type="primary" class="action-button" @click="handleQuickAction('addUser')">
            <el-icon><Plus /></el-icon>
            <span>添加用户</span>
          </el-button>
        </el-col>
        <el-col :span="12">
          <el-button type="success" class="action-button" @click="handleQuickAction('addRole')">
            <el-icon><Plus /></el-icon>
            <span>添加角色</span>
          </el-button>
        </el-col>
      </el-row>
      <el-row :gutter="15">
        <el-col :span="12">
          <el-button type="warning" class="action-button" @click="handleQuickAction('systemSettings')">
            <el-icon><Setting /></el-icon>
            <span>系统设置</span>
          </el-button>
        </el-col>
        <el-col :span="12">
          <el-button type="info" class="action-button" @click="handleQuickAction('messageCenter')">
            <el-icon><Message /></el-icon>
            <span>消息中心</span>
          </el-button>
        </el-col>
      </el-row>
    </div>

    <!-- 系统公告 -->
    <el-row :gutter="20" class="system-info">
      <el-col :span="24">
        <el-card shadow="hover">
          <template #header>
            <div class="card-header">
              <span>系统公告</span>
            </div>
          </template>
          <el-timeline>
            <el-timeline-item
              v-for="(activity, index) in activities"
              :key="index"
              :timestamp="activity.timestamp"
              :type="activity.type"
            >
              {{ activity.content }}
            </el-timeline-item>
          </el-timeline>
        </el-card>
      </el-col>
    </el-row>

    <!-- 系统信息 -->
    <el-row :gutter="20" class="system-info">
      <el-col :span="24">
        <el-card shadow="hover">
          <template #header>
            <div class="card-header">
              <span>系统信息</span>
            </div>
          </template>
          <el-descriptions :column="3" border>
            <el-descriptions-item label="系统名称">用户角色管理系统</el-descriptions-item>
            <el-descriptions-item label="系统开发人员">养乐多</el-descriptions-item>
            <el-descriptions-item label="服务器环境">Spring Boot 2.7.x</el-descriptions-item>
            <el-descriptions-item label="数据库">MySQL 8.0</el-descriptions-item>
            <el-descriptions-item label="前端框架">Vue 3 + Element Plus</el-descriptions-item>
            <el-descriptions-item label="操作系统">Windows Server</el-descriptions-item>
          </el-descriptions>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { User, UserFilled, View, Message, Plus, Setting } from '@element-plus/icons-vue'

const router = useRouter()

// 统计数据
const statistics = ref({
  userCount: 128,
  roleCount: 5,
  todayVisits: 1234,
  messageCount: 12
})

// 系统公告
const activities = ref([
  {
    content: '系统更新：新增角色权限管理功能',
    timestamp: '2025-04-30',
    type: 'primary'
  },
  {
    content: '系统维护通知：将于本周日凌晨2点进行系统维护',
    timestamp: '2025-04-14',
    type: 'warning'
  },
  {
    content: '系统设置和消息中心功能努力开发中...',
    timestamp: '2025-05-01',
    type: 'success'
  },
  {
    content: '系统通知：本系统开发时间如下显示，历时2月',
    timestamp: '2025-05-13',
    type: 'success'
  }
])

// 快捷操作处理
const handleQuickAction = (action) => {
  switch (action) {
    case 'addUser':
      router.push('/users/add')
      break
    case 'addRole':
      router.push('/roles/add')
      break
    case 'systemSettings':
      ElMessage.info('系统设置功能开发中...')
      break
    case 'messageCenter':
      ElMessage.info('消息中心功能开发中...')
      break
  }
}
</script>

<style scoped>
.home-container {
  padding: 20px;
  background-color: #f5f7fa;
  min-height: calc(100vh - 60px);
}

.el-row {
  margin-bottom: 20px;
}

.el-row:last-child {
  margin-bottom: 0;
}

.statistics-card {
  transition: all 0.3s;
}

.statistics-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 2px 12px 0 rgba(0,0,0,.1);
}

.statistics-card .card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.statistics-card .card-header span {
  font-size: 16px;
  font-weight: 500;
}

.statistics-card .icon {
  font-size: 24px;
}

.statistics-card .icon.el-icon {
  background: #ecf5ff;
  padding: 10px;
  border-radius: 50%;
  color: #409EFF;
}

.statistics-card .statistics-value {
  text-align: center;
  padding: 10px 0;
}

.statistics-card .statistics-value .number {
  font-size: 36px;
  font-weight: bold;
  color: #303133;
  margin-right: 5px;
}

.statistics-card .statistics-value .unit {
  font-size: 14px;
  color: #909399;
}

.quick-actions {
  margin: 15px 0;
}

.quick-actions .el-row {
  margin-bottom: 15px;
}

.quick-actions .el-row:last-child {
  margin-bottom: 0;
}

.action-button {
  width: 100%;
  height: 45px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 14px;
  border: none;
  border-radius: 4px;
  transition: all 0.3s;
  padding: 0;
  margin: 0;
}

.action-button .el-icon {
  font-size: 16px;
  margin-right: 6px;
}

.action-button:hover {
  transform: translateY(-2px);
  opacity: 0.9;
}

/* 定制按钮颜色 */
.action-button.el-button--primary {
  background-color: #409EFF;
}

.action-button.el-button--success {
  background-color: #67C23A;
}

.action-button.el-button--warning {
  background-color: #E6A23C;
}

.action-button.el-button--info {
  background-color: #909399;
}

.el-timeline {
  padding: 10px;
  max-height: 280px;
  overflow-y: auto;
}

.el-timeline .el-timeline-item {
  padding-bottom: 20px;
}

.el-timeline .el-timeline-item:last-child {
  padding-bottom: 0;
}

.el-timeline .el-timeline-item .el-timeline-item__content {
  color: #606266;
}

.el-timeline .el-timeline-item .el-timeline-item__timestamp {
  font-size: 13px;
  color: #909399;
}

.system-info {
  margin-top: 20px;
}

.system-info :deep(.el-descriptions) {
  padding: 10px;
}

.system-info :deep(.el-descriptions) .el-descriptions__label {
  width: 120px;
  color: #606266;
  font-weight: 500;
}

.system-info :deep(.el-descriptions) .el-descriptions__content {
  color: #303133;
}

.el-card {
  border-radius: 8px;
  overflow: hidden;
}

.el-card :deep(.el-card__header) {
  padding: 15px 20px;
  border-bottom: 1px solid #ebeef5;
  background: #fff;
}

.el-card :deep(.el-card__body) {
  padding: 20px;
}

@media screen and (max-width: 1200px) {
  .el-col-6 {
    width: 50%;
    margin-bottom: 20px;
  }
}

@media screen and (max-width: 768px) {
  .el-col-6 {
    width: 100%;
  }
  
  .quick-actions .quick-actions-grid {
    grid-template-columns: 1fr;
  }
}
</style> 