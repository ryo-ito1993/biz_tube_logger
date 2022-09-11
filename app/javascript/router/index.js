import Vue from "vue";
import Router from "vue-router";

import TopIndex from "../pages/top/index";
import RegisterIndex from "../pages/register/index"
import LoginIndex from "../pages/login/index"

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
    }
  ],
})

export default router