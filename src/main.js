import Vue from 'vue'
import App from './App.vue'
import router from './router'
// Import the Auth0 configuration
import { Auth0Plugin } from './auth'
// import FontAwesome
import { library } from '@fortawesome/fontawesome-svg-core'
import { fas } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'
require('dotenv').config()

library.add(fas)

Vue.component('font-awesome-icon', FontAwesomeIcon)

Vue.use(Auth0Plugin, {
  domain: process.env.VUE_APP_AUTH_DOMAIN,
  clientId: process.env.VUE_APP_AUTH_CLIENT_ID,
  onRedirectCallback: appState => {
    router.push(
      appState && appState.targetUrl
        ? appState.targetUrl
        : window.location.pathname
    )
  }
})

Vue.config.productionTip = false

new Vue({
  router,
  render: h => h(App)
}).$mount('#app')
