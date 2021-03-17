<template>
  <div class="counters">
    <div v-if="isPresent">
      <li v-for="counter in counters" :key="counter.attributes.serial_number">
        {{ counter.attributes.serial_number }}
      </li>
    </div>
    <form id="register" @submit.prevent="registerCounter">
      <p v-if="errors.length">
        <b>Please correct the following error(s):</b>
        <ul>
          <li v-for="error in errors" :key="error">{{ error }}</li>
        </ul>
      </p>
      <p>
        <label for="serialNumber">Serial Number</label>
        <input
          id="serialNumber"
          type="text"
          v-model="serialNumber"
          name="serialNumber"
          >
      </p>
      <p>
        <input type="submit" value="Submit">
      </p>
    </form>
  </div>
</template>

<script>
const axios = require('axios')

export default {
  name: 'Counters',
  data () {
    return {
      counters: [],
      loading: true,
      accessToken: null,
      serialNumber: null,
      errors: []
    }
  },
  mounted () {
    setInterval(this.getCountersFromApi, 5000),
    this.$nextTick(function () {
      if(this.accessToken === null) {
        this.getApiKey()
      }
    })
  },
  methods: {
    async getCountersFromApi () {
      if (this.accessToken !== null) {
        this.getCounters()
      }
    },
    async getCounters() {
      await axios({
        method: 'GET',
        url: `${process.env.VUE_APP_API_URL}/counters`,
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Content-type': 'application/json',
          'Authorization': `Bearer ${this.accessToken}`
        },
      })
      .then(response => (this.counters = response.data.data))
      .catch(error => {
        console.log(error)
        this.counters = 0
      })
      .finally(() => this.loading = false)
    },
    async getApiKey() {
      await axios({
        method: 'POST',
        url: `${process.env.VUE_APP_API_AUTH_URL}`,
        headers: { 'content-type': 'application/json' },
        data: {
          "client_id": `${process.env.VUE_APP_API_CLIENT_ID}`,
          "client_secret": `${process.env.VUE_APP_API_CLIENT_SECRET}`,
          "audience": `${process.env.VUE_APP_API_AUDIENCE}`,
          "grant_type": "client_credentials"
        }
      })
      .then(response => (this.accessToken = response.data.access_token))
      .catch(error => {
        console.log(error)
      })
    },
    isPresent() {
      if (Array.isArray(this.counters)) {
        this.counters.length !== 0
      } else {
        Object.getOwnPropertyNames(this.counters).length !== 0
      }
    },
    async createCounter() {
      await axios({
        method: 'POST',
        url: `${process.env.VUE_APP_API_URL}/counters`,
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Content-type': 'application/json',
          'Authorization': `Bearer ${this.accessToken}`
        },
        data: {
          'counter': {
            'serial_number': this.serialNumber
          }
        }
      })
      .catch(error=> {
        console.log(error)
      })
    },
    registerCounter() {
      if (this.accessToken !== null) {
        this.createCounter()
      }
    }
  }
}
</script>
