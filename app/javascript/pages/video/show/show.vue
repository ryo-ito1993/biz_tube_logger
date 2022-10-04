<template>
  <v-container>
    <v-card
      class="pa-5 top-frame"
      tile
    >
      <!-- video表示部分 -->
      <ShowVideo
        :videos="videos"
      />

      <!-- アウトプット投稿一覧 -->
      <v-card
        v-for="output in outputs"
        :key="'output' + output.id"
        class="frame pa-4 mt-3 shades"
        elevation="20"
        tile
      >
        <ShowOutputs
          :output="output"
          :videos="videos"
          :auth-user="authUser"
        />

        <!-- コメント一覧 -->
        <ShowOutputsComments
          :output="output"
          :auth-user="authUser"
        />
      </v-card>

      <!-- アウトプット投稿ボタン -->
      <v-btn
        v-if="authUser"
        class="primary font-weight-bold mt-4"
        @click="handleShowCreateModal"
      >
        この動画をアウトプットする
      </v-btn>
    </v-card>

    <!-- モーダルコンポーネント -->
    <v-dialog
      v-if="isVisibleCreateModal"
      v-model="isVisibleCreateModal"
      max-width="800"
    >
      <OutputCreateModal
        :youtube-id="videos[0].youtube_id"
        :video-id="id"
        @close-modal="handleCloseCreateModal"
        @create-output="handleCreateOutput"
      />
    </v-dialog>
  </v-container>
</template>

<script>
import OutputCreateModal from "./components/OutputCreateModal.vue"
import ShowVideo from "./components/ShowVideo.vue"
import ShowOutputs from "./components/ShowOutputs.vue"
import ShowOutputsComments from "./components/ShowOutputsComments.vue"
import { mapGetters, mapActions } from "vuex"
export default {
  name: "VideoShow",
  components: {
    OutputCreateModal,
    ShowVideo,
    ShowOutputs,
    ShowOutputsComments
  },
  props: {
    id:{
      type: String,
      required: true
    }
  } ,
  data() {
    return {
      videos: null,
      outputId: '',
      isVisibleCreateModal: false
    }
  },
  computed: {
  ...mapGetters("users", ["authUser"]),
  ...mapGetters("outputs", ["outputs"])
  },
  created: function () {
    this.fetchVideoDetail();
    this.fetchOutputs(this.id);
  },
  methods: {
    ...mapActions("outputs", [
      "fetchOutputs",
      "createOutput",
    ]),
    ...mapActions("flashMessage", ["showMessage"]),
    fetchVideoDetail() {
      this.$axios.get("/videos/" + this.id)
        .then(res => this.videos = res.data)
        .catch(err => console.log(err.status));
    },
    handleShowCreateModal() {
      this.isVisibleCreateModal = true;
    },
    handleCloseCreateModal() {
      this.isVisibleCreateModal = false;
      this.output = {};
    },
    async handleCreateOutput(output) {
      try {
        await this.createOutput(output)
        this.handleCloseCreateModal()
        this.showMessage(
      {
        message: "投稿しました",
        type: "light-blue",
        status: true,
      },
    )
      } catch (error) {
        this.showMessage(
      {
        message: "投稿に失敗しました",
        type: "error",
        status: true,
      },
    )
        console.log(error)
      }
  }

}
}
</script>

<style scoped>
.top-frame{
  background-image: linear-gradient(180deg, #E9E9E7 2%, #EFEEEC 27%, #EEEEEC 58%, #D5D4D0 94%);
}
</style>
