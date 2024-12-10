<template>
  <div>
    <h3>Basket</h3>
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
  },
};
</script>

<style>
ul {
  list-style-type: none;
}
</style>
  