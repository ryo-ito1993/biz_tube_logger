<template>
<div>
<v-container class="text-center justify-center py-6">
      <h3 class="font-weight-bold text-h4">
        MY PAGE
      </h3>
    </v-container>
    <v-col>
    <v-tabs
    fixed-tabs
    dark
    class="rounded"
    v-model="tab"
  >
    <v-tab>
      MY LIST
    </v-tab>
    <v-tab>
      BOOKMARKS
    </v-tab>


    <v-tab-item class="rounded grey lighten-2">
      <v-container>
      <VideoItem
      :videos="uservideos"
    />
    </v-container>
    </v-tab-item>

    <v-tab-item class="rounded grey lighten-2">
      <v-container class="pb-10">
      <VideoItem
      :videos="bookmarks"
    />
    </v-container>
    </v-tab-item>
  </v-tabs>
  </v-col>
  </div>
</template>


<script>
import { mapGetters, mapActions } from "vuex"
import VideoItem from "../video/components/VideoItem.vue"
export default {
  name: "MypageIndex",
    components: {
    VideoItem,
  },
  data() {
    return {
      videos: [],
      tab: null
    }
  },
  computed: {
    ...mapGetters("users", ["authUser"]),
    ...mapGetters("bookmarks", ["bookmarks"]),
    uservideos() {
    return this.videos.filter(
      video => video.user_id === this.authUser.id)
    },
  },
  created () {
    this.fetchVideos();
    this.fetchmyBookmarkList();
  },
  methods: {
    ...mapActions("bookmarks", ["fetchmyBookmarkList"]),
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