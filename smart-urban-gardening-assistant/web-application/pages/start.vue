<template>
  <div class="flex items-center justify-center min-h-screen">
    <img src="@/assets/images/plantsBalcony.jpg" 
         class="min-h-screen w-1/2 object-cover hidden lg:block">
    <div class="flex flex-col items-center space-y-8 lg:w-1/2">
      <div class="flex items-center text-3xl font-bold text-center">
        <img src="@/assets/images/plantIcon.png" 
             class="w-[80px] h-[95px] object-cover me-4">
        <div class="flex space-x-2">
          <span class="text-plantGreen">S</span>mart
          <span class="text-plantGreen">U</span>rban
          <span class="text-plantGreen">G</span>ardening
          <span class="text-plantGreen">A</span>ssistant
        </div>
      </div>
      <div class="w-full max-w-xl mx-auto">
        <Login v-if="!showRegistration" @toggle-login="toggleLogin"/>
        <Registration v-else @toggle-login="toggleLogin"/>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const showRegistration = ref(false)
const toggleLogin = (bool) => showRegistration.value = bool
</script>