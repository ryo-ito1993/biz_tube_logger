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
    </v-card-text>
  </v-card>
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
    async login() {
      try {
        await this.loginUser(this.user);
        this.$router.push({ name: 'VideoIndex' })
      } catch (error) {
        console.log(error);
      }
    }
  }
}
</script>

<style scoped>

</style>