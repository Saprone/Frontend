<template>
  <div>
    <h1>Post request</h1>
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
      var basket = [
          {
              "id": 97,
              "name": "Dark Brown Sugar"
          },
          {
              "id": 117,
              "name": "Farfalle"
          }
      ]

      var response = await axios.post('http://localhost:8222/basket/post', JSON.stringify(basket));
      console.log("post: " + response);
    },
  },
};
</script>