<template>
    <div>
        <h3>Recipe</h3>
        <p v-if="!recipes.length">No recipes found.</p>
        <ul v-else>
            <li v-for="recipe in recipes" :key="recipe.id">{{ recipe.name }}</li>
        </ul>
    </div>
</template>
  
<script>
export default {
    props: {
        recipes: Array,
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
 
