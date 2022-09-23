<template>
  <div>
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
    <v-dialog
      v-if="isVisibleCommentModal"
      v-model="isVisibleCommentModal"
      max-width="500"
    >
      <!-- モーダルコンポーネント -->
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
  </div>
</template>

<script>
import { mapActions } from "vuex"
import CommentCreateModal from "./comments/CommentCreateModal.vue"
import CommentEditModal from "./comments/CommentEditModal.vue"
export default {
  name: "ShowOutputsComments",
  components: {
    CommentCreateModal,
    CommentEditModal
  },
  props: {
    output: {
      type:Object,
      required: true,
    },
    authUser: {
      type: Object,
      required: true
    }
  },
  data() {
    return {
      commentEdit: {},
      outputId: '',
      isVisibleCommentModal: false,
      isVisibleCommentEditModal: false,
    }
  },
  methods: {
    ...mapActions("outputs", [
      "createComment",
      "deleteComment",
      "updateComment"
    ]),
    ...mapActions("flashMessage", ["showMessage"]),
    isAuthUserComment(comment) {
      if (this.authUser) {
          return this.authUser.id === comment.user.id
        }
    },
    async handleCreateComment(comment) {
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
.wrap-box {
  position: relative;
}
.wrap-box .box-right {
  position: absolute;
  right: 0;
}
</style>