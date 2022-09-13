<template>
  <v-container class="mt-5 shades white rounded-lg mb-5">
    <p class="text-h4 pt-5 title font-weight-bold text-center">アウトプット投稿</p>
      <form @submit.prevent="submit">
        <!-- タイトル -->

          <v-text-field
            v-model="youtube_url"
            label="YouTube動画URL"
            placeholder="共有URLを貼り付けてください"
            outlined
          ></v-text-field>


          <v-select
            v-model="value"
            :items="items"
            class="hoge"
            chips
            label="カテゴリー"
            multiple
            outlined
          ></v-select>

        <!-- 本文 -->
          <v-textarea
            v-model="output.summary"
            label="動画内容のアウトプット"
            placeholder="動画の要約やためになった内容をまとめてみよう！"
            auto-grow
            outlined
          ></v-textarea>

          <v-textarea
            v-model="output.impression"
            label="感想、今後に活かしたいこと"
            placeholder="動画の感想や今後に活かしたいことをまとめてみよう！"
            auto-grow
            outlined
          ></v-textarea>


        <v-btn
          class="mr-4 font-weight-bold"
          type="submit"
          color="success"
        >
          投稿する
        </v-btn>
      </form>
  </v-container>
</template>

<script>
export default {
    data: () => ({
      items: ['仕事', 'お金/投資', '健康', '教養', '対談', '要約', 'その他'],
      value: [],
      youtube_url: '',
      output: {
        summary: '',
        impression: ''
      }
    }),
  }
</script>

<style scoped></style>