<template>
  <v-container>
    <h2 class="mb-1 d-flex align-center justify-center">
      <v-icon
        left
        bottom
      >
        mdi-account-plus
      </v-icon>
      Sign Up
    </h2>
    <v-divider
      class="mb-4"
      style="max-width: 700px; margin: auto"
    />
    <v-card
      max-width="600px"
      class="mx-auto mt-5"
    >
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
        <v-divider />
        <v-card-text class="text-center">
          ログインは<router-link to="/login">
            こちら
          </router-link>
        </v-card-text>
      </v-card-text>
    </v-card>
  </v-container>
</template>

<script>
import { mapActions } from "vuex"
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
    ...mapActions("users", ["createUser"]),
    ...mapActions("flashMessage", ["showMessage"]),
    register() {
      this.createUser(this.user)
        .then(res => {
          this.$router.push({ name:'VideoIndex' })
          this.showMessage(
      {
        message: "ユーザー登録が完了しました",
        type: "light-blue",
        status: true,
      },
    )
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