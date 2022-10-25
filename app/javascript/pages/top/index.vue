<template>
  <div class="top">
    <!-- メインヘッダー -->
    <div class="main">
      <v-img
        src="image/black.png"
        max-height="580"
      >
        <v-container class="main-text">
          <v-col>
            <h1 class="main-title white--text">
              BizTubeLogger
            </h1>
            <h4 class="white--text pb-3">
              ビジネスYouTubeアウトプット記録・共有サービス
            </h4>
            <h3 class="white--text mt-10">
              せっかく学んだ知識、活かせていますか？
            </h3>
            <h3 class="white--text mt-3">
              アウトプットで知識を自分のモノにしましょう！
            </h3>
            <router-link :to="{ name: 'RegisterIndex' }">
              <v-btn class="success ml-10 mt-10">
                さっそくはじめる
              </v-btn>
            </router-link>
            <v-btn
              class="primary ml-6 mt-10"
              @click="guestLogin()"
            >
              ゲストログインで試してみる
            </v-btn>
          </v-col>
        </v-container>
      </v-img>
    </div>
    <!-- 最近の投稿 -->
    <div class="video-zone pb-3 grey lighten-1">
      <v-container>
        <h1 class="text-center my-5 white--text">
          PICKUP OUTPUTS
        </h1>
        <VideoItem
          :videos="limitvideos"
        />
      </v-container>
    </div>
    <!-- アプリ紹介 -->
    <div class="features">
      <v-container class="main-content">
        <h1 class="text-center my-5">
          HOW TO USE
        </h1>
        <v-row
          v-for="(description, index) in descriptions"
          :key="index"
          :class="'flex-row' + description.line"
        >
          <v-col
            class="align-self-center"
            :md="7"
          >
            <h2 class="mb-5">
              {{ description.title }}
            </h2>
            <!-- eslint-disable -->
            <div v-html="description.text" />
            <!-- eslint-enable -->
          </v-col>
          <v-col :md="5">
            <v-img
              max-height="270"
              max-width="500"
              :alt="description.title"
              :src="description.imgSrc"
            />
          </v-col>
        </v-row>
      </v-container>
    </div>
  </div>
</template>

<script>
import { mapActions } from "vuex"
import VideoItem from "../video/index/components/VideoItem.vue"
export default {
  components: {
    VideoItem,
  },
  data() {
    return {
      videos: [],
    }
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
          imgSrc: "/image/notes.png",
          text:
            "<p>継続してアウトプットすることで知識がどんどん増えていきます。</p><p>アウトプットを積み上げてマイページから振り返りましょう！</p>",
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

  },
    mounted() {
    this.fetchVideos();
  },
  methods: {
    ...mapActions("users", ["guestLoginUser"]),
    ...mapActions("flashMessage", ["showMessage"]),
    fetchVideos() {
      this.$axios.get("videos")
        .then(res => this.videos = res.data)
        .catch(err => console.log(err.status));
    },
    async guestLogin() {
      try {
        await this.guestLoginUser();
        this.$router.push({ name: 'VideoIndex' })
        this.showMessage(
      {
        message: "ゲストユーザーでログインしました",
        type: "light-blue",
        status: true,
      },
    )
      } catch (error) {
        this.showMessage(
      {
        message: "ログインに失敗しました",
        type: "error",
        status: true,
      },
    )
        console.log(error);
      }
    },
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
  margin-top: 30px;
}
.main h1{
  font-family: 'Kaisei Tokumin', serif;
  font-size: 1.5em;
  font-size: 420%;
}
.main h4{
  font-family: 'Kaisei Tokumin', serif;
  margin-left: 60px;
}
.main h3{
  margin-left: 60px;
  opacity: 0.8;
}
a {
  text-decoration: none;
}

@media only screen and (max-width:550px) {
  .main h1{
    font-size: 320%;
  }
  .main h4{
    margin-left: 15px;
    font-size: 80%;
  }
  .main h3{
    margin-left: 15px;
    font-size: 90%;
  }
}
</style>