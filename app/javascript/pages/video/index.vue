<template>
  <v-container>
    <h1>投稿一覧</h1>
    <VideoItem
    :videos="videos"
    />
  </v-container>
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