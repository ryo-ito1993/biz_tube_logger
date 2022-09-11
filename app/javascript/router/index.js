import Vue from "vue";
import Router from "vue-router";
import store from '../store'

import TopIndex from "../pages/top/index";
import RegisterIndex from "../pages/register/index"
import LoginIndex from "../pages/login/index"
import PostIndex from "../pages/post/index"

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
      path: "/posts",
      component: PostIndex,
      name: "PostIndex"
    }
  ],
})



export default router