# 养乐多管理系统前端

## 项目介绍
这是一个基于 Vue3 + Element Plus 的前端管理系统，采用前后端分离架构。系统实现了用户管理、角色管理等功能，具有现代化的UI设计和良好的用户体验。

## 技术栈
- **核心框架：** Vue 3
- **UI 组件库：** Element Plus
- **状态管理：** Vuex 4
- **路由管理：** Vue Router 4
- **HTTP 客户端：** Axios
- **代码规范：** ESLint + Prettier
- **构建工具：** Vite

## 功能特性
1. **用户管理**
   - 用户列表展示
   - 用户信息的增删改查
   - 用户详情页面
   - 分页和搜索功能

2. **角色管理**
   - 角色列表展示
   - 角色信息的增删改查
   - 分页和搜索功能

3. **UI 特点**
   - 响应式布局设计
   - 现代化的界面风格
   - 友好的用户交互
   - 统一的设计规范

## 项目结构
```
Springboot-Mybatis-Frontend/
├── public/                 # 静态资源
├── src/
│   ├── api/               # API 接口
│   ├── assets/            # 项目资源文件
│   ├── components/        # 公共组件
│   ├── router/            # 路由配置
│   ├── store/            # Vuex 状态管理
│   ├── utils/            # 工具函数
│   ├── views/            # 页面组件
│   ├── App.vue           # 根组件
│   └── main.js           # 入口文件
├── .env                   # 环境变量
├── .eslintrc.js          # ESLint 配置
├── package.json          # 项目依赖
└── vite.config.js        # Vite 配置
```

## 开发环境要求
- Node.js >= 14.0.0
- npm >= 6.14.0

## 安装和运行
1. **克隆项目**
   ```bash
   git clone [项目地址]
   cd Springboot-Mybatis-Frontend
   ```

2. **安装依赖**
   ```bash
   npm install
   ```

3. **运行开发服务器**
   ```bash
   npm run dev
   ```

4. **构建生产版本**
   ```bash
   npm run build
   ```

## 开发规范
1. **代码风格**
   - 使用 ESLint 进行代码检查
   - 使用 Prettier 进行代码格式化
   - 遵循 Vue 3 组件命名规范

2. **提交规范**
   - feat: 新功能
   - fix: 修复问题
   - docs: 修改文档
   - style: 修改格式
   - refactor: 代码重构
   - test: 测试相关
   - chore: 其他修改

## 项目特点
1. **模块化设计**
   - 组件化开发
   - 功能模块解耦
   - 可复用性高

2. **性能优化**
   - 路由懒加载
   - 组件按需加载
   - 资源压缩优化

3. **用户体验**
   - 响应式设计
   - 友好的交互反馈
   - 统一的错误处理

## 部署说明
1. **环境配置**
   - 修改 .env 文件中的接口地址
   - 确保后端服务正常运行

2. **构建部署**
   - 执行 npm run build
   - 将 dist 目录下的文件部署到服务器

## 常见问题
1. **跨域问题**
   - 开发环境通过 Vite 代理配置解决
   - 生产环境需要后端配置 CORS

2. **环境变量**
   - 开发环境使用 .env.development
   - 生产环境使用 .env.production

## 维护者
- 养乐多 (Yangleduo0033@126.com)

## 版权信息
Copyright © 2024 养乐多管理系统 