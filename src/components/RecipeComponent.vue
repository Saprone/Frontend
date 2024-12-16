<template>
<div>
    <h3>
        Recipe 
        <span v-if="fetchRecipesStatus === 'success'">🟢</span>
        <span v-if="fetchRecipesStatus === 'error'">🔴</span>
    </h3>
    <p v-if="initialLoad && !recipes.length && !loadingRecipes">Add/remove ingredients to see recipes.</p>
    <p v-else-if="!initialLoad && !recipes.length">No recipes found.</p>
    <p v-if="loadingRecipes">Loading recipes...</p> 
    <ul v-else>
        <li v-for="recipe in recipes" :key="recipe.id">{{ recipe.name }}</li>
    </ul>
</div>
</template>

<script>
export default {
props: {
    recipes: Array,
    loadingRecipes: Boolean, 
    fetchRecipesStatus: String, 
},
data() {
    return {
        initialLoad: true, 
    };
},
watch: {
    recipes(newRecipes) {
        if (newRecipes.length > 0) {
            this.initialLoad = false; 
        }
    },
},
};
</script>

<style>
ul {
    list-style-type: none;
    padding: 0; 
    text-align: center; 
}

li {
    margin: 10px 0; 
}
</style>
  