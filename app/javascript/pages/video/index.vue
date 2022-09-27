<template>
<v-row class="grey lighten-3">
  <v-col cols=2>
    <v-container class="red mt-10 ml-5">
      <v-card height="500">
        <v-btn x-large color="primary">
          NEW OUTPUT
        </v-btn>

      </v-card>

    </v-container>
  </v-col>
  <v-col cols=10>
  <v-container class="mt-5 mb-5 shades rounded-lg">
    <p class="text-h5 text-center title font-weight-bold">OUTPUT LIST</p>
      <v-divider class="pb-5"></v-divider>
    <VideoItem
      :videos="videos"
    />
  </v-container>
  </v-col>
  </v-row>
</template>


<script>
import VideoItem from "./components/VideoItem.vue"
export default {
  name: "VideoIndex",
    components: {
    VideoItem,
  },
  data() {
    return {
      videos: [],
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