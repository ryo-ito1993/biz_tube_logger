<template>
  <v-card
    width="450px"
    class="mx-auto mt-5"
  >
    <v-card-title>
      <h1 class="display-1">
        新規登録
      </h1>
    </v-card-title>
    <v-card-text>
      <ValidationObserver v-slot="{ invalid }">
        <v-form>
          <ValidationProvider
            v-slot="{ errors }"
            rules="required"
            name="ユーザー名"
          >
            <v-text-field
              v-model="user.name"
              label="ユーザー名"
              type="text"
              prepend-icon="mdi-account-circle"
              :error-messages="errors"
            />
          </ValidationProvider>
          <ValidationProvider
            v-slot="{ errors }"
            rules="required|email"
            name="メールアドレス"
          >
            <v-text-field
              v-model="user.email"
              label="メールアドレス"
              type="email"
              prepend-icon="mdi-email"
              :error-messages="errors"
            />
          </ValidationProvider>
          <ValidationProvider
            v-slot="{ errors }"
            rules="required|min:3"
            vid="password"
            name="パスワード"
          >
            <v-text-field
              v-model="user.password"
              label="パスワード"
              :type="showPassword ? 'text' : 'password'"
              prepend-icon="mdi-lock"
              :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
              :error-messages="errors"
              @click:append="showPassword = !showPassword"
            />
          </ValidationProvider>
          <ValidationProvider
            v-slot="{ errors }"
            name="パスワード(確認)"
            rules="required|min:3|password_confirmed:@password"
          >
            <v-text-field
              v-model="user.password_confirmation"
              label="パスワード(確認)"
              :append-icon="showPasswordConfirm ? 'mdi-eye' : 'mdi-eye-off'"
              prepend-icon="mdi-lock"
              :type="showPasswordConfirm ? 'text' : 'password'"
              :error-messages="errors"
              @click:append="showPasswordConfirm = !showPasswordConfirm"
            />
          </ValidationProvider>
          <v-card-actions>
            <v-btn
              class="info"
              :disabled="invalid"
              @click="register"
            >
              新規登録
            </v-btn>
          </v-card-actions>
        </v-form>
      </ValidationObserver>
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
          this.$store.dispatch(
      "flashMessage/showMessage",
      {
        message: "ユーザー登録が完了しました",
        type: "success",
        status: true,
      },
      { root: true }
    ),
          this.$router.push({ name:'LoginIndex' })
        })
        .catch(err => {
          this.$store.dispatch(
      "flashMessage/showMessage",
      {
        message: "ユーザー登録に失敗しました。",
        type: "error",
        status: true,
      },
      { root: true }
    ),
          console.log(err)
        })
    }
  }
}
</script>

<style scoped>

</style>