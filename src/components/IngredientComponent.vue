<template>
  <div>
    <h3>
      Ingredient 
      <span v-if="fetchIngredientsStatus === 'success'">🟢</span>
      <span v-if="fetchIngredientsStatus === 'error'">🔴</span>
    </h3>
    <div v-if="ingredients.length === 0 && !loadingIngredients">
      <p>No ingredients found.</p>
    </div>
    <div v-if="loadingIngredients">
      <p>Loading ingredients...</p>
    </div>
    <div>
      <input type="text" v-model="searchInput" @input="filterIngredients" placeholder="Search ingredient..." />
      <ul v-if="searchInput && filteredIngredients.length > 0" class="suggestions">
        <li 
          v-for="(ingredient) in filteredIngredients" 
          :key="ingredient.id" 
          :style="{ cursor: basket.length === 0 ? 'not-allowed' : 'pointer' }"
          @click="basket.length > 0 ? addIngredientToBasket(ingredient) : null"
          :class="{ 'not-allowed': basket.length === 0 }"
        >
          {{ ingredient.name }}
        </li>
      </ul>
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
      searchInput: '',
      filteredIngredients: [],
    };
  },
  props: {
    basket: Array,
    addIngredientToBasket: Function,
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
        this.fetchIngredientsStatus = 'success'; 
      } catch (error) {
        console.error('Error fetching ingredients:', error);
        this.loadingIngredients = false;
        this.fetchIngredientsStatus = 'error'; 
      }
    },
    filterIngredients() {
      const query = this.searchInput.toLowerCase();
      this.filteredIngredients = this.ingredients.filter(ingredient =>
        ingredient.name.toLowerCase().startsWith(query)
      );
    },
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
}

.suggestions li:hover {
  background-color: #f0f0f0;
}

button:hover {
  cursor: pointer;
}

.not-allowed {
  cursor: not-allowed; 
}

ul {
  list-style-type: none;
}
</style>
