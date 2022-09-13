<template>
  <v-app-bar
    color="blue lighten-2"
    dark
    app
  >
    <router-link :to="{ name: 'TopIndex' }">
      <v-toolbar-title>
        <h4>BizTubeLogger</h4>
      </v-toolbar-title>
    </router-link>
    <div class="flex-grow-1" />
    <router-link :to="{ name: 'VideoIndex' }">
      <v-btn
        text
        class="mr-5"
      >
        投稿一覧
      </v-btn>
    </router-link>
    <template v-if="!authUser">
      <router-link :to="{ name: 'RegisterIndex' }">
        <v-btn
          text
          class="mr-5"
        >
          新規登録
        </v-btn>
      </router-link>
      <router-link :to="{ name: 'LoginIndex' }">
        <v-btn text>
          ログイン
        </v-btn>
      </router-link>
    </template>
    <template v-else>
      <router-link :to="{ name: 'VideoCreate' }">
      <v-btn
        text
        class="mr-5"
      >
        新規投稿
      </v-btn>
    </router-link>
      <router-link
        to="#"
        @click.native="handleLogout"
      >
        ログアウト
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
    async handleLogout() {
      try {
        await this.logoutUser()
        this.$router.push({name: 'TopIndex'})
      } catch (error) {
        console.log(error)
      }
    }
  }
}
</script>

<style scoped>
a {
  text-decoration: none;
  }
a:link, a:visited {
  color: white;
}
</style>