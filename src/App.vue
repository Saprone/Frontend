<template>
  <UserComponent />
  <IngredientComponent />
</template>

<script>
import UserComponent from './components/UserComponent.vue';
import IngredientComponent from './components/IngredientComponent.vue';

export default {
  name: 'App',
  components: {
    UserComponent,
    IngredientComponent,
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
