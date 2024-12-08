<template>
    <div>
      <h2>Ingredients (first 5)</h2>
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
        ingredients: [],
        loadingIngredients: true,
      };
    },
    created() {
      this.fetchIngredients();
    },
    methods: {
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