import Vue from 'vue'
import Vuex from 'vuex'
import users from './modules/users'
import outputs from './modules/outputs'
import flashMessage from './modules/flashMessage'
import bookmarks from './modules/bookmarks'
import likes from './modules/likes'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    users,
    outputs,
    flashMessage,
    bookmarks,
    likes
  }
})