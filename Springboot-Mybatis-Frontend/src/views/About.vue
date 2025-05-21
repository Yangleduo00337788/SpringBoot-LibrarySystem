<template>
  <div class="about-container">
    <el-card class="about-card">
      <template #header>
        <div class="card-header">
          <span>关于作者</span>
        </div>
      </template>
      
      <div class="author-info">
        <el-avatar
          :size="100"
          src="https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png"
          class="author-avatar"
        />
        
        <h2 class="author-name">养乐多</h2>
        <p class="author-title">一名在校大学生，热爱编程，喜欢研究新技术</p>
        
        <div class="contact-list">
          <el-descriptions :column="1" border>
            <el-descriptions-item label="邮箱">
              <el-link type="primary" href="#">
                <el-icon><Message /></el-icon>
                Yangleduo0033@126.com
              </el-link>
            </el-descriptions-item>
            
            <el-descriptions-item label="GitHub">
              <el-link type="primary" href="https://github.com/Yangleduo00337788" target="_blank">
                <el-icon><Link /></el-icon>
                https://github.com/Yangleduo00337788
              </el-link>
            </el-descriptions-item>
            
            <el-descriptions-item label="微信">
              <el-popover
                placement="right"
                trigger="hover"
                width="200"
              >
                <template #reference>
                  <el-link type="success">
                    <el-icon><ChatDotRound /></el-icon>
                    点击查看微信二维码
                  </el-link>
                </template>
                <div class="qrcode-container">
                  <el-image
                    style="width: 180px; height: 180px"
                    :src="weixinQRCode"
                    fit="cover"
                  />
                  <div class="qrcode-text">扫码添加微信</div>
                </div>
              </el-popover>
            </el-descriptions-item>
          </el-descriptions>
          
        </div>

        <div class="skills-section">
          <h3>技术栈</h3>
          <div class="skill-tags">
            <el-tag>Vue3</el-tag>
            <el-tag>Spring Boot</el-tag>
            <el-tag>MyBatis</el-tag>
            <el-tag>Element Plus</el-tag>
            <el-tag>MySQL</el-tag>
          </div>
        </div>

        <div class="project-info">
          <h3>项目简介</h3>
          <p>这是一个基于 Vue3 + Spring Boot + MyBatis 的前后端分离项目，实现了用户管理和角色管理等功能。</p>
        </div>
      </div>
    </el-card>
  </div>
</template>

<script>
import { Message, Link, ChatDotRound } from '@element-plus/icons-vue'
import weixinQR from '../assets/weixin.jpg'

export default {
  name: 'About',
  components: {
    Message,
    Link,
    ChatDotRound
  },
  data() {
    return {
      weixinQRCode: weixinQR
    }
  }
}
</script>

<style scoped>
.about-container {
  padding: 20px;
  max-width: 800px;
  margin: 0 auto;
}

.about-card {
  border-radius: 8px;
  box-shadow: 0 2px 12px 0 rgba(0,0,0,0.1);
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 18px;
  font-weight: bold;
}

.author-info {
  text-align: center;
  padding: 20px;
}

.author-avatar {
  margin-bottom: 20px;
  border: 4px solid #fff;
  box-shadow: 0 2px 12px 0 rgba(0,0,0,0.1);
}

.author-name {
  font-size: 24px;
  margin: 10px 0;
  color: #303133;
}

.author-title {
  color: #909399;
  margin-bottom: 30px;
}

.contact-list {
  max-width: 500px;
  margin: 0 auto 30px;
  text-align: left;
}

.qrcode-container {
  text-align: center;
}

.qrcode-text {
  margin-top: 10px;
  color: #606266;
  font-size: 14px;
}

.skills-section {
  margin: 30px 0;
}

.skill-tags {
  display: flex;
  gap: 10px;
  justify-content: center;
  flex-wrap: wrap;
  margin-top: 15px;
}

.skill-tags .el-tag {
  padding: 0 15px;
  height: 32px;
  line-height: 32px;
  font-size: 14px;
}

.project-info {
  text-align: left;
  max-width: 600px;
  margin: 0 auto;
}

.project-info h3 {
  margin-bottom: 15px;
  color: #303133;
}

.project-info p {
  color: #606266;
  line-height: 1.6;
}
</style> 