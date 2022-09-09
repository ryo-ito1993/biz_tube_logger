import Vue from 'vue'
import App from '../app.vue'
import router from '../router'
import Vuetify from "vuetify";
import "vuetify/dist/vuetify.min.css";
import '@mdi/font/css/materialdesignicons.css'

Vue.use(Vuetify);
const vuetify = new Vuetify();

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    router,
    vuetify,
    render: h => h(App)
  }).$mount()
  document.body.appendChild(app.$el)

  console.log(app)
})