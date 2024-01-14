<template>
  <Card shadow class="rounded p-8">
    <div class="flex-col space-y-8">
      <div class="space-y-2">
        <div class="text-2xl font-bold">Registration</div>
        <div class="text-sm text-slate-400 text-justify">
          Welcome to the Smart Urban Gardening Assistant, 
          your personalized gardening companion! Begin your journey by creating an account.
        </div>
      </div>
      <div class="flex flex-col space-y-2">
        <label for="username" class="font-bold">Benutzername</label>
        <InputText id="username" v-model="username" class="border py-2 px-4 rounded"/>
      </div>
      <div class="flex flex-col space-y-2">
        <label for="password" class="font-bold">Passwort</label>
        <Password id="password" v-model="password" toggleMask class="border rounded">
          <template #header>
            <div class="font-bold">Suggestions</div>
          </template>
          <template #footer>
            <ul>
              <li>- Minimum 8 characters</li>
              <li>- At least one numeric character</li>
              <li>- At least one lowercase and one uppercase letter</li>
            </ul>
          </template>
        </Password>
      </div>
      <div class="text-sm text-justify cursor-pointer text-plantGreen" @click="toggleLogin">
        Already have an account and eager to get back to your green oasis? No problem! Click here to log in!
      </div>
      <Button @click="register" :disabled="disableButton" class="w-full bg-plantGreen text-center rouneded p-4">
        <div class="flex items-center space-x-2 mx-auto">
          <i class="pi pi-user-plus" style="color: white"/>
          <div class="text-white text-l font-bold">Register</div>
        </div>
      </Button>
      <Message v-if="wrongCredentials" severity="info" :closable="false">
        <div class="text-sm"> Oops! It seems like the user already exists </div>
      </Message>
    </div>
  </Card>
</template>
    
<script setup>
import axios from 'axios';
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

// Methode zum Registrieren
async function register() {
  try {
    const userExists = await checkUserExists(username.value);
    if (!userExists) {
      // Since the user does not exist, proceed to register them.
      const response = await addUserToDatabase(username.value, password.value);
      if (response.status === 201) {
        // If the registration is successful, redirect to the main page or login.
        router.push('/main');
      }
    } else {
      // If the user already exists, inform the user.
      wrongCredentials.value = true;
    }
  } catch (error) {
    // Make sure to handle any other errors that might occur during registration.
    console.error('Ein Fehler ist aufgetreten:', error);
  }
}


// Methode, um zu überprüfen, ob der Benutzer bereits existiert
async function checkUserExists(username) {
  try {
    const response = await axios.get(`http://localhost:3001/users/${username}`);
    return response.status === 200; // If the user exists, this will be true
  } catch (error) {
    if (error.response && error.response.status === 404) {
      // Benutzer nicht gefunden - This is the correct path for a user that does not exist
      return false;
    } else {
      // Handle other errors differently than a 404
      console.error('Fehler beim Überprüfen des Benutzers:', error);
      throw error; // This will propagate the error, you might want to handle this case explicitly
    }
  }
}


// Methode, um den Benutzer zur Datenbank hinzuzufügen
async function addUserToDatabase(username, password, language = 'de') {
  try {
    const response = await axios.post('http://localhost:3001/register', {
      name: username,
      password: password,
      language: language // This will default to 'de' if not provided
    });
    return response;
  } catch (error) {
    console.error('Fehler beim Hinzufügen des Benutzers zur Datenbank:', error);
    throw error;
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