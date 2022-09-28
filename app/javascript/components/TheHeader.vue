<template>
  <v-app-bar
    color="#555555"
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
        text
        class="mr-5"
      >
        LIST
      </v-btn>
    </router-link>
    <template v-if="!authUser">
      <router-link :to="{ name: 'RegisterIndex' }">
        <v-btn
          text
          class="mr-5"
        >
          SIGN UP
        </v-btn>
      </router-link>
      <router-link :to="{ name: 'LoginIndex' }">
        <v-btn text>
          LOGIN
        </v-btn>
      </router-link>
    </template>
    <template v-else>
      <router-link :to="{ name: 'VideoCreate' }">
        <v-btn
          text
          class="mr-5"
        >
          NEW Output
        </v-btn>
      </router-link>
      <router-link :to="{ name: 'BookmarkIndex' }">
        <v-btn
          text
          class="mr-5"
        >
          Bookmarks
        </v-btn>
      </router-link>
      <router-link
        to="#"
        @click.native="handleLogout"
      >
        LOGOUT
      </router-link>
    </template>
  </v-app-bar>
</template>

<script>
import { mapGetters, mapActions } from "vuex"

export default {
  name: "TheHeader",
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