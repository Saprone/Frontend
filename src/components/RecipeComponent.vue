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
    data() {
        return {
            recipes: [],
        };
    },
    created() {
        this.fetchRecipes();
    },
    methods: {
        async fetchRecipes() {
            try {
                const response = await fetch('http://localhost:8222/recipes');
                if (!response.ok) {
                    throw new Error('Problem with network respone');
                }
                const data = await response.json();
                this.recipes = data;
            } catch (error) {
                console.error('Problem with the fetch operation:', error);
            }
        }
    }
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
