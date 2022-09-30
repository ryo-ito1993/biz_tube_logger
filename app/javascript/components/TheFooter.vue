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
      <v-btn
        dense
        text
      >
        プライバシーポリシー
      </v-btn>
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

</style>