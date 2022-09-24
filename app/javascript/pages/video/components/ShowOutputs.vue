<template>
  <div>
    <v-col
      cols="12"
      class="d-flex"
    >
      <span class="text-h5 font-weight-bold">{{ output.user.name }}さんのアウトプット投稿</span>
      <v-spacer />
      <template v-if="isAuthUserLike(output)">
        <v-btn
        class="font-weight-bold"
        color="primary"
        rounded
        @click="unlike(output)"
      >
        <v-icon
          medium
          left
          dark
        >
          mdi-thumb-up
        </v-icon>
        参考になった {{  }}
      </v-btn>
      </template>
      <template v-else>
      <v-btn
        class="font-weight-bold"
        rounded
        outlined
        color="primary"
        @click="like(output)"
      >
        <v-icon
          medium
          left
          dark
        >
          mdi-thumb-up-outline
        </v-icon>
        参考になった {{  }}
      </v-btn>
      </template>
      <template v-if="isAuthUserOutput(output)">
        <v-icon
          large
          right
          color="green"
          class=""
          @click="handleShowEditModal(output)"
        >
          mdi-square-edit-outline
        </v-icon>
        <v-icon
          large
          right
          color="red"
          class=""
          @click="handleDeleteOutput(output)"
        >
          mdi-trash-can-outline
        </v-icon>
      </template>
    </v-col>
    <v-card-subtitle class="pt-0 pb-0">
      投稿日{{ output.created_at }}
    </v-card-subtitle>
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

    <!-- モーダルコンポーネント -->
    <v-dialog
      v-if="isVisibleEditModal"
      v-model="isVisibleEditModal"
      max-width="800"
    >
      <EditModal
        :youtube-id="videos[0].youtube_id"
        :output="outputEdit"
        @close-modal="handleCloseEditModal"
        @update-output="handleUpdateOutput"
      />
    </v-dialog>
  </div>
</template>

<script>
import EditModal from "./EditModal"
import { mapActions, mapGetters } from "vuex"
export default {
  name: "ShowOutputs",
  components: {
    EditModal,
  },
  props: {
    videos: {
      type: Array,
      default: null
    },
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
      outputEdit: {},
      outputId: '',
      isVisibleEditModal: false,
    }
  },
  computed: {
  ...mapGetters("likes", ["likes"]),
  },
  created () {
    this.fetchmyLikes();
  },
  methods: {
    ...mapActions("outputs", [
      "updateOutput",
      "deleteOutput",
    ]),
    ...mapActions("likes", ["fetchmyLikes", "createLike", "deleteLike"]),
    ...mapActions("flashMessage", ["showMessage"]),
    handleShowEditModal(output) {
      this.isVisibleEditModal = true;
      this.outputEdit = Object.assign({}, output)
    },
    handleCloseEditModal() {
      this.isVisibleEditModal = false;
      this.outputEdit = {};
    },
    isAuthUserOutput(output) {
      if (this.authUser) {
          return this.authUser.id === output.user.id
        }
    },
    async handleUpdateOutput(output) {
      try {
        await this.updateOutput(output);
        this.handleCloseEditModal();
        this.showMessage(
      {
        message: "投稿を編集しました",
        type: "light-blue",
        status: true,
      },
    )
      } catch (error) {
        this.showMessage(
      {
        message: "投稿の編集に失敗しました",
        type: "error",
        status: true,
      },
    )
        console.log(error);
      }
    },
    async handleDeleteOutput(output) {
      try {
        await this.deleteOutput(output);
      } catch (error) {
        this.showMessage(
      {
        message: "投稿を削除しました",
        type: "warning",
        status: true,
      },
    )
        console.log(error);
      }
    },
    like(output){
      this.createLike(output)
    },
    unlike(output){
      this.deleteLike(output)
    },
    isAuthUserLike(output) {
      return this.likes.some(v => v.id === output.id)
    }
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
.content {
  white-space: pre-line;
}
</style>