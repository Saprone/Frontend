<template>
  <div>
    <h3>Ingredients</h3>
    <div v-if="ingredients.length === 0 && !loadingIngredients">
      <p>No ingredients found.</p>
    </div>
    <div v-if="loadingIngredients">
      <p>Loading ingredients...</p>
    </div>   
    <div>
      <input 
        type="text" 
        v-model="searchInput" 
        @input="filterIngredients" 
        placeholder="Search ingredient..."
      />
      <ul v-if="searchInput && filteredIngredients.length > 0" class="suggestions">
        <li 
          v-for="(ingredient) in filteredIngredients" 
          :key="ingredient.id" 
          @click="selectIngredient(ingredient)"
        >
          {{ ingredient.name }}
        </li>
      </ul>
    </div>

    <h3>Basket</h3>
    <ul v-if="basket.length > 0">
      <li v-for="(item, index) in basket" :key="item.id">
        {{ item.name }}
        <button @click="removeIngredient(index)">🗑️</button>
      </li>
    </ul>
    <p v-else>Your basket is empty.</p>
    
    <button @click="searchRecipes">Search Recipes</button>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      ingredients: [],
      loadingIngredients: true,
      searchInput: '',
      filteredIngredients: [],
      basket: [], 
      loadingBasket: true, 
    };
  },
  created() {
    this.fetchIngredients();
    this.fetchBasket(); 
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
    async fetchBasket() {
      try {
        const response = await axios.get('http://localhost:8222/basket');
        this.basket = response.data; 
        this.loadingBasket = false; 
      } catch (error) {
        console.error('Error fetching basket:', error);
        this.loadingBasket = false; 
      }
    },
    filterIngredients() {
      const query = this.searchInput.toLowerCase();
      this.filteredIngredients = this.ingredients.filter(ingredient =>
        ingredient.name.toLowerCase().startsWith(query) 
      );
    },
    selectIngredient(ingredient) {
      if (!this.basket.find(item => item.id === ingredient.id)) {
        this.basket.push(ingredient); 
      }
      this.searchInput = ''; 
      this.filteredIngredients = []; 
    },
    removeIngredient(index) {
      this.basket.splice(index, 1); 
    },
    async searchRecipes() {
      try {
        if (this.basket.length === 0) {
          alert('Your basket is empty.');
          return;
        } else {
          await axios.post('http://localhost:8222/basket/ingredient', JSON.stringify(this.basket));
        }
      } catch (error) {
        console.log('Something went wrong.');
      }    
    }
  },
};
</script>

<style>
.suggestions {
  padding: 0;
  margin: 0 auto; 
  border: 1px solid #ccc;
  max-height: 150px;
  overflow-y: auto;
  width: 15%; 
  position: absolute; 
  left: 50%; 
  transform: translateX(-50%);
  background-color: white;
}

.suggestions li {
  padding: 8px;
  cursor: pointer;
}

.suggestions li:hover {
  background-color: #f0f0f0; 
}

ul {
  list-style-type: none;
}
</style>
