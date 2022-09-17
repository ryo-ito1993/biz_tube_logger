<template>
  <v-container>
    <v-card class="pa-5 top-frame">
      <div
        v-for="video in video"
        :key="'video' + video.id"
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
        <div class=" pt-5 title text-h5 font-weight-bold">
          {{ video.title }}
        </div>
        <div class="ml-5 pt-2">
          <span class="count">再生回数:{{ video.view_count }}回</span>
        </div>
      </div>
      <v-card
        v-for="output in outputs"
        :key="'output' + output.id"
        class="frame pa-4 mt-3 shades rounded-lg"
      >
        <div class="title-box">
          <span class="text-h5 font-weight-bold">{{ output.user.name }}さんのアウトプット投稿</span>
          <template v-if="isAuthUserTask(output)">
            <v-icon
              large
              right
              color="green"
              class="mr-10 box-right"
              @click="handleShowEditModal(output)"
            >
              mdi-square-edit-outline
            </v-icon>
            <v-icon
              large
              right
              color="red"
              class="box-right"
              @click="handleDeleteOutput(output)"
            >
              mdi-trash-can-outline
            </v-icon>
          </template>
        </div>

        <v-card-subtitle>投稿日{{ output.created_at }}</v-card-subtitle>
        <v-card class="box">
          <span class="box-title">動画内容のアウトプット</span>
          <pre class="content">
            {{ output.summary }}
          </pre>
        </v-card>
        <v-card class="box">
          <span class="box-title">感想や今後に活かすこと</span>
          <pre class="content">
            {{ output.impression }}
          </pre>
        </v-card>
      </v-card>
      <v-btn
        class="primary font-weight-bold mt-4"
        @click="handleShowCreateModal"
      >
        この動画をアウトプットする
      </v-btn>
    </v-card>
    <v-dialog
      v-if="isVisibleEditModal"
      v-model="isVisibleEditModal"
      max-width="800"
    >
      <EditModal
        :youtube-id="video[0].youtube_id"
        :output="outputEdit"
        @close-modal="handleCloseEditModal"
        @update-output="handleUpdateOutput"
      />
    </v-dialog>
    <v-dialog
      v-if="isVisibleCreateModal"
      v-model="isVisibleCreateModal"
      max-width="800"
    >
      <OutputCreateModal
        :youtube-id="video[0].youtube_id"
        :video-id="id"
        @close-modal="handleCloseCreateModal"
        @create-output="handleCreateOutput"
      />
    </v-dialog>
  </v-container>
</template>

<script>
import EditModal from "./components/EditModal"
import OutputCreateModal from "./components/OutputCreateModal.vue"
import { mapGetters, mapActions } from "vuex"
export default {
  name: "VideoShow",
  components: {
    EditModal,
    OutputCreateModal
  },
  props: ["id"],
  data() {
    return {
      video: null,
      outputEdit: {},
      isVisibleEditModal: false,
      isVisibleCreateModal: false
    }
  },
  created: function () {
    this.fetchVideoDetail();
    this.fetchOutputs(this.id);
  },
  computed: {
  ...mapGetters("users", ["authUser"]),
  ...mapGetters("outputs", ["outputs"])
  },
  methods: {
    ...mapActions("outputs", [
      "fetchOutputs",
      "updateOutput",
      "deleteOutput",
      "createOutput"
    ]),
    fetchVideoDetail() {
      this.$axios.get("/videos/" + this.id)
        .then(res => this.video = res.data)
        .catch(err => console.log(err.status));
    },
    handleShowEditModal(output) {
      this.isVisibleEditModal = true;
      this.outputEdit = Object.assign({}, output)
    },
    handleCloseEditModal() {
      this.isVisibleEditModal = false;
      this.outputEdit = {};
    },
    handleShowCreateModal() {
      this.isVisibleCreateModal = true;
    },
    handleCloseCreateModal() {
      this.isVisibleCreateModal = false;
      this.output = {};
    },
    isAuthUserTask(output) {
      if (this.authUser) {
          return this.authUser.id === output.user.id
        }
    },
    async handleUpdateOutput(output) {
      try {
        await this.updateOutput(output);
        this.handleCloseEditModal();
      } catch (error) {
        console.log(error);
      }
    },
    async handleDeleteOutput(output) {
      try {
        await this.deleteOutput(output);
      } catch (error) {
        console.log(error);
      }
    },
    async handleCreateOutput(output) {
      try {
        await this.createOutput(output)
        this.handleCloseCreateModal()
      } catch (error) {
        console.log(error)
      }
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
.title-box {
  position: relative;
}
.title-box .box-right {
  position: absolute;
  right: 0;
}
.content {
  white-space: pre-line;
}
</style>
