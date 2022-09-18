<template>
  <v-container>
    <v-card class="pa-5 top-frame">

      <!-- video -->
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

      <!-- アウトプット投稿一覧 -->
      <v-card
        v-for="output in outputs"
        :key="'output' + output.id"
        class="frame pa-4 mt-3 shades rounded-lg"
      >
        <div class="wrap-box">
          <span class="text-h5 font-weight-bold">{{ output.user.name }}さんのアウトプット投稿</span>
          <template v-if="isAuthUserOutput(output)">
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
    <v-dialog
      v-if="isVisibleCommentModal"
      v-model="isVisibleCommentModal"
      max-width="500"
    >
      <CommentCreateModal
        :output-id="this.outputId"
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
        :comment="this.commentEdit"
        @close-modal="handleCloseCommentEditModal"
        @update-comment="handleUpdateComment"
      />
    </v-dialog>
  </v-container>
</template>

<script>
import EditModal from "./components/EditModal"
import OutputCreateModal from "./components/OutputCreateModal.vue"
import CommentCreateModal from "./components/comments/CommentCreateModal.vue"
import CommentEditModal from "./components/comments/CommentEditModal.vue"
import { mapGetters, mapActions } from "vuex"
export default {
  name: "VideoShow",
  components: {
    EditModal,
    OutputCreateModal,
    CommentCreateModal,
    CommentEditModal
  },
  props: ["id"],
  data() {
    return {
      video: null,
      outputEdit: {},
      commentEdit: {},
      outputId: '',
      isVisibleEditModal: false,
      isVisibleCreateModal: false,
      isVisibleCommentModal: false,
      isVisibleCommentEditModal: false
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
      "createOutput",
      "createComment",
      "deleteComment",
      "updateComment"
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
    isAuthUserOutput(output) {
      if (this.authUser) {
          return this.authUser.id === output.user.id
        }
    },
    isAuthUserComment(comment) {
      if (this.authUser) {
          return this.authUser.id === comment.user.id
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
  },async handleCreateComment(comment) {
      try {
        await this.createComment(comment)
        this.handleCloseCommentModal()
      } catch (error) {
        console.log(error)
      }
  },
  async handleDeleteComment(comment) {
      try {
        await this.deleteComment(comment);
      } catch (error) {
        console.log(error);
      }
    },
    async handleUpdateComment(comment) {
      try {
        await this.updateComment(comment);
        this.handleCloseCommentEditModal();
      } catch (error) {
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
.category{
  margin-right: 30px;
}
</style>
