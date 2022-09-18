<template>
  <v-container class="mt-5 shades white rounded-lg mb-5">
    <p class="text-h4 pt-5 title font-weight-bold text-center">
      コメント投稿
    </p>

    <v-textarea
      v-model="comment.body"
      label="コメント内容"
      placeholder="コメントを投稿しよう！"
      auto-grow
      outlined
    />

    <v-btn
      class="mr-4 font-weight-bold"
      type="submit"
      color="success"
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
  </v-container>
</template>

<script>
  export default {
    name: "CommentCreateModal",
    data() {
      return {
        comment: {
          body: '',
          output_id: ''
        },
      }
    },
    props: {
      outputId: {
        type: Number,
        required: true
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