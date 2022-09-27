<template>
  <v-container>
    <h2 class="mb-1 d-flex align-center justify-center">
      <v-icon
        left
        bottom
      >
        mdi-login
      </v-icon>
      ログイン
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
              name="メールアドレス"
              rules="required|email"
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
              name="パスワード"
              rules="required|min:3"
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
            <v-card-actions>
              <v-btn
                class="info"
                :disabled="invalid"
                @click="login"
              >
                ログイン
              </v-btn>
            </v-card-actions>
          </v-form>
        </ValidationObserver>
        <v-divider />
        <v-card-text class="text-center">
          新規登録は<router-link to="/register">
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
  name: "LoginIndex",
  data() {
    return {
      showPassword: false,
      user: {
        email: "",
        password: "",
      }
    }
  },
  methods: {
    ...mapActions("users", [
      "loginUser",
      "fetchUser",
    ]),
    ...mapActions("flashMessage", ["showMessage"]),
    async login() {
      try {
        await this.loginUser(this.user);
        this.$router.push({ name: 'VideoIndex' })
        this.showMessage(
      {
        message: "ログインしました",
        type: "light-blue",
        status: true,
      },
    )
      } catch (error) {
        this.showMessage(
      {
        message: "ログインに失敗しました",
        type: "error",
        status: true,
      },
    )
        console.log(error);
      }
    }
  }
}
</script>

<style scoped>

</style>