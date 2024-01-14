<template>
    <!-- empty template if this page only redirects -->
    <div></div>
  </template>
  
  <script setup>
  import { onMounted } from 'vue';
  import { useRouter } from 'vue-router';
  
  const router = useRouter();
  
  onMounted(() => {
    router.push('/start');
  });
  </script>
  