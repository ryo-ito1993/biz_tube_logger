<template>
  <v-card
    width="450px"
    class="mx-auto mt-5"
  >
    <v-card-title>
      <h1 class="display-1">
        ログイン
      </h1>
    </v-card-title>
    <v-card-text>
      <v-form>
        <v-text-field
          v-model="user.email"
          label="メールアドレス"
          type="email"
          prepend-icon="mdi-email"
        />
        <v-text-field
          v-model="user.password"
          label="パスワード"
          :type="showPassword ? 'text' : 'password'"
          prepend-icon="mdi-lock"
          :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
          @click:append="showPassword = !showPassword"
        />
        <v-card-actions>
          <v-btn
            class="info"
          >
            ログイン
          </v-btn>
        </v-card-actions>
      </v-form>
    </v-card-text>
  </v-card>
</template>

<script>
export default {
  name: "LoginIndex",
  data () {
    return {
      showPassword: false,
      user: {
        email: '',
        password: '',
      }
    }
  },
  methods: {

  }
}
</script>

<style scoped>

</style>