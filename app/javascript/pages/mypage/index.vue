<template>
  <div>
    <v-container class="text-center justify-center pb-0 d-flex">
      <span class="text-h6 mb-0 font-weight-bold">
        {{ authUser.name }}さんのMY PAGE
      </span>
      <v-spacer />
      <v-btn color="success">
        Edit Profile
      </v-btn>
    </v-container>
    <v-container class="text-center justify-center py-6">
      <v-card elevation="10">
        <v-row>
          <v-col>
            <v-icon
              large
              color="#00AA00"
            >
              mdi-pen-plus
            </v-icon>
            <h3 class="output">
              {{ videos.length }}
            </h3>
            <h3 class="output">
              投稿数
            </h3>
          </v-col>
          <v-col>
            <v-icon
              large
              color="#2C7CFF"
            >
              mdi-thumb-up-outline
            </v-icon>
            <h3 class="like">
              {{ likesCommentsCount.likes_count }}
            </h3>
            <h3 class="like">
              参考になった数
            </h3>
          </v-col>
          <v-col>
            <v-icon
              large
              color="black"
            >
              mdi-comment-outline
            </v-icon>
            <h3>
              {{ likesCommentsCount.comments_count }}
            </h3>
            <h3>
              コメント数
            </h3>
          </v-col>
        </v-row>
      </v-card>
    </v-container>
    <v-col>
      <v-tabs
        v-model="tab"
        fixed-tabs
        dark
        class="rounded"
      >
        <v-tab>
          MY OUTPUTS
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
      bookmarks: [],
      likesCommentsCount: []
    }
  },
  computed: {
    ...mapGetters("users", ["authUser"]),
  },
  created () {
    this.fetchmyVideos();
    this.fetchmyBookmarkList();
    this.fetchmyLikesCommentsCount();
  },
  methods: {
    fetchmyVideos() {
      this.$axios.get("/mypages/" + this.authUser.id)
        .then(res => this.videos = res.data)
        .catch(err => console.log(err.status));
    },
    fetchmyBookmarkList(){
      this.$axios.get('bookmarks/bookmark_list')
        .then(res => this.bookmarks = res.data)
        .catch(err => console.log(err.status));
    },
    fetchmyLikesCommentsCount(){
      this.$axios.get('mypages/' + this.authUser.id + '/likes_comments_count')
        .then(res => this.likesCommentsCount = res.data)
        .catch(err => console.log(err.status));
    },
  }
}
</script>

<style scoped>
.v-icon{
  margin-top: 15px;
  margin-bottom: 20px;
}
.v-card{
  background-image: linear-gradient(180deg, #E9E9E7 2%, #EFEEEC 27%, #EEEEEC 58%, #D5D4D0 94%);
}
.v-card h3{
  margin-bottom: 15px;
}
.like{
  color: #2C7CFF;
}
.output{
  color: #00AA00	;
}
</style>