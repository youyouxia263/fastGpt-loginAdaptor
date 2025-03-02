import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// https://vite.dev/config/
export default defineConfig({
  plugins: [vue()],
  server: {
    host: '0.0.0.0',  // 允许从任何IP地址访问
    port: 5173,       // 默认端口
  },
  preview: {
    host: '0.0.0.0',  // 预览模式也允许远程访问
    port: 4173,       // 预览默认端口
  }
})
