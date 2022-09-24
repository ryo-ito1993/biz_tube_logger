<template>
  <div>
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
              <span class="mr-1">
                <v-icon>mdi-thumb-up-outline</v-icon>
              </span>
              <span
                v-for="(key, value) in video.video_likes"
                :key="key.id"
              >
                <template v-if="Number(value) === video.id">{{ key }}</template>
              </span>
              <span>
                <v-icon class="mr-1">
                  mdi-comment-outline
                </v-icon>
              </span>
              <span
                v-for="(key, value) in video.video_comments"
                :key="key.id"
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
                    <v-icon @click="bookmark(video)">mdi-bookmark-outline</v-icon>
                  </span>
                </template>
              </template>
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
import { mapGetters, mapActions } from "vuex"
export default {
  name: "VideoItem",
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
    this.fetchmyBookmarks();
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