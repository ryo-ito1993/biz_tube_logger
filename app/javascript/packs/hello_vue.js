import Vue from 'vue'
import App from '../app.vue'
import router from '../router'
import axios from '../plugins/axios'
import store from '../store'
import Vuetify from 'vuetify'
import VueHead from 'vue-head'
import 'vuetify/dist/vuetify.min.css'
import '@mdi/font/css/materialdesignicons.css'
import '../plugins/veevalidate'

Vue.config.productionTip = false
Vue.prototype.$axios = axios

Vue.use(VueHead)
Vue.use(Vuetify)
const vuetify = new Vuetify()

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    router,
    vuetify,
    store,
    VueHead,
    render: h => h(App)
  }).$mount()
  document.body.appendChild(app.$el)

  console.log(app)
})