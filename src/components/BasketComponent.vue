<template>
  <div>
    <h3>
      Basket 
      <span v-if="fetchBasketStatus === 'success'">🟢</span>
      <span v-if="fetchBasketStatus === 'error'">🔴</span>
    </h3>
    <ul v-if="basket.length > 0">
      <li v-for="(item, index) in basket" :key="item.id" style="margin-bottom: 6px;">
        {{ item.name }}
        <button @click="removeIngredientFromBasket(index)">🗑️</button>
      </li>
    </ul>
    <p v-else>Your basket is empty.</p>
  </div>
</template>
  
<script>
export default {
  props: {
    basket: Array,
    removeIngredientFromBasket: Function,
    fetchBasketStatus: String, 
  },
};
</script>

<style>
ul {
  list-style-type: none;
}
</style>
  