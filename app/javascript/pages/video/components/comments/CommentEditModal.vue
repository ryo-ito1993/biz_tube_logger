<template>
  <v-container class=" white rounded-lg">
    <p class="text-h5 pt-5 title text-center">
      コメント編集
    </p>
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
        @click="handleUpdateComment"
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
    name: "CommentEditModal",
    props: {
      comment: {
        id: {
        type: Number,
        required: true
      },
        body: {
          type: Text,
          required: true
        },
        video_id: {
          type: Number,
          required: true
        }
      },

    },
    methods: {
      handleCloseModal(){
        this.$emit('close-modal')
      },
      handleUpdateComment() {
      this.$emit('update-comment', this.comment)
    }
    }
  }
</script>

<style scoped>

</style>