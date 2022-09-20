<template>
  <v-container class="mt-5 shades white rounded-lg mb-5">
    <p class="text-h4 pt-5 title font-weight-bold text-center">
      アウトプット投稿
    </p>
    <ValidationObserver v-slot="{ invalid }">
      <ValidationProvider
        v-slot="{ errors }"
        rules="required|url_format"
      >
    <v-text-field
      v-model="youtube_url"
      label="YouTube動画URL"
      placeholder="YouTube動画URLを貼り付けてください"
      outlined
      :error-messages="errors"
    />
    </ValidationProvider>

    <v-select
      v-model="selected_categories"
      item-text="name"
      :items="categories"
      class="hoge"
      chips
      label="カテゴリー"
      multiple
      outlined
    >
      <template #selection="{ item }">
        <v-chip color="primary">
          {{ item.name }}
        </v-chip>
      </template>
    </v-select>
    <ValidationProvider
        v-slot="{ errors }"
        rules="required"
      >
    <v-textarea
      v-model="output.summary"
      label="動画内容のアウトプット"
      placeholder="動画の要約やためになった内容をまとめてみよう！"
      auto-grow
      outlined
      :error-messages="errors"
    />
    </ValidationProvider>

    <ValidationProvider
        v-slot="{ errors }"
        rules="required"
      >
    <v-textarea
      v-model="output.impression"
      label="感想、今後に活かしたいこと"
      placeholder="動画の感想や今後に活かしたいことをまとめてみよう！"
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
      @click="createVideo"
    >
      投稿する
    </v-btn>
    </ValidationObserver>
  </v-container>
</template>

<script>
export default {
    data: () => ({
      categories: [],
      selected_categories: [],
      youtube_url: '',
      output: {
        summary: '',
        impression: ''
      }
    }),
    created: function () {
      this.fetchCategories();
    },
    methods: {
      createVideo() {
      this.$axios.post('videos', { youtube_url: this.youtube_url, output: this.output , selected_categories: this.selected_categories})
        .then(res => {
          this.$router.push({ name:'VideoIndex' })
        })
        .catch(err => {
          console.log(err)
        })
      },
      fetchCategories() {
      this.$axios.get("/categories/")
        .then(res => this.categories = res.data)
        .catch(err => console.log(err.status));
    },

    }
}
</script>

<style scoped>
</style>