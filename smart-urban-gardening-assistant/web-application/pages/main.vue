<template>
    <Header @add-plant="addPlant" @search-plant="searchPlant" :plants="plants"/>
    <Filter @filter-plant="filterPlant" :plants="plantsByUser" :environmental-conditions="environmentalConditions"/>

    <DataTable :value="filterPlants" v-model:expandedRows="expandedPlants" @rowExpand="onRowExpand" paginator :rowsPerPageOptions="[5,10,25]" :rows="5" resizable-columns class="mt-8 mx-8 rounded shadow-lg">
      <Column expander />
      <template #expansion="slotProps">
        <div class="flex items-center">
          <img src="../assets/images/plantExample.jpg" alt="Plant Image" class="h-[150px] rounded me-4" />
          <div class="flex flex-col space-y-4">
            <div><strong>Distribution:</strong> {{ slotProps.data.distribution }}</div>
            <div><strong>Species Count:</strong> {{ slotProps.data.speciesCount }}</div>
            <div><strong>Growth Height:</strong> {{ slotProps.data.growthHeightMin }} - {{ slotProps.data.growthHeightMax }} cm</div>
            <div><strong>Fun Fact:</strong> {{ slotProps.data.funFact }}</div>
          </div>
        </div>
      </template>
      <Column field="name" header="Name"/>
      <Column field="latinName" header="Latin Name"/>
      <Column field="plantFamily" header="Plant Family"/>
      <Column field="floweringTime" header="Flowering Time"/>
      <Column field="status" header="Status">
        <template #body="slotProps">
          <Tag :style="{ color: slotProps.data.status === 'Ideal' ? '#B4E5B4' : (slotProps.data.status === 'Acceptable' ? '#99C2FF' : '#FF9999'),
                         backgroundColor: slotProps.data.status === 'Ideal' ? '#D6F3D6' : (slotProps.data.status === 'Acceptable' ? '#CCE5FF' : '#FFCCCC') }">
            {{slotProps.data.status}}
          </Tag>
        </template>
      </Column>
      <Column>
        <template #body="slotProps">
            <i class="pi pi-times text-red-400 cursor-pointer" @click="confirmDeletion($event, slotProps.data.ID)"/>
        </template>
      </Column>
    </DataTable>
    <ConfirmPopup/>
</template>

<script setup>
import { ref, computed } from 'vue'
import { useConfirm } from "primevue/useconfirm"
import { useStore } from 'vuex'
import { useRouter } from 'vue-router'
import Header from "../components/Header.vue"
import Filter from "../components/Filter.vue"
import axios from 'axios';

const store = useStore()
const router = useRouter()
const searchInput = ref('')
const plants = ref([]) // Hier werden die Pflanzendaten aus der Tabelle "plant" gespeichert
const plantsByUser = ref([])
const userPlant = ref([])
const expandedPlants = ref([])
const environmentalConditions = ref([{ name: 'Temperature', unit: '°C', value: 20, icon: ['fas', 'thermometer-half'], iconColor: '#FF9999' },
    { name: 'Humidity', unit: '%', value: 65, icon: ['fas', 'tint'], iconColor: '#99C2FF' },
    { name: 'Light Intensity', unit: 'Lux', value: 1800, icon: ['fas', 'sun'], iconColor: '#FFF699' }]) // Hier werden die Umweltbedingungsdaten aus der Tabelle "environmentalcondition" gespeichert
const environmentalConditionByPlant = ref([]) // Hier werden die Zuordnungen von Pflanzen zu Umweltbedingungen aus der Tabelle "userplant" gespeichert


const fetchPlantsFromBackend = async () => {
  try {
    const response = await axios.get(`http://localhost:3001/plants`);
    plants.value = response.data; // Aktualisiere die plants-Variable mit den abgerufenen Daten
  } catch (error) {
    console.error('Fehler beim Abrufen der Pflanzendaten:', error);
  }
}

const fetchUserPlantFromBackend = async () => {
  try {
    const loggedUser = store.getters.getUser;
    const response = await axios.get(`http://localhost:3001/user/${loggedUser.ID}/plants`);
    userPlant.value = response.data; // Aktualisiere die plants-Variable mit den abgerufenen Daten
    plantsByUser.value = plants.value
  .filter(plant => {
    return userPlant.value.some(userPlantItem => userPlantItem.plantID === plant.ID);
  })
  .map(plant => {
    return { ...plant, status: 'Ideal' };
  });
  } catch (error) {
    console.error('Fehler beim Abrufen der Pflanzendaten:', error);
  }
}

const fetchEnvironmentalConditionsFromBackend = async () => {
  try {
    const response = await axios.get('http://localhost:3001/environmentalconditions');
    environmentalConditions.value = response.data; // Aktualisiere die environmentalConditions-Variable mit den abgerufenen Daten
  } catch (error) {
    console.error('Fehler beim Abrufen der Umweltbedingungsdaten:', error);
  }
}

const filterChosen = ref(-1)
const filterPlant = (newValue) => filterChosen.value = newValue

const searchPlant = (newValue) => searchInput.value = newValue
const filterPlants = computed(() => {
  return plantsByUser.value
    .filter((plant) => {
      return (
        plant.name.toLowerCase().includes(searchInput.value.toLowerCase()) &&
        ((filterChosen.value === -1) ||
        (filterChosen.value === 0 && plant.status === 'Ideal') ||
        (filterChosen.value === 1 && plant.status === 'Acceptable') ||
        (filterChosen.value === 2 && plant.status === 'Deficient'))
      )
    })
    .sort((a, b) => a.name.localeCompare(b.name))
})

function addPlant(plantsChosen) {
  plantsChosen.forEach((plant) => {
    if (!plants.value.some((p) => p.id === plant.id)) plants.value.push(plant)
  })
  //setStatus()
}

async function deleteUserPlant(plantId) {
  try {
    const loggedUser = store.getters.getUser;
    await axios.delete(`http://localhost:3001/user/${loggedUser.ID}/plants/${plantId}`);
    
    // Aktualisiere die Pflanzenliste nach dem Löschen
    const plantIndex = plantsByUser.value.findIndex(p => p.id === plantId);
    if (plantIndex !== -1) {
      plantsByUser.value.splice(plantIndex, 1);
    }
  } catch (error) {
    console.error('An error occurred while deleting the plant: ' + plantId, error);
  }
}

const confirm = useConfirm()
const confirmDeletion = (event, plantID) => {
  confirm.require({
    target: event.currentTarget,
    message: 'Do you want to remove this plant?',
    icon: 'pi pi-info-circle',
    acceptClass: 'p-button-danger p-button-sm',
    accept: () => {
      deleteUserPlant(plantID);
    }
  })
}


const onRowExpand = (event) => {expandedPlants.value = event.data ? [event.data] : []}

function setStatus(){
  plants.value.forEach((plant) => {
  const environmentalCondition = environmentalConditionByPlant.value.find((condition) => condition.plantID === plant.id);

  if (environmentalCondition) {
    const isTempDeficient =
      environmentalConditions.value[0].value < environmentalCondition.deficientTempMin ||
      environmentalConditions.value[0].value > environmentalCondition.deficientTempMax;

    const isHumidityDeficient =
      environmentalConditions.value[1].value < environmentalCondition.deficientHumMin ||
      environmentalConditions.value[1].value > environmentalCondition.deficientHumMax;

    const isLightIntensityDeficient =
      environmentalConditions.value[2].value < environmentalCondition.deficientLightMax;

    const isTempAcceptable =
      environmentalConditions.value[0].value >= environmentalCondition.acceptTempMin &&
      environmentalConditions.value[0].value <= environmentalCondition.acceptTempMax;

    const isHumidityAcceptable =
      environmentalConditions.value[1].value >= environmentalCondition.acceptHumMin &&
      environmentalConditions.value[1].value <= environmentalCondition.acceptHumMax;

    const isLightIntensityAcceptable =
      environmentalConditions.value[2].value >= environmentalCondition.acceptLightMin &&
      environmentalConditions.value[2].value <= environmentalCondition.acceptLightMax;

    if (isTempDeficient || isHumidityDeficient || isLightIntensityDeficient) plant.status = 'Deficient';
    else if (isTempAcceptable || isHumidityAcceptable || isLightIntensityAcceptable) plant.status = 'Acceptable';
    else plant.status = 'Ideal';
  }
  })
}

onMounted(() => {
  if (!store.getters.getUser) router.push('/start')
  fetchPlantsFromBackend(); // Rufe Pflanzendaten aus der Datenbank ab
  //fetchEnvironmentalConditionsFromBackend(); // Rufe Umweltbedingungsdaten aus der Datenbank ab
  // Hier sollten auch die Zuordnungen von Pflanzen zu Umweltbedingungen (environmentalConditionByPlant) abgerufen werden
  // und die setStatus() Methode aufgerufen werden, um den Status der Pflanzen festzulegen.
  fetchUserPlantFromBackend();
})

</script>

<style>
.p-datatable .p-datatable-thead > tr > th {
  background-color: #E0F9E0 !important;
}

.p-confirm-popup-accept,
.p-confirm-popup-reject {
  padding: 4px;
  margin: 4px;
}

.p-confirm-popup-accept{
  background-color: #FF9999 !important;
}
</style>