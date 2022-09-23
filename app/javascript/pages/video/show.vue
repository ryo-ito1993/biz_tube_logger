<template>
  <v-container>
    <v-card class="pa-5 top-frame">
      <!-- video -->
      <ShowVideo
        :videos="videos"
      />

      <!-- アウトプット投稿一覧 -->
      <v-card
        v-for="output in outputs"
        :key="'output' + output.id"
        class="frame pa-4 mt-3 shades rounded-lg"
      >
        <ShowOutputs
        :output="output"
        :videos="videos"
        :authUser="authUser"
        />

        <!-- コメント一覧 -->
        <div v-if="output.comments && output.comments.length">
          <div class="font-weight-bold">
            <v-icon class="pr-2">
              mdi-comment-processing-outline
            </v-icon>コメント一覧
          </div>
          <v-container
            v-for="comment in output.comments"
            :key="'comment' + comment.id"
          >
            <v-divider />

            <div class="wrap-box">
              <v-icon>mdi-account</v-icon>
              <span class="font-weight-bold">{{ comment.user.name }}</span>
              <template v-if="isAuthUserComment(comment)">
                <v-icon
                  right
                  color="green"
                  class="mr-10 box-right"
                  @click="handleShowCommentEditModal(comment)"
                >
                  mdi-square-edit-outline
                </v-icon>
                <v-icon
                  right
                  color="red"
                  class="box-right"
                  @click="handleDeleteComment(comment)"
                >
                  mdi-trash-can-outline
                </v-icon>
              </template>
            </div>
            <div>
              {{ comment.body }}
            </div>
          </v-container>
        </div>
        <v-btn
          class="mr-4 font-weight-bold"
          type="submit"
          color="success"
          @click="handleShowCommentModal(output.id)"
        >
          コメントする
        </v-btn>
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
    <v-dialog
      v-if="isVisibleCommentModal"
      v-model="isVisibleCommentModal"
      max-width="500"
    >
      <CommentCreateModal
        :output-id="outputId"
        @close-modal="handleCloseCommentModal"
        @create-comment="handleCreateComment"
      />
    </v-dialog>
    <v-dialog
      v-if="isVisibleCommentEditModal"
      v-model="isVisibleCommentEditModal"
      max-width="500"
    >
      <CommentEditModal
        :comment="commentEdit"
        @close-modal="handleCloseCommentEditModal"
        @update-comment="handleUpdateComment"
      />
    </v-dialog>
  </v-container>
</template>

<script>
import OutputCreateModal from "./components/OutputCreateModal.vue"
import CommentCreateModal from "./components/comments/CommentCreateModal.vue"
import CommentEditModal from "./components/comments/CommentEditModal.vue"
import ShowVideo from "./components/ShowVideo.vue"
import ShowOutputs from "./components/ShowOutputs.vue"
import { mapGetters, mapActions } from "vuex"
export default {
  name: "VideoShow",
  components: {
    OutputCreateModal,
    CommentCreateModal,
    CommentEditModal,
    ShowVideo,
    ShowOutputs
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
      outputEdit: {},
      commentEdit: {},
      outputId: '',
      isVisibleEditModal: false,
      isVisibleCreateModal: false,
      isVisibleCommentModal: false,
      isVisibleCommentEditModal: false,
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
      "createOutput",
      "createComment",
      "deleteComment",
      "updateComment"
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
    isAuthUserComment(comment) {
      if (this.authUser) {
          return this.authUser.id === comment.user.id
        }
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
  },async handleCreateComment(comment) {
      try {
        await this.createComment(comment)
        this.handleCloseCommentModal()
        this.showMessage(
      {
        message: "コメントを投稿しました",
        type: "light-blue",
        status: true,
      },
    )
      } catch (error) {
        this.showMessage(
      {
        message: "コメントの投稿に失敗しました",
        type: "error",
        status: true,
      },
    )
        console.log(error)
      }
  },
  async handleDeleteComment(comment) {
      try {
        await this.deleteComment(comment);
        this.showMessage(
      {
        message: "コメントを削除しました",
        type: "warning",
        status: true,
      },
    )
      } catch (error) {
        console.log(error);
      }
    },
    async handleUpdateComment(comment) {
      try {
        await this.updateComment(comment);
        this.handleCloseCommentEditModal();
        this.showMessage(
      {
        message: "コメントを編集しました",
        type: "light-blue",
        status: true,
      },
    )
      } catch (error) {
        this.showMessage(
      {
        message: "コメントの編集に失敗しました",
        type: "error",
        status: true,
      },
    )
        console.log(error);
      }
    },
  handleShowCommentModal(outputId) {
      this.isVisibleCommentModal = true;
      this.outputId = outputId
    },
  handleCloseCommentModal() {
      this.isVisibleCommentModal = false;
      this.comment = {};
    },
    handleShowCommentEditModal(comment) {
      this.isVisibleCommentEditModal = true;
      this.commentEdit = Object.assign({}, comment)
    },
    handleCloseCommentEditModal() {
      this.isVisibleCommentEditModal = false;
      this.commentEdit = {};
    },
}
}
</script>

<style scoped>
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
.wrap-box {
  position: relative;
}
.wrap-box .box-right {
  position: absolute;
  right: 0;
}
.content {
  white-space: pre-line;
}
</style>
