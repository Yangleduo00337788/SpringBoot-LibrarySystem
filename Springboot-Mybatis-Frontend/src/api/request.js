import axios from 'axios'
import { ElMessage } from 'element-plus'

// 创建axios实例
const request = axios.create({
  baseURL: 'http://localhost:8080', // 确保这个端口号与后端服务器一致
  timeout: 15000, // 增加超时时间
  headers: {
    'Content-Type': 'application/json'
  }
})

// 请求拦截器
request.interceptors.request.use(
  config => {
    // 在发送请求之前做些什么
    console.log('Request config:', {
      url: config.url,
      method: config.method,
      data: config.data,
      params: config.params,
      baseURL: config.baseURL
    })
    return config
  },
  error => {
    // 对请求错误做些什么
    console.error('Request error:', error)
    return Promise.reject(error)
  }
)

// 响应拦截器
request.interceptors.response.use(
  response => {
    // 对响应数据做点什么
    console.log('Response data:', response.data)
    
    // 检查响应状态
    if (response.status !== 200) {
      ElMessage.error(`请求失败: ${response.status}`)
      return Promise.reject(new Error('请求失败'))
    }

    // 检查业务状态码
    const res = response.data
    if (!res) {
      ElMessage.error('响应数据为空')
      return Promise.reject(new Error('响应数据为空'))
    }

    // 根据实际后端返回的状态码进行调整
    if (res.code === 0 || res.code === 200 || res.code === 1) {
      return response
    } else {
      ElMessage.error(res.msg || '请求失败')
      return Promise.reject(new Error(res.msg || '请求失败'))
    }
  },
  error => {
    // 对响应错误做点什么
    console.error('Response error:', {
      message: error.message,
      config: error.config,
      response: error.response?.data
    })
    
    if (error.response) {
      // 服务器返回错误状态码
      const status = error.response.status
      switch (status) {
        case 404:
          ElMessage.error('请求的资源不存在')
          break
        case 500:
          ElMessage.error('服务器内部错误')
          break
        default:
          ElMessage.error(`请求失败: ${status} - ${error.response.data?.message || error.message}`)
      }
    } else if (error.request) {
      // 请求发出但没有收到响应
      ElMessage.error('服务器无响应，请检查后端服务是否启动')
    } else {
      // 请求配置出错
      ElMessage.error(`请求配置错误: ${error.message}`)
    }
    
    return Promise.reject(error)
  }
)

export default request 