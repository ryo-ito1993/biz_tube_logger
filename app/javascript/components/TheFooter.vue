<template>
  <v-footer
    dark
  >
    <v-spacer />
    <div>
      <v-btn
        dense
        text
      >
        利用規約
      </v-btn>
      <router-link :to="{ name: 'PrivacyPolicy' }">
      <v-btn
        dense
        text
      >
        プライバシーポリシー
      </v-btn>
      </router-link>
      <a href="https://twitter.com/ryo_runteq32" target="_blank">
        <v-btn
        dense
        text
      >
        お問い合せ
      </v-btn>
      </a>
      <small>&copy; BizTubeLogger 2022.</small>
    </div>
  </v-footer>
</template>


<script>
export default {
  name: "TheFooter"
}
</script>

<style scoped>
small {
  margin-left: 20px;
}
.v-btn:not(.v-btn--round).v-size--default {
  padding: 0 5px;
}
a {
  text-decoration: none;
  }
a:link, a:visited {
  color: white;
}
</style>