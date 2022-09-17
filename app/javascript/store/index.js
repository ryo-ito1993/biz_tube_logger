import Vue from 'vue'
import Vuex from 'vuex'
import users from './modules/users'
import outputs from './modules/outputs'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    users,
    outputs
  }
})