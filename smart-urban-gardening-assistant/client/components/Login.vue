<template>
  <Card shadow class="rounded p-8">
    <div class="flex-col space-y-8">
      <div class="space-y-2">
        <div class="text-2xl font-bold"> {{ $t('login') }} </div>
        <div class="text-sm text-slate-400 text-justify">
          {{ $t('loginDescription') }}
        </div>
      </div>
      <div class="flex flex-col space-y-2">
        <label for="username" class="font-bold"> {{ $t('username') }} </label>
        <InputText id="username" v-model="username" :placeholder="$t('placeholder')" class="border py-2 px-4 rounded"/>
      </div>
      <div class="flex flex-col space-y-2">
        <label for="password" class="font-bold"> {{ $t('password') }}</label>
        <Password id="password" v-model="password" :placeholder="$t('placeholder')" toggleMask :feedback="false" class="border rounded"/>
      </div>
      <div class="text-sm text-justify cursor-pointer text-plantGreen" @click="toggleLogin">
        {{ $t('registerLink') }}
      </div>
      <Button @click="login" :disabled="disableButton" class="w-full bg-plantGreen text-center rouneded p-4">
        <div class="flex items-center space-x-2 mx-auto">
          <i class="pi pi-user text-white"/>
          <div class="text-white text-l font-bold">  {{ $t('login') }} </div>
        </div>
      </Button>
      <Message v-if="wrongCredentials" severity="error" :closable="false">
        <div class="text-sm"> {{ $t('wrongCredentials') }} </div>
      </Message>
    </div>
  </Card>
</template>

<script setup>
import Card from "../components/Card.vue"
import axios from 'axios';
import { ref, watch, onMounted } from "vue"
import { useRouter } from "vue-router"
import { useStore } from 'vuex'

const emit = defineEmits(["toggle-login"])

const users = ref([])
const username = ref()
const password = ref()
const wrongCredentials = ref(false)
const disableButton = ref(true)
const router = useRouter()
const store = useStore()

async function getUsers() {
  try {
    const response = await axios.get('http://localhost:3001/users')
    if (response.status === 200) users.value = response.data
  } catch (error) {
    console.error('Fehler beim Get der Benutzer:', error)
  }
}

const toggleLogin = () => emit("toggle-login", true)
function login(){
  const user = users.value.find(user => user.name === username.value)
  if (user && user.password === password.value){
    store.commit('setUser', user)
    router.push('/main')
  } else wrongCredentials.value = true
}

onMounted(() => getUsers())
watch([username, password], () => disableButton.value = !username.value || !password.value)
</script>

<style>
.p-password .p-password-input{
  width: 100% !important;
  padding: 8px 16px !important;
}
</style>