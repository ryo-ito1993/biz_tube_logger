<template>
  <v-container class="main title mt-10 text-center">
    <h1 class="white--text">
      BizTubeLogger
    </h1>
    <h2 class="mt-10">
      ビジネスYouTubeで学んだことをアウトプットしよう!
    </h2>
    <router-link :to="{ name: 'VideoIndex' }">
      <v-btn class="primary mt-10">
        みんなの投稿を覗いてみる
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
.main{
  background: -webkit-linear-gradient(top, #D5DEE7 0%, #E8EBF2 50%, #E2E7ED 100%), -webkit-linear-gradient(top, rgba(0, 0, 0, 0.02) 50%, rgba(255, 255, 255, 0.02) 61%, rgba(0, 0, 0, 0.02) 73%), -webkit-linear-gradient(57deg, rgba(255, 255, 255, 0.2) 0%, rgba(0, 0, 0, 0.2) 100%);
  background: linear-gradient(to bottom, #D5DEE7 0%, #E8EBF2 50%, #E2E7ED 100%), linear-gradient(to bottom, rgba(0, 0, 0, 0.02) 50%, rgba(255, 255, 255, 0.02) 61%, rgba(0, 0, 0, 0.02) 73%), linear-gradient(33deg, rgba(255, 255, 255, 0.2) 0%, rgba(0, 0, 0, 0.2) 100%);
  background-blend-mode: normal,color-burn;
}
</style>