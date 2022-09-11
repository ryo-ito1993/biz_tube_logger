<template>
  <v-card width="450px" class="mx-auto mt-5">
    <v-card-title>
      <h1 class="display-1">新規登録</h1>
    </v-card-title>
    <v-card-text>
      <v-form>
        <v-text-field
        label="ユーザー名"
        v-model="user.name"
        type="text"
        prepend-icon="mdi-account-circle" />
        <v-text-field
        label="メールアドレス"
        v-model="user.email"
        type="email"
        prepend-icon="mdi-email" />
        <v-text-field
        label="パスワード"
        v-model="user.password"
        v-bind:type="showPassword ? 'text' : 'password'"
        prepend-icon="mdi-lock"
        v-bind:append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
        @click:append="showPassword = !showPassword" />
        <v-text-field
        label="パスワード(確認)"
        v-model="user.password_confirmation"
        v-bind:append-icon="showPasswordConfirm ? 'mdi-eye' : 'mdi-eye-off'"
        prepend-icon="mdi-lock"
        v-bind:type="showPasswordConfirm ? 'text' : 'password'"
        @click:append="showPasswordConfirm = !showPasswordConfirm" />
        <v-card-actions>
          <v-btn @click="register" class="info">新規登録</v-btn>
        </v-card-actions>
      </v-form>
    </v-card-text>
  </v-card>
</template>

<script>
export default {
  name: "RegisterIndex",
  data () {
    return {
      showPassword: false,
      showPasswordConfirm: false,
      user: {
        name: '',
        email: '',
        password: '',
        password_confirmation: ''
      }
    }
  },
  methods: {
    register() {
      this.$axios.post('users', { user: this.user })
        .then(res => {
          this.$router.push({ name:'LoginIndex' })
        })
        .catch(err => {
          console.log(err)
        })
    }
  }
}
</script>

<style scoped>

</style>