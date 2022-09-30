<template>
  <v-container class="white rounded-lg">
    <p class="text-h6 pt-2 mb-3 font-weight-bold text-center">
      <v-icon
        left
        bottom
      >
        mdi-comment-processing-outline
      </v-icon>
      COMMENT
    </p>
    <v-divider
      class="mb-4"
      style="max-width: 1200px; margin: auto"
    />
    <ValidationObserver v-slot="{ invalid }">
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
        :disabled="invalid"
        @click="handleCreateComment"
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