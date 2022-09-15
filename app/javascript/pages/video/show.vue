<template>
  <v-container>
    <v-card class="pa-5 top-frame">
      <div
        v-for="video in video"
        :key="video.id"
      >
        <iframe
          width="840"
          height="473"
          :src="`https://www.youtube-nocookie.com/embed/${video.youtube_id}`"
          title="YouTube video player"
          frameborder="0"
          allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
          allowfullscreen
        />
        <h4 class=" pt-5 title">
          {{ video.title }}
        </h4>
        <div class="ml-5 pt-2">
          <span class="count">再生回数:{{ video.view_count }}回</span>
        </div>
      </div>
      <v-card
        v-for="output in outputs"
        :key="output.id"
        class="frame pa-4 mt-3 shades rounded-lg"
      >
        <h2>{{ output.user.name }}さんのアウトプット投稿</h2>
        <v-card-subtitle>投稿日{{ output.created_at }}</v-card-subtitle>
        <v-card class="box">
          <span class="box-title">動画内容のアウトプット</span>
          <p class="content">
            {{ output.summary }}
          </p>
        </v-card>
        <v-card class="box">
          <span class="box-title">感想や今後に活かすこと</span>
          <p class="content">
            {{ output.impression }}
          </p>
        </v-card>
      </v-card>
    </v-card>
  </v-container>
</template>

<script>
export default {
  props: ["id"],
  data() {
    return {
      video: null,
      outputs: []
    }
  },
  mounted: function () {
    this.fetchVideoDetail();
    this.fetchOutputsDetail();
  },
  methods: {
    fetchVideoDetail() {
      this.$axios.get("/videos/" + this.id)
        .then(res => this.video = res.data)
        .catch(err => console.log(err.status));
    },
    fetchOutputsDetail() {
      this.$axios.get("/outputs/" + this.id)
        .then(res => this.outputs = res.data)
        .catch(err => console.log(err.status));
    },
  }
}
</script>

<style scoped>
iframe {
  display: block;
  margin: 0 auto;
  max-width: 100%;
}

.box {
  position: relative;
  margin: 3em 0 2em 0;
  padding: 0.5em 1em;
  border: solid 3px #7d420aa4;
}
.box .box-title {
  position: absolute;
  display: inline-block;
  top: -27px;
  left: -3px;
  padding: 0 9px;
  height: 25px;
  line-height: 25px;
  font-size: 18px;
  background: #9999CC;
  color: white;
  font-weight: bold;
  border-radius: 5px 5px 0 0;
}
.box p {
  margin: 0;
  padding: 0;
}

.top-frame{
  background: -webkit-linear-gradient(top, #D5DEE7 0%, #E8EBF2 50%, #E2E7ED 100%), -webkit-linear-gradient(top, rgba(0, 0, 0, 0.02) 50%, rgba(255, 255, 255, 0.02) 61%, rgba(0, 0, 0, 0.02) 73%), -webkit-linear-gradient(57deg, rgba(255, 255, 255, 0.2) 0%, rgba(0, 0, 0, 0.2) 100%);
  background: linear-gradient(to bottom, #D5DEE7 0%, #E8EBF2 50%, #E2E7ED 100%), linear-gradient(to bottom, rgba(0, 0, 0, 0.02) 50%, rgba(255, 255, 255, 0.02) 61%, rgba(0, 0, 0, 0.02) 73%), linear-gradient(33deg, rgba(255, 255, 255, 0.2) 0%, rgba(0, 0, 0, 0.2) 100%);
}

</style>
