<template>
  <v-container class="cyan lighten-3 title mt-10 text-center">
    <h1 class="white--text">
      BizTubeLogger
    </h1>
    <h2 class="mt-10">
      ビジネスYouTubeで学んだことをアウトプットしよう!
    </h2>
    <router-link :to="{ name: 'RegisterIndex' }">
      <v-btn class="primary mt-10">
        今すぐ始める
      </v-btn>
    </router-link>
  </v-container>
</template>


<script>
export default {
  name: "TopIndex",
  data() {
    return {
      message: "hello,vue"
    }
  }
}
</script>

<style scoped>
.title {
  padding-top: 130px;
  padding-bottom: 130px;
}
</style>