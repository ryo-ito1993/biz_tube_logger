<template>
  <v-container class="mt-5 shades white rounded-lg mb-5">
    <p class="text-h6 pt-2 mb-3 font-weight-bold text-center">
      <v-icon
        left
        bottom
        color="#00AA00"
      >
        mdi-square-edit-outline
      </v-icon>
      Edit Output
    </p>
    <v-divider
      class="mb-4"
      style="max-width: 1200px; margin: auto"
    />

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
    <ValidationObserver v-slot="{ invalid }">
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
        @click="handleUpdateOutput"
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
    name: "EditModal",
    props: {
      output: {
        type: Object,
        required: true,
        id: {
        type: Number,
        required: true
      },
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
      },
      handleUpdateOutput() {
      this.$emit('update-output', this.output)
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
@media only screen and (max-width:600px) {
  iframe {
    width: 500px;
    height:281px;
  }
}
</style>