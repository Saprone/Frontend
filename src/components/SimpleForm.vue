<template>
  <div>
    <h1>Post request</h1>
    <textarea v-model="data" placeholder="Enter some data..."></textarea>
    <button @click="sendData">Send Data</button>
    <p v-if="response">{{ response }}</p>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      data: '',
      response: '',
    };
  },
  methods: {
    async sendData() {
      const response = await axios.post('http://localhost:8222/basket/post', this.data);
      console.log("post: "+response.data);
    },
  },
};
</script>