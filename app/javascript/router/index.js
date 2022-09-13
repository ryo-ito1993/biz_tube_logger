import Vue from "vue";
import Router from "vue-router";
import store from '../store'

import TopIndex from "../pages/top/index";
import RegisterIndex from "../pages/register/index"
import LoginIndex from "../pages/login/index"
import VideoIndex from "../pages/video/index"

Vue.use(Router)

const router = new Router({
  mode: "history",
  routes: [
    {
      path: "/",
      component: TopIndex,
      name: "TopIndex",
    },
    {
      path: "/register",
      component: RegisterIndex,
      name: "RegisterIndex"
    },
    {
      path: "/login",
      component: LoginIndex,
      name: "LoginIndex"
    },
    {
      path: "/videos",
      component: VideoIndex,
      name: "VideoIndex",
    }
  ],
})

router.beforeEach((to, from, next) => {
  store.dispatch('users/fetchAuthUser').then((authUser) => {
    if (to.matched.some(record => record.meta.requiredAuth) && !authUser) {
      next({ name: 'LoginIndex' });
    } else {
      next();
    }
  })
});

export default router