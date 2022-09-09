<template>
  <div>
    <v-container class="blue text-center">
      <v-container class="title mt-10">
        <h1 class="orange--text">BizTubeLogger</h1>
        <h2 class="mt-10">YouTubeで学んだことをアウトプットしよう!</h2>
        <v-btn class="primary mt-10">今すぐ始める</v-btn>
      </v-container>
    </v-container>
  </div>
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