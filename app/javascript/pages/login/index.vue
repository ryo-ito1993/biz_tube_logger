<template>
  <v-container>
    <v-card
      max-width="600px"
      class="mx-auto mt-5"
      elevation="20"
    >
      <h2 class="pt-3 mb-3 d-flex align-center justify-center">
        <v-icon
          left
          bottom
          color="primary"
        >
          mdi-login
        </v-icon>
        Login
      </h2>
      <v-divider
        class="mb-4"
        style="max-width: 700px; margin: auto"
      />
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
              rules="required"
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
                class="info mb-2"
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
        <v-row>
          <v-btn
            color="primary"
            class="mx-auto mt-3 mb-4"
            outlined
            max-width="210"
            max-height="25"
            @click="handleShowResetPassworModal"
          >
            パスワードをお忘れですか？
          </v-btn>
        </v-row>
      </v-card-text>
    </v-card>

    <v-dialog
      v-if="isVisibleResetPasswordModal"
      v-model="isVisibleResetPasswordModal"
      max-width="800"
    >
      <ResetPasswordModal
        @close-modal="handleCloseResetPasswordModal"
      />
    </v-dialog>
  </v-container>
</template>

<script>
import { mapActions } from "vuex"
import ResetPasswordModal from "./components/ResetPasswordModal"


export default {
  name: "LoginIndex",
  components: {
    ResetPasswordModal,
  },
  data() {
    return {
      showPassword: false,
      user: {
        email: "",
        password: "",
      },
      isVisibleResetPasswordModal: false
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
    },
    handleShowResetPassworModal() {
      this.isVisibleResetPasswordModal = true;
    },
    handleCloseResetPasswordModal() {
      this.isVisibleResetPasswordModal = false;
      this.email = {};
    },
  },
  head() {
    return {
      title: {
        inner: "Login",
        separator: "|",
        complement: "BizTubeLogger",
      }
    }
  },
}
</script>

<style scoped>

</style>