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
    <router-link :to="{ name: 'PostIndex' }">
      <v-btn
        text
        class="mr-5"
      >
        投稿一覧
      </v-btn>
    </router-link>
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
  </v-app-bar>
</template>

<script>
export default {
  name: "TheHeader"
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