<template>
  <v-container class="white rounded-lg">
    <p class="text-h5 pt-5 title text-center">
      コメント投稿
    </p>
    <ValidationObserver v-slot="{ handleSubmit }">
      <ValidationProvider
                  v-slot="{ errors }"
                  rules="required"
                >
    <v-textarea
      v-model="comment.body"
      label="コメント内容"
      placeholder="コメントを投稿しよう！"
      auto-grow
      outlined
      :error-messages="errors"
    />
    </ValidationProvider>

    <v-btn
      class="mr-4 font-weight-bold"
      type="submit"
      color="success"
      @click="handleSubmit(handleCreateComment)"
    >
      投稿する
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
    name: "CommentCreateModal",
    props: {
      outputId: {
        type: Number,
        required: true
      }
    },
    data() {
      return {
        comment: {
          body: '',
          output_id: ''
        },
      }
    },
    methods: {
      handleCloseModal(){
        this.$emit('close-modal')
      },
      handleCreateComment() {
      this.comment.output_id = this.outputId
      this.$emit('create-comment', this.comment)
    }
    }
  }
</script>

<style scoped>

</style>