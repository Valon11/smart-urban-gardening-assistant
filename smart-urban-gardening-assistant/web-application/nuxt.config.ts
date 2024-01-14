export default defineNuxtConfig({
  modules: ['@nuxtjs/tailwindcss'],
  build:{transpile: ['primevue']},
  css:[
    'primevue/resources/themes/saga-green/theme.css',
    'primevue/resources/primevue.min.css',
    'primeicons/primeicons.css',
  ]
})