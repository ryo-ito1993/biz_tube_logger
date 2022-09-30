<template>
  <v-container class="text-center justify-center py-6">
    <v-card
      max-width="1500px"
      elevation="20"
      class="mx-auto mt-5"
    >
      <h2 class="pt-3 mb-3 d-flex align-center justify-center">
        <v-icon
          left
          bottom
          color="#00AA00"
        >
          mdi-pen-plus
        </v-icon>
        NEW OUTPUT
      </h2>
      <v-divider
        class="mb-4"
        style="max-width: 1200px; margin: auto"
      />
      <v-card-text>
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
          <v-card-actions>
            <v-btn
              class="mr-4 font-weight-bold"
              type="submit"
              color="success"
              :disabled="invalid"
              large
              width="100"
              @click="createVideo"
            >
              投稿する
            </v-btn>
          </v-card-actions>
        </ValidationObserver>
      </v-card-text>
    </v-card>
  </v-container>
</template>

<script>
import { mapActions } from "vuex"
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
      ...mapActions("flashMessage", ["showMessage"]),
      createVideo() {
      this.$axios.post('videos', { youtube_url: this.youtube_url, output: this.output , selected_categories: this.selected_categories})
        .then(res => {
          this.$router.push({ name:'VideoIndex' })
          this.showMessage(
      {
        message: "投稿しました",
        type: "light-blue",
        status: true,
      },
    )
        })
        .catch(err => {
          this.showMessage(
      {
        message: "投稿に失敗しました",
        type: "error",
        status: true,
      },
    )
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