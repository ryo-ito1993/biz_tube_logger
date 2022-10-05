<template>
  <v-container class="white rounded-lg">
    <p class="text-h6 pt-2 mb-3 font-weight-bold text-center">
      Reset Your Password
    </p>
    <v-divider
      class="mb-4"
      style="max-width: 1200px; margin: auto"
    />
    <ValidationObserver v-slot="{ invalid }">
      <ValidationProvider
        v-slot="{ errors }"
        name="メールアドレス"
        rules="required|email"
      >
        <v-text-field
          v-model="email"
          label="メールアドレス"
          type="email"
          prepend-icon="mdi-email"
          :error-messages="errors"
          placeholder="メールアドレスを入力してください"
        />
      </ValidationProvider>

      <v-btn
        class="mr-4 font-weight-bold"
        type="submit"
        color="success"
        :disabled="invalid"
        @click="createPasswordReset"
      >
        送信
      </v-btn>
      <v-btn
        class="mr-4 font-weight-bold"
        type="submit"
        @click="handleCloseModal"
      >
        キャンセル
      </v-btn>
    </ValidationObserver>
  </v-container>
</template>

<script>
import { mapActions } from "vuex"
  export default {
    name: "ResetPasswordModal",
    data() {
      return {
        email: ''
      }
    },
    methods: {
      ...mapActions("flashMessage", ["showMessage"]),
      createPasswordReset() {
      this.$axios.post('password_resets', { email: this.email })
        .then(res => {
          this.$router.push({ name:'VideoIndex' })
          this.showMessage(
      {
        message: "パスワード再設定メールを送信しました",
        type: "light-blue",
        status: true,
      },
    )
        })
        .catch(err => {
          this.showMessage(
      {
        message: "送信に失敗しました",
        type: "error",
        status: true,
      },
    )
          console.log(err)
        })
      },
      handleCloseModal(){
        this.$emit('close-modal')
      },
    }
  }
</script>

<style scoped>

</style>