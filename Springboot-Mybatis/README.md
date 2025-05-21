# 养乐多管理系统后端

## 项目介绍
这是一个基于 Spring Boot + MyBatis 的后端管理系统，采用前后端分离架构。系统提供了完整的用户管理和角色管理功能，采用 RESTful API 设计规范，具有良好的可扩展性和维护性。

## 技术栈
- **核心框架：** Spring Boot 2.7.x
- **ORM 框架：** MyBatis
- **数据库：** MySQL 8.0
- **权限控制：** Spring Security
- **API 文档：** Swagger/OpenAPI
- **项目管理：** Maven
- **数据库连接池：** HikariCP
- **工具库：** Lombok, MapStruct
- **日志框架：** SLF4J + Logback

## 功能特性
1. **用户管理**
   - 用户信息的增删改查
   - 用户权限控制
   - 用户状态管理
   - 分页查询支持
   - 条件筛选功能

2. **角色管理**
   - 角色信息的增删改查
   - 角色权限分配
   - 角色状态管理
   - 分页和搜索功能

3. **系统特性**
   - RESTful API 设计
   - 统一响应格式
   - 全局异常处理
   - 请求参数验证
   - 跨域支持

## 项目结构
```
Springboot-Mybatis-Backend/
├── src/
│   ├── main/
│   │   ├── java/com/yangleduo/
│   │   │   ├── config/          # 配置类
│   │   │   ├── controller/      # 控制器
│   │   │   ├── service/         # 服务层
│   │   │   ├── mapper/          # MyBatis映射器
│   │   │   ├── model/           # 实体类
│   │   │   ├── dto/             # 数据传输对象
│   │   │   ├── exception/       # 异常处理
│   │   │   └── util/            # 工具类
│   │   └── resources/
│   │       ├── mapper/          # MyBatis XML映射文件
│   │       ├── application.yml  # 应用配置文件
│   │       └── logback.xml      # 日志配置
│   └── test/                    # 测试代码
├── pom.xml                      # Maven配置
└── README.md                    # 项目文档
```

## 开发环境要求
- JDK 1.8 或更高版本
- Maven 3.6.x 或更高版本
- MySQL 8.0 或更高版本
- IDE 推荐使用 IntelliJ IDEA

## 安装和运行
1. **克隆项目**
   ```bash
   git clone [项目地址]
   cd Springboot-Mybatis-Backend
   ```

2. **配置数据库**
   - 创建 MySQL 数据库
   - 修改 application.yml 中的数据库配置

3. **构建项目**
   ```bash
   mvn clean install
   ```

4. **运行应用**
   ```bash
   mvn spring-boot:run
   ```
   或
   ```bash
   java -jar target/springboot-mybatis-backend.jar
   ```

## API 文档
- 访问 Swagger 文档：http://localhost:8080/swagger-ui.html
- 主要 API 端点：
  - 用户管理：/api/users
  - 角色管理：/api/roles

## 数据库设计
1. **用户表 (users)**
   - id: 主键
   - username: 用户名
   - password: 密码
   - email: 邮箱
   - status: 状态
   - create_time: 创建时间
   - update_time: 更新时间

2. **角色表 (roles)**
   - id: 主键
   - role_name: 角色名称
   - description: 描述
   - status: 状态
   - create_time: 创建时间
   - update_time: 更新时间

## 开发规范
1. **代码规范**
   - 遵循阿里巴巴Java开发手册
   - 使用 Lombok 简化代码
   - 统一的命名规范
   - 详细的注释文档

2. **提交规范**
   - feat: 新功能
   - fix: 修复问题
   - docs: 修改文档
   - style: 修改格式
   - refactor: 代码重构
   - test: 测试相关
   - chore: 其他修改

## 项目特点
1. **安全性**
   - 密码加密存储
   - JWT 令牌认证
   - 防 SQL 注入
   - XSS 防护

2. **可维护性**
   - 模块化设计
   - 统一异常处理
   - 统一日志管理
   - 代码注释完善

3. **性能优化**
   - 数据库连接池
   - 请求响应缓存
   - SQL 语句优化
   - 延迟加载策略

## 部署说明
1. **环境准备**
   - JDK 环境配置
   - MySQL 数据库安装
   - 配置文件修改

2. **部署步骤**
   - 构建项目包
   - 配置环境变量
   - 启动应用服务
   - 验证服务状态

## 常见问题
1. **跨域问题**
   - 已在 WebConfig 中配置跨域支持
   - 支持自定义跨域配置

2. **数据库连接**
   - 检查数据库配置
   - 确保数据库服务正常
   - 验证用户权限

## 维护者
- 养乐多 (Yangleduo0033@126.com)

## 版权信息
Copyright © 2024 养乐多管理系统 