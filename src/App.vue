<template>
  <IngredientComponent />
</template>

<script>
import IngredientComponent from './components/IngredientComponent.vue';

export default {
  name: 'App',
  components: {
    IngredientComponent 
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
