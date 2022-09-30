<template>
  <header>
    <v-app-bar
      dark
      app
    >
      <router-link :to="{ name: 'TopIndex' }">
        <v-toolbar-title>
          <h3>BizTubeLogger</h3>
        </v-toolbar-title>
      </router-link>
      <div class="flex-grow-1" />
      <router-link :to="{ name: 'VideoIndex' }">
        <v-btn
          v-if="!$vuetify.breakpoint.xsOnly"
          text
          class="mr-5"
        >
          LIST
        </v-btn>
      </router-link>
      <template v-if="!authUser">
        <router-link :to="{ name: 'RegisterIndex' }">
          <v-btn
            v-if="!$vuetify.breakpoint.xsOnly"
            text
            class="mr-5"
          >
            SIGN UP
          </v-btn>
        </router-link>
        <router-link :to="{ name: 'LoginIndex' }">
          <v-btn
            v-if="!$vuetify.breakpoint.xsOnly"
            text
          >
            LOGIN
          </v-btn>
        </router-link>
      </template>
      <template v-else>
        <router-link :to="{ name: 'VideoCreate' }">
          <v-btn
            v-if="!$vuetify.breakpoint.xsOnly"
            text
            class="mr-5"
          >
            NEW Output
          </v-btn>
        </router-link>
        <router-link :to="{ name: 'MypageIndex' }">
          <v-btn
            v-if="!$vuetify.breakpoint.xsOnly"
            text
            class="mr-5"
          >
            MYPAGE
          </v-btn>
        </router-link>
        <router-link
          v-if="!$vuetify.breakpoint.xsOnly"
          to="#"
          @click.native="handleLogout"
        >
          LOGOUT
        </router-link>
      </template>
      <v-app-bar-nav-icon
        v-if="$vuetify.breakpoint.xsOnly"
        @click="drawer = true"
      />
    </v-app-bar>
    <v-navigation-drawer
      v-model="drawer"
      fixed
      temporary
      right
      class="grey lighten-1"
    >
      <v-list
        nav
        dense
      >
        <v-list-item-group>
          <v-list-item :to="{ name: 'VideoIndex' }">
            LIST
          </v-list-item>
          <template v-if="!authUser">
            <v-list-item :to="{ name: 'RegisterIndex' }">
              SIGN UP
            </v-list-item>
            <v-list-item :to="{ name: 'LoginIndex' }">
              LOGIN
            </v-list-item>
          </template>
          <template v-else>
            <v-list-item :to="{ name: 'VideoCreate' }">
              NEW OUTPUT
            </v-list-item>
            <v-list-item :to="{ name: 'MypageIndex' }">
              MYPAGE
            </v-list-item>
            <v-list-item @click.native="handleLogout">
              LOGOUT
            </v-list-item>
          </template>
        </v-list-item-group>
      </v-list>
    </v-navigation-drawer>
  </header>
</template>

<script>
import { mapGetters, mapActions } from "vuex"

export default {
  name: "TheHeader",
  data () {
    return {
      drawer: false
    }
  },
  computed: {
    ...mapGetters("users", ["authUser"])
  },
  methods: {
    ...mapActions("users", ["logoutUser"]),
    ...mapActions("flashMessage", ["showMessage"]),
    async handleLogout() {
      try {
        await this.logoutUser()
        this.$router.push({name: 'TopIndex'})
        this.showMessage(
      {
        message: "ログアウトしました",
        type: "warning",
        status: true,
      },
    )
      } catch (error) {
        this.showMessage(
      {
        message: "ログアウトに失敗しました",
        type: "error",
        status: true,
      },
    )
        console.log(error)
      }
    }
  }
}
</script>

<style scoped>
h3 {
  font-family: 'Kaisei Tokumin', serif;
}
a {
  text-decoration: none;
  }
a:link, a:visited {
  color: white;
}
</style>