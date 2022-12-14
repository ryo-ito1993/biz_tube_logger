import Vue from "vue"
import Router from "vue-router"
import store from '../store'

import TopIndex from "../pages/top/index"
import RegisterIndex from "../pages/register/index"
import LoginIndex from "../pages/login/index"
import VideoIndex from "../pages/video/index/index"
import VideoNew from "../pages/video/new"
import VideoShow from "../pages/video/show/show"
import MypageIndex from "../pages/mypage/index"
import ResetPasswordUpdate from "../pages/reset_password/ResetPasswordUpdate.vue"
import PrivacyPolicy from "../pages/policies/PrivacyPolicy"
import TermsOfService from "../pages/policies/TermsOfService"

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
    },
    {
      path: "/videonew",
      component: VideoNew,
      name: "VideoNew",
      meta: { requiredAuth: true },
    },
    {
      path: '/video/:id',
      name: 'VideoShow',
      component: VideoShow,
      props: true
    },
    {
      path: "/mypage",
      component: MypageIndex,
      name: "MypageIndex",
      meta: { requiredAuth: true },
    },
    {
      path: "/users/password/edit",
      name: "ResetPasswordUpdate",
      component: ResetPasswordUpdate,
    },
    {
      path: "/privacypolicy",
      component: PrivacyPolicy,
      name: "PrivacyPolicy",
    },
    {
      path: "/termsofservice",
      component: TermsOfService,
      name: "TermsOfService",
    },
  ],
  scrollBehavior(to, from, savePosition) {
    console.log("to", to);
    console.log("from", from);
    console.log("savePosition", savePosition);
    if (savePosition) {
        return savePosition;
    }
    if (to.hash) {
        return {
            selector: "#next-user",
            offset: { x: 0, y: 100 }
        }
    }
    return { x: 0, y: 0 };
}
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