<script setup lang="ts">
import { ref, onMounted } from 'vue'
import ChatFrame from './components/ChatFrame.vue'

const username = ref('')
const password = ref('')
const isLoggedIn = ref(false)
const userConfig = {
  "admin": "admin",
  "13871088892": "123456",
  "18694057068": "123456",
  "13554016166": "123456",
  "18062768512": "123456",
  "dzbAdmin": "123456",
  "18062687335": "123456",
  "zsj": "123456",
  "zfw": "123456",
  "zsj-zc": "123456",
}

// 检查登录状态和会话时间
const checkLoginStatus = () => {
  const user = localStorage.getItem('user')
  const loginTime = localStorage.getItem('loginTime')
  
  if (user && typeof user === 'string' && user in userConfig) {
    if (loginTime) {
      const currentTime = new Date().getTime()
      const loginTimeStamp = parseInt(loginTime)
      const timeDiff = currentTime - loginTimeStamp
      
      // 检查是否超过60分钟（1800000毫秒）
      if (timeDiff > 3600000) {
        // 超时，清除登录信息
        localStorage.removeItem('user')
        localStorage.removeItem('loginTime')
        isLoggedIn.value = false
        return
      }
    }
    isLoggedIn.value = true
  }
}

// 页面加载时检查登录状态
onMounted(() => {
  checkLoginStatus()
  // 每分钟检查一次登录状态
  setInterval(checkLoginStatus, 300000)
})

const handleLogin = () => {
  // 简单的用户验证逻辑
  if ((username.value in userConfig) && (userConfig[username.value as keyof typeof userConfig] === password.value)) {
    // 存储用户信息、权限和登录时间
    localStorage.setItem('user', username.value)
    localStorage.setItem('loginTime', new Date().getTime().toString())
    isLoggedIn.value = true
  } else {
    alert('用户名或密码错误')
  }
}

const handleKeyPress = (e: KeyboardEvent) => {
  if (e.key === 'Enter') {
    handleLogin()
  }
}
</script>

<template>
  <div v-if="!isLoggedIn" class="login-container">
    <div class="login-box">
      <div class="logo-container">
        <img src="/logo.svg" alt="公司logo" class="company-logo" />
        <h1>AI助手-武汉光谷数字产业集团有限公司</h1>
      </div>
      
      <div class="form-container">
        <div class="input-group">
          <input
            v-model="username"
            type="text"
            placeholder="用户名"
            class="login-input"
            @keyup="handleKeyPress"
          />
        </div>
        <div class="input-group">
          <input
            v-model="password"
            type="password"
            placeholder="密码"
            class="login-input"
            @keyup="handleKeyPress"
          />
        </div>
        <button @click="handleLogin" class="login-button">登录</button>
      </div>

      <div class="footer-link">
        <a href="#">无法登录，点此联系</a>
      </div>
    </div>
  </div>
  <ChatFrame v-else />
</template>

<style scoped>
.login-container {
  width: 100%;
  min-height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  background: linear-gradient(135deg, #e0f0ff 0%, #f5f9ff 100%);
  position: relative;
  margin: 0;
  padding: 0;
  overflow: hidden;
}

.login-box {
  width: 400px;
  padding: 40px;
  background: white;
  border-radius: 12px;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
}

.logo-container {
  text-align: center;
  margin-bottom: 30px;
}

.company-logo {
  width: 30%;
  height: 20%;
}

.logo-container h1 {
  font-size: 18px;
  color: #333;
  margin: 0;
  font-weight: 500;
}

.form-container {
  margin-top: 30px;
}

.input-group {
  margin-bottom: 20px;
}

.login-input {
  width: 100%;
  padding: 12px;
  border: 1px solid #ddd;
  border-radius: 6px;
  font-size: 14px;
  transition: border-color 0.3s;
}

.login-input:focus {
  border-color: #4a90e2;
  outline: none;
}

.login-button {
  width: 100%;
  padding: 12px;
  background: #4a90e2;
  color: white;
  border: none;
  border-radius: 6px;
  font-size: 16px;
  cursor: pointer;
  transition: background-color 0.3s;
}

.login-button:hover {
  background: #357abd;
}

.footer-link {
  text-align: center;
  margin-top: 20px;
}

.footer-link a {
  color: #4a90e2;
  text-decoration: none;
  font-size: 14px;
}

.footer-link a:hover {
  text-decoration: underline;
}
</style>
