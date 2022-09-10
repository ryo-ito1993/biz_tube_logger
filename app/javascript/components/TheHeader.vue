<template>
  <v-app-bar color="blue lighten-2" dark app>
    <v-toolbar-title>
      <h4>BizTubeLogger</h4>
    </v-toolbar-title>
    <div class="flex-grow-1"></div>
    <v-btn text class="mr-5">
      投稿一覧
    </v-btn>
    <v-btn text class="mr-5">
      新規登録
    </v-btn>
    <v-btn text>
      ログイン
    </v-btn>
  </v-app-bar>
</template>

<script>
export default {
  name: "TheHeader"
}
</script>

<style scoped>
</style>