<template>
  <!-- <div class="home">
    <img alt="Vue logo" src="../assets/logo.png">
    <HelloWorld msg="Welcome to Your Vue.js App"/>
  </div> -->

  <!-- Check that the SDK client is not currently loading before accessing is methods -->
  <div v-if="!$auth.loading">
    <!-- show login when not authenticated -->
    <button v-if="!$auth.isAuthenticated" @click="login">Log in</button>
    <!-- show logout when authenticated -->
    <button v-if="$auth.isAuthenticated" @click="logout">Log out</button>
  </div>
</template>

<script>
// @ is an alias to /src

export default {
  name: 'Home',
  methods: {
    login() {
      this.$auth.loginWithRedirect()
    },
    logout() {
      this.$auth.logout({
        returnTo: window.location.origin
      })
    }
  }
}
</script>
