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
        <v-hover v-slot:default="{ hover }">
          <v-card
            class="mx-auto mt-4"
            max-width="360"
            height="405"
            :elevation="hover ? 12 : 2"
          >
            <router-link :to="{ path: `/video/${video.id}` }">
              <v-img
                :src="video.thumbnail"
                height="200px"
              />

              <v-card-title
                class="text-truncate d-inline-block pt-1 pb-0"
                style="width: 100%"
              >
                {{ video.title }}
              </v-card-title>
            </router-link>

            <v-card-subtitle class="pt-0 pb-1">
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
                <div v-for="(key, value) in video.video_comments"
                    :key="key.id"
                    >
                    <span v-if="Number(value) === video.id">{{key}}</span>
                </div>
              </div>
              <div>
                <v-icon>mdi-bookmark-outline</v-icon>
              </div>
            </v-card-text>
            <div class="ml-3">
              投稿者：
              <span
                v-for="output in video.outputs"
                :key="output.id"
                class="mr-2"
              >
                <v-icon>mdi-account-circle</v-icon>{{ output.name }}
              </span>
            </div>
            <div class="mt-3 ml-3">
              <v-icon> mdi-tag</v-icon>
              <v-chip
                v-for="category in video.categories"
                :key="category.id"
                class="mr-1"
                color="primary"
                small
              >
                {{ category.name }}
              </v-chip>
            </div>
          </v-card>
        </v-hover>
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
      selected: null
    }
  },
    mounted() {
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