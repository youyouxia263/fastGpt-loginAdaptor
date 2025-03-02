<script setup lang="ts">
import { ref, onMounted } from 'vue'

const menuConfig = {
  'admin': {
    '党政办AI文档助手': 'http://ai.whggsc.cn:30000/chat/share?shareId=os52l549kr21hjk38gbxbu59',
    '光谷数产公文写作助手': 'http://ai.whggsc.cn:30000/chat/share?shareId=jewv444zmmt52m7zo10d976v',
    '智能学习助手': 'http://ai.whggsc.cn:30000/chat/share?shareId=ej6di83t8feotb0y7cpbs673',
    '教育局招生咨询AI助手': 'http://ai.whggsc.cn:30000/chat/share?shareId=nq1wzfycz93b5v5719ur74l8&showHistory=0'
  },
  '13871088892': {
    '教育局招生咨询AI助手': 'http://ai.whggsc.cn:30000/chat/share?shareId=nq1wzfycz93b5v5719ur74l8&showHistory=0'
  },
  '18694057068': {
    '教育局招生咨询AI助手': 'http://ai.whggsc.cn:30000/chat/share?shareId=nq1wzfycz93b5v5719ur74l8&showHistory=0'
  },
  '13554016166': {
    '教育局招生咨询AI助手': 'http://ai.whggsc.cn:30000/chat/share?shareId=nq1wzfycz93b5v5719ur74l8&showHistory=0'
  },
  '18062768512': {
    '教育局招生咨询AI助手': 'http://ai.whggsc.cn:30000/chat/share?shareId=nq1wzfycz93b5v5719ur74l8&showHistory=0'
  },
  'dzbAdmin': {
    '文件智能检索解读': 'http://ai.whggsc.cn:30000/chat/share?shareId=kzui1t7bwezo3qn0ghemjrdo',
    '文稿智能核对': 'http://ai.whggsc.cn:30000/chat/share?shareId=tw962n1yp8d20aokj1s3tlnx',
    '协助编写拟办意见': 'http://ai.whggsc.cn:30000/chat/share?shareId=1hkqyos7yqharffqoiuu0yhm'
  }
}

const availableMenus = ref<string[]>([])
const currentChat = ref('')
const currentUrls = ref<Record<string, string>>({})

onMounted(() => {
  const user = localStorage.getItem('user')
  if (user && typeof user === 'string' && user in menuConfig) {
    currentUrls.value = menuConfig[user as keyof typeof menuConfig]
    availableMenus.value = Object.keys(menuConfig[user as keyof typeof menuConfig])
    if (availableMenus.value.length > 0) {
      currentChat.value = availableMenus.value[0]
    }
  }
})

const handleLogout = () => {
  localStorage.removeItem('user')
  window.location.reload()
}
</script>

<template>
  <div class="layout-container">
    <div class="sidebar">
      <div class="menu-items">
        <button 
          v-for="menu in availableMenus"
          :key="menu"
          class="menu-button" 
          :class="{ active: currentChat === menu }" 
          @click="currentChat = menu"
        >
          {{ menu }}
        </button>
      </div>
      <button class="logout-button" @click="handleLogout">
        <span class="icon">⇦</span>
        退出
      </button>
    </div>
    <div class="chat-container">
      <iframe
        :src="currentUrls[currentChat]"
        class="chat-frame"
        frameborder="0"
        allow="microphone"
      ></iframe>
    </div>
  </div>
</template>

<style>
html, body {
  margin: 0;
  padding: 0;
  width: 100%;
  height: 100%;
  overflow: hidden;
}
</style>

<style scoped>
.layout-container {
  display: flex;
  width: 100vw;
  height: 100vh;
  overflow: hidden;
  margin: 0;
  padding: 0;
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
}

.sidebar {
  width: 200px;
  background-color: #1a1a1a;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  padding: 16px 0;
}

.menu-items {
  display: flex;
  flex-direction: column;
  gap: 8px;
  padding: 0 12px;
}

.menu-button {
  width: 100%;
  padding: 12px;
  border: none;
  background-color: transparent;
  color: #fff;
  cursor: pointer;
  text-align: left;
  border-radius: 6px;
  transition: background-color 0.3s;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.menu-button:hover {
  background-color: rgba(255, 255, 255, 0.1);
}

.menu-button.active {
  background-color: rgba(255, 255, 255, 0.2);
}

.logout-button {
  width: calc(100% - 24px);
  margin: 0 12px;
  padding: 12px;
  border: none;
  background-color: transparent;
  color: #fff;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 8px;
  border-radius: 6px;
  transition: background-color 0.3s;
}

.logout-button:hover {
  background-color: rgba(255, 255, 255, 0.1);
}

.icon {
  font-size: 16px;
}

.chat-container {
  flex: 1;
  overflow: hidden;
  margin: 0;
  padding: 0;
}

.chat-frame {
  width: 100%;
  height: 100%;
  border: none;
  margin: 0;
  padding: 0;
}
</style>