<template>
  <div>
    <v-row>
      <v-col
        v-for="video in videos"
        :key="video.id"
        cols="12"
        sm="6"
        md="4"
      >
        <v-hover v-slot:default="{ hover }">
          <v-card
            class="grey lighten-3"
            max-width="400"
            max-height="450"
            :elevation="hover ? 12 : 2"
            outlined
            tile
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

            <v-card-subtitle class="pt-0 pb-1 d-flex">
              {{ video.view_count.toLocaleString() }}回再生
              <v-spacer />
              <span>
                <v-icon
                  color="primary"
                  class="mr-1"
                >
                  mdi-pen
                </v-icon>
              </span>
              <span class="primary--text mr-1">
                {{ video.outputs.length }}
              </span>
              <span class="mr-1">
                <v-icon color="primary">mdi-thumb-up-outline</v-icon>
              </span>
              <span
                v-for="(key, value) in video.video_likes"
                :key="key.id"
                class="primary--text"
              >
                <template v-if="Number(value) === video.id">{{ key }}</template>
              </span>
              <span>
                <v-icon
                  color="primary"
                  class="mr-1 ml-1"
                >
                  mdi-comment-outline
                </v-icon>
              </span>
              <span
                v-for="(key, value) in video.video_comments"
                :key="key.id"
                class="primary--text"
              >
                <template v-if="Number(value) === video.id">{{ key }}</template>
              </span>
              <template v-if="authUser">
                <template v-if="isAuthUserBookmark(video)">
                  <span>
                    <v-icon
                      color="green"
                      @click="unbookmark(video)"
                    >mdi-bookmark-check</v-icon>
                  </span>
                </template>
                <template v-else>
                  <span>
                    <v-icon
                      color="primary"
                      @click="bookmark(video)"
                    >mdi-bookmark-outline</v-icon>
                  </span>
                </template>
              </template>
            </v-card-subtitle>

            <v-card-text>
              最新投稿日:{{ video.outputs[0].created_at | moment }}
            </v-card-text>

            <div class="ml-3 pb-3">
              <v-icon color="primary">
                mdi-tag
              </v-icon>
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
  </div>
</template>

<script>
import moment from "moment";
import { mapGetters, mapActions } from "vuex"
export default {
  name: "VideoItem",
  filters: {
      moment: function(date) {
        return moment(date).format("YYYY/MM/DD");
      },
    },
  props: {
    videos: {
      type: Array,
      default: null
    }
  },
  computed: {
  ...mapGetters("users", ["authUser"]),
  ...mapGetters("bookmarks", ["bookmarks"]),
  },
  created () {
    if(this.authUser){
    this.fetchmyBookmarks();
    }
  },
  methods: {
    ...mapActions("bookmarks", ["fetchmyBookmarks", "createBookmark", "deleteBookmark"]),
    ...mapActions("flashMessage", ["showMessage"]),
    bookmark(video){
      this.createBookmark(video)
      this.showMessage(
      {
        message: "ブックマークしました",
        type: "light-blue",
        status: true,
      })
    },
    unbookmark(video){
      this.deleteBookmark(video)
      this.showMessage(
      {
        message: "ブックマークを解除しました",
        type: "warning",
        status: true,
      })
    },
    isAuthUserBookmark(video) {
      return this.bookmarks.some(v => v.id === video.id)
    }
  },
}
</script>

<style scoped>
.comment-count{
  color: blue;
}
.card{
  border-radius: 50px;
}
</style>