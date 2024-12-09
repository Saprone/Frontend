<template>
 <div>
    <h2>User</h2>
    <div v-if="user">
    <p>{{ user }}</p>
    </div>
    <div v-else>
    <p>Loading user data...</p>
    </div>
 </div>
</template>
  
<script>
  import axios from 'axios';
  
  export default {
    data() {
      return {
        user: null,
      };
    },
    created() {
      this.fetchUser();
    },
    methods: {
      async fetchUser() {
        try {
          const response = await axios.get('http://localhost:8222/user/1');
          this.user = response.data;
        } catch (error) {
          console.error('Error fetching user:', error);
        }
      },
    },
  };
</script>