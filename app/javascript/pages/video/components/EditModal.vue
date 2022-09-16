<template>
  <v-container class="mt-5 shades white rounded-lg mb-5">
    <p class="text-h4 pt-5 title font-weight-bold text-center">
      {{ output.user.name }}さんのアウトプット編集
    </p>

    <iframe
      width="672"
      height="378"
      :src="`https://www.youtube-nocookie.com/embed/${youtubeId}`"
      title="YouTube video player"
      frameborder="0"
      allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
      allowfullscreen
      class="mb-5"
    />

    <v-textarea
      v-model="output.summary"
      label="動画内容のアウトプット"
      placeholder="動画の要約やためになった内容をまとめてみよう！"
      auto-grow
      outlined
    />

    <v-textarea
      v-model="output.impression"
      label="感想、今後に活かしたいこと"
      placeholder="動画の感想や今後に活かしたいことをまとめてみよう！"
      auto-grow
      outlined
    />


    <v-btn
      class="mr-4 font-weight-bold"
      type="submit"
      color="success"
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
  </v-container>
</template>

<script>
  export default {
    name: "EditModal",
    props: {
      output: {
        summary: {
          type: Text,
          required: true
        },
        impression: {
          type:Text,
          required: true
        }
      },
      youtubeId:{
        type: String,
        required: true
      }

    },
    methods: {
      handleCloseModal(){
        this.$emit('close-modal')
      }
    }
  }
</script>

<style scoped>
iframe {
  display: block;
  margin: 0 auto;
  max-width: 100%;
}
</style>