<template>
  <div>
  <v-card width="400px" class="mx-auto mt-5">
    <v-card-title>
      <h1 class="display-1">ログイン</h1>
    </v-card-title>
    <v-card-text>
      <v-form>
        <v-icon></v-icon>
        <v-text-field prepend-icon="mdi-account-circle" label="ユーザー名" />
        <v-text-field prepend-icon="mdi-lock"  label="パスワード" />
        <v-card-actions>
          <v-btn class="info">ログイン</v-btn>
        </v-card-actions>
      </v-form>
    </v-card-text>
  </v-card>
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
</style>