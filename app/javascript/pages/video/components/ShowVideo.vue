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
      <div class=" pt-5 title text-h5 font-weight-bold">
        {{ video.title }}
      </div>
      <div class="wrap-box ml-5 mb-4 pt-2">
        <span class="count">再生回数:{{ video.view_count }}回</span>
        <span class="box-right category">
          <v-icon> mdi-tag</v-icon>
          <v-chip
            v-for="category in video.categories"
            :key="category.id"
            class="mr-1"
            color="primary"
          >
            {{ category.name }}
          </v-chip>
        </span>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "ShowVideo",
  props: {
    videos: {
      type: Array,
      required: true,
    }
  }
}
</script>

<style scoped>
iframe {
  display: block;
  margin: 0 auto;
  max-width: 100%;
}

.wrap-box {
  position: relative;
}

.wrap-box .box-right {
  position: absolute;
  right: 0;
}

.category{
  margin-right: 30px;
}
</style>