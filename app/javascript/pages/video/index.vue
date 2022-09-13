<template>
  <v-container>
    <h1>投稿一覧</h1>
    <v-row>
      <v-col
        v-for="video in videos"
        :key="video.id"
        cols="12"
        sm="4"
        md="4"
      >
        <v-card
          class="mx-auto mt-4"
          max-width="350"
          height="420"
        >
          <v-img
            :src="video.thumbnail"
            height="200px"
          />
          <v-card-title
            class="font-weight-bold text-truncate d-inline-block"
            style="width: 100%"
          >
            {{ video.title }}
          </v-card-title>

          <v-card-subtitle>
            {{ video.view_count }}回再生
          </v-card-subtitle>

          <v-card-text class="d-flex text-caption">
            {{ video.created_at }}
            <v-spacer />
            <div class="mr-2">
              <v-icon>mdi-thumb-up-outline</v-icon>
              {{ }}
            </div>
            <div>
              <v-icon class="mr-2">
                mdi-comment-outline
              </v-icon>
              {{ }}
            </div>
            <div>
              <v-icon>mdi-bookmark-outline</v-icon>
            </div>
          </v-card-text>
          <div class="ml-3">
            投稿者：
            <span
              v-for="output in video.output_name"
              :key="output.id"
              class="mr-2"
            >
              <v-icon>mdi-account-circle</v-icon>{{ output.output_name }}
            </span>
          </div>
          <div class="mt-3 ml-3">
            <v-icon> mdi-tag</v-icon>
            カテゴリー名
          </div>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>


<script>
export default {
  name: "VideoIndex",
  data() {
    return {
      videos: [],
    }
  },
    created() {
    this.fetchVideos();
  },
  methods: {
    fetchVideos() {
      this.$axios.get("videos")
        .then(res => this.videos = res.data)
        .catch(err => console.log(err.status));
    },
  }
}
</script>

<style scoped>

</style>