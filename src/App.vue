<template>
  <div id="app">
    <IngredientComponent 
      ref="ingredientComponent" 
      :basket="basket" 
      :addIngredientToBasket="addIngredientToBasket" 
      :fetchIngredientsStatus="fetchIngredientsStatus"
      :fetchBasketStatus="fetchBasketStatus" 
    />
    <BasketComponent 
      :basket="basket" 
      :removeIngredientFromBasket="removeIngredientFromBasket" 
      :fetchBasketStatus="fetchBasketStatus"  
    />
    <RecipeComponent 
      :recipes="recipes" 
      :loadingRecipes="loadingRecipes" 
      :fetchRecipesStatus="fetchRecipesStatus"  
    />
  </div>
</template>

<script>
import axios from 'axios';
import IngredientComponent from './components/IngredientComponent.vue';
import BasketComponent from './components/BasketComponent.vue';
import RecipeComponent from './components/RecipeComponent.vue';

export default {
  name: 'App',
  components: {
    IngredientComponent,
    BasketComponent,
    RecipeComponent,
  },
  data() {
  return {
    basket: [],
    recipes: [],
    loadingRecipes: false,
    fetchIngredientsStatus: null, 
    fetchBasketStatus: null, 
    fetchRecipesStatus: null 
  };
},
  created() {
    this.fetchBasket();
    this.getRecipeStatus();
  },
  methods: {
    async fetchBasket() {
      try {
        const response = await axios.get('http://localhost:8222/basket');
        this.basket = response.data;
        this.fetchBasketStatus = 'success'; 
      } catch (error) {
        console.error('Error fetching basket:', error);
        this.fetchBasketStatus = 'error'; 
      }
    },
    async getRecipeStatus() {
      try {
        await axios.get('http://localhost:8222/recipes/status');  
        this.fetchRecipesStatus = 'success'; 
      } catch (error) {
        this.fetchRecipesStatus = 'error'; 
      } 
    },
    async fetchRecipes() {
      this.loadingRecipes = true;

      try {
        const response = await axios.get('http://localhost:8222/recipes');  
        this.recipes = response.data;
      } catch (error) {
        console.error('Error fetching recipes:', error);
      } finally {
        this.loadingRecipes = false; 
      }
    },
    async addIngredientToBasket(ingredient) {
      if (!this.basket.find(item => item.id === ingredient.id)) { 
        this.$refs.ingredientComponent.searchInput = '';
        this.$refs.ingredientComponent.filteredIngredients = [];
        this.basket.push(ingredient);
        this.basket.sort((a, b) => a.name.localeCompare(b.name));
        await axios.post('http://localhost:8222/basket/ingredient/add', JSON.stringify(ingredient));  
        await this.fetchRecipes();
      }
    },
    async removeIngredientFromBasket(index) {
      const ingredientId = this.basket[index].id; 
      try {
        await axios.post('http://localhost:8222/basket/ingredient/remove', ingredientId);
        this.basket.splice(index, 1);
        await this.fetchRecipes();
      } catch (error) {
        console.error('Error removing ingredient:', error);
      }
    }
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
