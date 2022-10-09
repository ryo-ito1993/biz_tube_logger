<template>
  <v-container>
    <v-card
      max-width="600px"
      class="mx-auto mt-5"
      elevation="20"
    >
      <h2 class="pt-3 mb-3 d-flex align-center justify-center">
        Change your password
      </h2>
      <v-divider
        style="max-width: 700px; margin: auto"
      />
      <v-card-text>
        <ValidationObserver v-slot="{ invalid }">
          <v-form>
            <ValidationProvider
              v-slot="{ errors }"
              rules="required|min:3"
              vid="password"
              name="新しいパスワード"
            >
              <v-text-field
                v-model="user.password"
                label="新しいパスワード"
                :type="showPassword ? 'text' : 'password'"
                prepend-icon="mdi-lock"
                :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'"
                :error-messages="errors"
                @click:append="showPassword = !showPassword"
              />
            </ValidationProvider>
            <ValidationProvider
              v-slot="{ errors }"
              name="新しいパスワード(確認)"
              rules="required|min:3|password_confirmed:@password"
            >
              <v-text-field
                v-model="user.password_confirmation"
                label="新しいパスワード(確認)"
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
                @click="changePassword"
              >
                パスワードを変更する
              </v-btn>
            </v-card-actions>
          </v-form>
        </ValidationObserver>
        <v-divider />
      </v-card-text>
    </v-card>
  </v-container>
</template>

<script>
import { mapActions } from "vuex"
export default {
  name: "ResetPasswordUpdate",
  data() {
    return {
      user: {
        password: "",
        password_confirmation: "",
      },
      showPassword: false,
      showPasswordConfirm: false
    };
  },
  methods: {
    ...mapActions("flashMessage", ["showMessage"]),
    changePassword() {
      this.$axios.patch(`password_resets/${this.$route.query.token}`, { user: this.user })
        .then(res => {
          this.$router.push({ name:'LoginIndex' })
          this.showMessage(
      {
        message: "パスワードを変更しました",
        type: "light-blue",
        status: true,
      },
    )
        })
        .catch(err => {
          this.showMessage(
      {
        message: "パスワード変更に失敗しました",
        type: "error",
        status: true,
      },
    )
          console.log(err)
        })
      },
  },
  head() {
    return {
      title: {
        inner: "PasswordEdit",
        separator: "|",
        complement: "BizTubeLogger",
      }
    }
  },
};
</script>