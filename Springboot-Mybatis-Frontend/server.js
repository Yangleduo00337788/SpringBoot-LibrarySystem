const express = require('express');
const { createProxyMiddleware } = require('http-proxy-middleware');
const cors = require('cors');
const app = express();

// 启用所有CORS请求
app.use(cors());

// 解析JSON请求体
app.use(express.json());

// 打印所有请求
app.use((req, res, next) => {
  console.log(`${req.method} ${req.url}`);
  next();
});

// 代理所有/api请求到后端服务器
app.use('/api', createProxyMiddleware({
  target: 'http://localhost:8080',
  changeOrigin: true,
  pathRewrite: {
    '^/api': '' // 移除/api前缀
  },
  onProxyReq: (proxyReq, req, res) => {
    // 如果有请求体，重写请求体
    if (req.body) {
      const bodyData = JSON.stringify(req.body);
      proxyReq.setHeader('Content-Type', 'application/json');
      proxyReq.setHeader('Content-Length', Buffer.byteLength(bodyData));
      proxyReq.write(bodyData);
    }
    console.log('代理请求:', req.method, req.url);
  },
  onProxyRes: (proxyRes, req, res) => {
    console.log('代理响应:', proxyRes.statusCode, req.url);
  },
  onError: (err, req, res) => {
    console.error('代理错误:', err);
    res.status(500).send('代理服务器错误');
  }
}));

// 提供静态文件服务（Vite构建的前端应用）
app.use(express.static('dist'));

// 启动服务器
const PORT = 3001;
app.listen(PORT, () => {
  console.log(`代理服务器运行在 http://localhost:${PORT}`);
}); 