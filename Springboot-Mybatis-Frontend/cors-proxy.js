// 一个简单的CORS代理服务器
const express = require('express');
const axios = require('axios');
const cors = require('cors');
const app = express();
const PORT = 3002;

// 启用所有CORS请求
app.use(cors());

// 解析JSON请求体
app.use(express.json());

// 打印所有请求
app.use((req, res, next) => {
  console.log(`${req.method} ${req.url}`);
  next();
});

// 创建一个通用的代理端点
app.all('/api/*', async (req, res) => {
  try {
    // 从请求URL中提取后端API路径
    const backendPath = req.url.replace(/^\/api/, '');
    const backendUrl = `http://localhost:8080${backendPath}`;
    
    console.log(`代理请求: ${req.method} ${backendUrl}`);
    console.log('请求数据:', req.body);
    
    // 使用axios转发请求
    const response = await axios({
      method: req.method,
      url: backendUrl,
      data: req.body,
      headers: {
        'Content-Type': 'application/json'
      }
    });
    
    console.log(`代理响应: ${response.status}`);
    
    // 发送响应回客户端
    res.status(response.status).json(response.data);
  } catch (error) {
    console.error('代理错误:', error.message);
    if (error.response) {
      console.error('错误状态码:', error.response.status);
      console.error('错误数据:', error.response.data);
      res.status(error.response.status).json(error.response.data);
    } else {
      res.status(500).json({ error: '代理服务器错误', message: error.message });
    }
  }
});

// 启动服务器
app.listen(PORT, () => {
  console.log(`简易CORS代理服务器运行在 http://localhost:${PORT}`);
}); 