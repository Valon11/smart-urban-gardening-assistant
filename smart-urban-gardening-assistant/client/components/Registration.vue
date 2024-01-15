<template>
  <Card shadow class="rounded p-8">
    <div class="flex-col space-y-8">
      <div class="space-y-2">
        <div class="text-2xl font-bold">Registration</div>
        <div class="text-sm text-slate-400 text-justify">
          {{ $t('registerDescription') }}
        </div>
      </div>
      <div class="flex flex-col space-y-2">
        <label for="username" class="font-bold">{{ $t('username') }}</label>
        <InputText id="username" v-model="username" class="border py-2 px-4 rounded"/>
      </div>
      <div class="flex flex-col space-y-2">
        <label for="password" class="font-bold">{{ $t('password') }}</label>
        <Password id="password" v-model="password" toggleMask class="border rounded">
          <template #header>
            <div class="font-bold">{{ $t('passwordSuggestions') }}</div>
          </template>
          <template #footer>
            <ul>
              <li>{{ $t('passwordLength') }}</li>
              <li>{{ $t('passwordNumeric') }}</li>
              <li>{{ $t('passwordCase') }}</li>
            </ul>
          </template>
        </Password>
      </div>
      <div class="text-sm text-justify cursor-pointer text-plantGreen" @click="toggleLogin">
        {{ $t('loginLink') }}
      </div>
      <Button @click="register" :disabled="disableButton" class="w-full bg-plantGreen text-center rouneded p-4">
        <div class="flex items-center space-x-2 mx-auto">
          <i class="pi pi-user-plus" style="color: white"/>
          <div class="text-white text-l font-bold">{{ $t('register') }}</div>
        </div>
      </Button>
      <Message v-if="wrongCredentials" severity="info" :closable="false">
        <div class="text-sm"> {{ $t('userExists') }} </div>
      </Message>
    </div>
  </Card>
</template>
    
<script setup>
import axios from 'axios'
import Card from "../components/Card.vue"
import { ref, watch } from "vue"
import { useRouter } from "vue-router"

const username = ref(null)
const password = ref(null)
const wrongCredentials = ref(false)
const disableButton = ref(true)
const router = useRouter()

const emit = defineEmits(["toggle-login"])

const toggleLogin = () => emit("toggle-login", false)

async function register() {
  try {
    const userExists = await checkUserExists(username.value)
    if (!userExists) {
      //Benutzername nicht vergeben
      const response = await postUser(username.value, password.value)
      if (response.status === 201) router.push('/main') //zur Hauptseite weiterleiten
    } else {
      wrongCredentials.value = true //Benutzername bereits vergeben
    }
  } catch (error) {
    console.error('Fehler beim Post des Benutzers:', error)
  }
}

async function checkUserExists(username) {
  try {
    const response = await axios.get(`http://localhost:3001/users/${username}`)
    return response.status === 200 //true wenn Benutzer vorhanden
  } catch (error) {
    if (error.response && error.response.status === 404) return false // Benutzer nicht gefunden
    else console.error('Fehler beim Post des Benutzers:', error)
  }
}

async function postUser(username, password, language = 'en') {
  try {
    const response = await axios.post('http://localhost:3001/register', {
      name: username,
      password: password,
      language: language //Englisch als Standardsprache
    });
    return response
  } catch (error) {
     console.error('Fehler beim Post des Benutzers:', error)
  }
}

watch([username, password], () => disableButton.value = !username.value || !password.value)
</script>

<style>
.p-password .p-password-input{
  width: 100% !important;
  padding: 8px 16px !important;
}
</style>