<template>
  <div class="top">
    <!-- メインヘッダー -->
    <div class="main">
        <v-img src="image/main.jpg" max-height="700">
        <v-container class="text-center main-text">
          <h1 class="mt-10 white--text">BizTubeLogger</h1>
          <h2 class="mt-10">
            ビジネスYouTubeで学んだことをアウトプットしよう!
          </h2>
          <router-link :to="{ name: 'VideoIndex' }">
            <v-btn class="primary mt-10">
              みんなの投稿を覗いてみる
            </v-btn>
          </router-link>
        </v-container>
        </v-img>
    </div>
    <!-- 最近の投稿 -->
    <div class="video-zone pb-3">
      <v-container>
        <h2 class="text-center my-5">PICKUP OUTPUTS</h2>
        <VideoItem
      :videos="limitvideos"
    />
      </v-container>
    </div>
    <!-- アプリ紹介 -->
    <div class="features">
    <v-container class="main-content">
      <v-row
        v-for="(description, index) in descriptions"
        :key="index"
        :class="'flex-row' + description.line"
      >
        <v-col class="align-self-center" :md="7">
          <h2 class="mb-5">{{ description.title }}</h2>
          <div v-html="description.text" />
        </v-col>
        <v-col :md="5">
          <v-img max-height="270" :alt="description.title" :src="description.imgSrc" />
        </v-col>
      </v-row>
    </v-container>
    </div>
  </div>
</template>

<script>
import VideoItem from "../video/components/VideoItem.vue"
export default {
  components: {
    VideoItem,
  },
  data() {
    return {
      videos: [],
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
  },
  computed: {
    descriptions() {
      return [
        {
          title: "YouTubeで学んだことをアウトプットしよう",
          imgSrc: "/image/pc.png",
          text:
            "<p>YouTubeでの学びがインプットだけになっていませんか？</p><p>インプットとアウトプットの黄金比は3:7と言われています。</p><p>学んだことをアウトプットして知識を定着させていきましょう！</p>",
          line: ""
        },
        {
          title: "アウトプットを積み上げて自分のスキルにしよう",
          imgSrc: "/image/step.png",
          text:
            "<p>継続してアウトプットすることで知識がどんどん増えていきます。</p><p>積み上げ記録はマイページで確認しましょう！</p>",
          line: "-reverse"
        },
        {
          title: "みんなの投稿を見て知識を広げよう",
          imgSrc: "/image/videos.png",
          text:
            "<p>みんなの投稿から自分の知らなかった分野の知識を得ることができるかもしれません。</p><p>興味のある投稿があれば動画をチェックしてアウトプットしてみましょう！</p>",
          line: ""
        }
      ]
    },
    limitvideos() {
      return this.videos.slice(0,3)
    }

  }
}
</script>

<style scoped>
.top {
  color: #3b394d;
}
.main {
  background-color: white;
}
.video-zone {
  background-color: #BAD3FF;
}
.video-zone h2 {
  color: #fff;
}
.features{
  background-color: white;
}
.features p {
  line-height: 1.8rem;
}

.video-zone p {
  line-height: 1.5rem;
}

.main-text{
  margin-top: 100px;
}
</style>