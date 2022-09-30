<template>
  <v-container class="white rounded-lg pb-5">
    <p class="text-h6 pt-2 mb-3 font-weight-bold text-center">
      EDIT PROFILE
    </p>
    <v-divider
      class="mb-4"
      style="max-width: 1000px; margin: auto"
    />
    <ValidationObserver v-slot="{ invalid }">
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

      <v-btn
        class="mr-4 font-weight-bold"
        type="submit"
        color="success"
        :disabled="invalid"
        @click="handleUpdateProfile"
      >
        更新する
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
  export default {
    name: "ProfileEditModal",
    props: {
      user: {
        type: Object,
        required: true,
      },
    },
    methods: {
      handleCloseModal(){
        this.$emit('close-modal')
      },
      handleUpdateProfile() {
      this.$emit('update-profile', this.user)
    }

    }
  }
</script>

<style scoped>

</style>