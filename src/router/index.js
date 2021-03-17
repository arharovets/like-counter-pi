import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'
import Profile from '../views/Profile.vue'
import IndexLikes from '../views/IndexLikes.vue'
import Counters from '../views/Counters.vue'
import { authGuard } from '../auth/authGuard'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/profile',
    name: 'Profile',
    component: Profile,
    beforeEnter: authGuard
  },
  {
    path: '/index-likes',
    name: 'IndexLikes',
    component: IndexLikes
  },
  {
    path: '/counters',
    name: 'Counters',
    component: Counters
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
