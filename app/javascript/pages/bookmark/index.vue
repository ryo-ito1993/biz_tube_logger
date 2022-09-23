<template>
  <v-container>
    <h1>ブックマーク一覧</h1>
    <VideoItem
      :videos="bookmarks"
    />
  </v-container>
</template>


<script>
import { mapGetters, mapActions } from "vuex"
import VideoItem from "../video/components/VideoItem.vue"
export default {
  name: "BookmarkIndex",
    components: {
    VideoItem,
  },
  data() {
    return {
      videos: [],
    }
  },
  computed: {
    ...mapGetters("bookmarks", ["bookmarks"]),
  },
  created () {
    this.fetchmyBookmarkList();
  },
  methods: {
    ...mapActions("bookmarks", ["fetchmyBookmarkList"]),
  }
}
</script>

<style scoped>

</style>