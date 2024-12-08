<template>
  <div>
    <h2>User logged in as</h2>
    <div v-if="user">
      <p>{{ user }}</p>
    </div>
    <div v-else>
      <p>Loading user data...</p>
    </div>
    <h2>Ingredients (first 5)</h2>
    
      <!--<span v-for="ingredient in ingredients" :key="ingredient.id">
        {{ ingredient.name }} ,
      </span>-->

      <span v-for="(ingredient, index) in ingredients.slice(0, 5)" :key="ingredient.id">
        {{ ingredient.name }}{{ index < 4 ? ', ' : '' }} 
      </span>
    
    <div v-if="ingredients.length === 0 && !loadingIngredients">
      <p>No ingredients found.</p>
    </div>
    <div v-if="loadingIngredients">
      <p>Loading ingredients...</p>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      user: null,
      ingredients: [],
      loadingIngredients: true,
    };
  },
  created() {
    this.fetchUser();
    this.fetchIngredients();
  },
  methods: {
    async fetchUser() {
      try {
        const response = await axios.get('http://localhost:8222/user/1');
        this.user = response.data;

        console.log(response);
      } catch (error) {
        console.error('Error fetching user:', error);
      }
    },
    async fetchIngredients() {
      try {
        const response = await axios.get('http://localhost:8222/ingredients');
        this.ingredients = response.data;
        this.loadingIngredients = false;
      } catch (error) {
        console.error('Error fetching ingredients:', error);
        this.loadingIngredients = false;
      }
    },
  },
};
</script>

<style scoped>
/* Add styles here if needed */
</style>
