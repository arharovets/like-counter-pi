<template>
  <div class="likes-container">
    <font-awesome-icon icon="thumbs-up" size="xs" v-if="loading === false" />
    <p v-if="loading === false">{{ likes }}</p>
    <font-awesome-icon icon="spinner" size="xs" v-if="loading" spin />
  </div>
</template>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Oxanium:wght@500&display=swap');

.likes-container {
  position: absolute;
  top: 0;
  left: 0;
  width: 64px;
  height: 32px;
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  background-color: black;
  color: white;
  font-family: 'Oxanium', cursive;
}
</style>

<script>
// @ is an alias to /src
const axios = require('axios')

export default {
  name: 'IndexLikes',
  data () {
    return {
      likes: null,
      loading: true,
    }
  },
  mounted () {
    setInterval(this.getLikes, 6000)
  },
  methods: {
    async getLikes () {
      axios({
        method: 'GET',
        url: `${process.env.VUE_APP_API_URL}/services/index_likes`,
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Content-type': 'application/json',
        },
        params: {
          'serial_number': this.$route.query.serial_number
        }
      })
      .then(response => (this.likes = response.data.data[0].attributes.likes_number))
      .catch(error => {
        console.log(error)
        this.likes = 0
      })
      .finally(() => this.loading = false)
    }
  }
}
</script>
