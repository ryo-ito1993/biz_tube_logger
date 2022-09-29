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
      :videos="videos"
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
import { mapGetters } from "vuex"
import VideoItem from "../video/components/VideoItem.vue"
export default {
  name: "MypageIndex",
    components: {
    VideoItem,
  },
  data() {
    return {
      videos: [],
      tab: null,
      bookmarks: []
    }
  },
  computed: {
    ...mapGetters("users", ["authUser"]),
  },
  created () {
    this.fetchmyVideos();
    this.fetchmyBookmarkList();
  },
  methods: {
    fetchmyVideos() {
      this.$axios.get("/users/" + this.authUser.id)
        .then(res => this.videos = res.data)
        .catch(err => console.log(err.status));
    },
    fetchmyBookmarkList(){
      this.$axios.get('bookmarks/bookmark_list')
        .then(res => this.bookmarks = res.data)
        .catch(err => console.log(err.status));
    }
  }
}
</script>

<style scoped>

</style>