<template>
  <div>
    <div
      v-for="video in videos"
      :key="'video' + video.id"
    >
      <iframe
        width="840"
        height="473"
        :src="`https://www.youtube.com/embed/${video.youtube_id}`"
        title="YouTube video player"
        frameborder="0"
        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
        allowfullscreen
      />
      <div class="pt-5 ml-3 mr-3 title text-h5 font-weight-bold">
        {{ video.title }}
      </div>
      <div class="d-flex ml-5 mb-4 pt-2 mr-5">
        <span class="count">再生回数:{{ video.view_count.toLocaleString() }}回</span>
        <v-spacer />
        <span class="box-right category">
          <v-icon color="primary"> mdi-tag</v-icon>
          <v-chip
            v-for="category in video.categories"
            :key="category.id"
            class="mr-1"
            color="primary"
          >
            {{ category.name }}
          </v-chip>
          <template v-if="authUser">
            <template v-if="isAuthUserBookmark(video)">
              <span>
                <v-icon
                  large
                  color="green"
                  @click="unbookmark(video)"
                >mdi-bookmark-check</v-icon>
              </span>
            </template>
            <template v-else>
              <span>
                <v-icon
                  large
                  @click="bookmark(video)"
                >mdi-bookmark-outline</v-icon>
              </span>
            </template>
          </template>
        </span>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex"
export default {
  name: "ShowVideo",
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
iframe {
  display: block;
  margin: 0 auto;
  max-width: 100%;
}

@media only screen and (max-width:600px) {
  iframe {
    width: 500px;
    height:281px;
  }
}

</style>