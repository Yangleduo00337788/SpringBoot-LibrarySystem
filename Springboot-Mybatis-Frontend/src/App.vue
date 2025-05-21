<template>
  <el-container class="app-wrapper">
    <!-- 侧边栏 -->
    <el-aside width="200px" class="sidebar-container">
      <div class="logo-container">
        <img src="./assets/logo.png" alt="Logo" class="logo-img">
        <span class="logo-text">养乐多管理系统</span>
      </div>
      
      <el-menu
        :default-active="$route.path"
        class="el-menu-vertical"
        background-color="#304156"
        text-color="#bfcbd9"
        active-text-color="#409EFF"
        router
        unique-opened
      >
        <el-menu-item index="/">
          <el-icon><HomeFilled /></el-icon>
          <template #title>首页</template>
        </el-menu-item>

        <el-sub-menu index="/system">
          <template #title>
            <el-icon><Setting /></el-icon>
            <span>系统管理</span>
          </template>
          <el-menu-item index="/users">
            <el-icon><User /></el-icon>
            <span>用户管理</span>
          </el-menu-item>
          <el-menu-item index="/roles">
            <el-icon><UserFilled /></el-icon>
            <span>角色管理</span>
          </el-menu-item>
        </el-sub-menu>

        <el-menu-item index="/about">
          <el-icon><InfoFilled /></el-icon>
          <template #title>联系作者</template>
        </el-menu-item>
      </el-menu>
    </el-aside>

    <!-- 主要内容区 -->
    <el-container class="main-container">
      <!-- 头部 -->
      <el-header class="main-header">
        <div class="header-left">
          <el-breadcrumb separator="/">
            <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
            <el-breadcrumb-item v-if="$route.meta.title">{{ $route.meta.title }}</el-breadcrumb-item>
          </el-breadcrumb>
        </div>
        <div class="header-right">
          <el-dropdown>
            <span class="user-dropdown">
              <el-avatar :size="32" src="https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png" />
              <span class="user-name">管理员</span>
            </span>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item>个人信息</el-dropdown-item>
                <el-dropdown-item>修改密码</el-dropdown-item>
                <el-dropdown-item divided>退出登录</el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>
        </div>
      </el-header>

      <!-- 内容区 -->
      <el-main class="app-main">
        <router-view></router-view>
      </el-main>
    </el-container>
  </el-container>
</template>

<script>
import { HomeFilled, Setting, User, UserFilled, InfoFilled } from '@element-plus/icons-vue'

export default {
  name: 'App',
  components: {
    HomeFilled,
    Setting,
    User,
    UserFilled,
    InfoFilled
  }
}
</script>

<style>
:root {
  --sidebar-width: 200px;
  --header-height: 60px;
}

html, body {
  margin: 0;
  padding: 0;
  height: 100%;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
}

#app {
  height: 100%;
}

.app-wrapper {
  height: 100%;
}

/* 侧边栏样式 */
.sidebar-container {
  background-color: #304156;
  height: 100%;
  position: fixed;
  left: 0;
  top: 0;
  bottom: 0;
  overflow-y: auto;
}

.logo-container {
  height: var(--header-height);
  padding: 14px 16px;
  display: flex;
  align-items: center;
  background: #304156;
  overflow: hidden;
  white-space: nowrap;
  transition: all 0.3s ease;
}

.logo-img {
  width: 32px;
  height: 32px;
  margin-right: 12px;
  transition: transform 0.3s ease;
  object-fit: contain;
}

.logo-img:hover {
  transform: scale(1.05);
}

.logo-text {
  color: #fff;
  font-size: 16px;
  font-weight: 600;
  opacity: 1;
  transition: all 0.3s;
  font-family: 'PingFang SC', 'Microsoft YaHei', sans-serif;
  letter-spacing: 0.5px;
}

.el-menu {
  border-right: none;
  background-color: #304156;
}

/* 主容器样式 */
.main-container {
  margin-left: var(--sidebar-width);
  min-height: 100%;
}

.main-header {
  background: #fff;
  box-shadow: 0 1px 4px rgba(0,21,41,.08);
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: var(--header-height) !important;
  padding: 0 20px;
}

.header-right {
  display: flex;
  align-items: center;
}

.user-dropdown {
  display: flex;
  align-items: center;
  cursor: pointer;
}

.user-name {
  margin-left: 8px;
  font-size: 14px;
  color: #606266;
}

.app-main {
  padding: 20px;
  background-color: #f0f2f5;
  min-height: calc(100vh - var(--header-height));
}

/* Element Plus 样式覆盖 */
.el-menu-vertical:not(.el-menu--collapse) {
  width: 100%;
}

.el-menu--vertical .el-menu-item {
  height: 50px;
  line-height: 50px;
}

.el-menu-item [class^="el-icon"] {
  margin-right: 5px;
  width: 24px;
  text-align: center;
  font-size: 18px;
}

.el-sub-menu__title {
  height: 50px;
  line-height: 50px;
}
</style> 