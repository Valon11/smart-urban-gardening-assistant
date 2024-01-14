<template>
  <div :class="{'shadow-lg': props.shadow, 'cursor-pointer border hover:border hover:border-plantGreen': props.hover }">
    <slot/>
  </div>
</template>
  
<script setup>
const props = defineProps({
  shadow: {
    type: Boolean,
    required: false,
    default: false,
  },
  hover: {
    type: Boolean,
    required: false,
    default: false,
  }
})
</script>