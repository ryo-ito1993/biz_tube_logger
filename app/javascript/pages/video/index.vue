<template>
  <div>
    <v-row>
      <v-col
        lg="2"
        xs="12"
      >
        <v-container class="ml-2 mt-4">
          <v-card
            class="pt-1 pb-1"
            color="grey lighten-3"
            elevation="3"
          >
            <v-card-subtitle class="font-weight-bold ml-3">
              CATEGORY
            </v-card-subtitle>
            <div class="mb-5 ml-3">
              <v-btn
                v-for="category in categories"
                :key="category.id"
                class="ml-2 mr-4 mb-1"
                color="primary"
                tile
                width="150"
                @click="categorysearch(category)"
              >
                {{ category.name }}
              </v-btn>
            </div>
          </v-card>
        </v-container>
      </v-col>
      <v-col
        lg="10"
        sm="12"
      >
        <v-tabs
          v-model="tab"
          fixed-tabs
          class="rounded mt-7"
          dark
        >
          <v-tab>
            LIST
          </v-tab>
          <v-tab>
            Category
          </v-tab>
          <v-tab>
            Search
          </v-tab>

          <v-tab-item class="rounded lighten-2 grey">
            <v-container>
              <VideoItem
                :videos="displayVideos"
              />
              <v-pagination
                v-model="page.currentPage"
                :length="page.totalPages"
                @input="changePage"
              />
            </v-container>
          </v-tab-item>

          <v-tab-item class="rounded grey lighten-2">
            <v-container class="pb-10">
              <div class="mt-5 mb-5">
                <v-btn
                  v-for="category in categories"
                  :key="category.id"
                  class="mr-4 mb-1"
                  color="primary"
                  tile
                  @click="categorysearch(category)"
                >
                  {{ category.name }}
                </v-btn>
              </div>
              <VideoItem
                :videos="categorysearchlists"
              />
            </v-container>
          </v-tab-item>

          <v-tab-item class="rounded grey lighten-2">
            <v-container>
              <div class="field">
                <div class="control">
                  <v-text-field
                    v-model="keyword"
                    class="input"
                    type="text"
                    placeholder="Search"
                    solo
                  />
                </div>
              </div>
              <VideoItem
                :videos="searchLists"
              />
            </v-container>
          </v-tab-item>
        </v-tabs>
      </v-col>
    </v-row>
  </div>
</template>


<script>
import goTo from "vuetify/es5/services/goto"
import VideoItem from "./components/VideoItem.vue"
export default {
  name: "VideoIndex",
    components: {
    VideoItem,
  },
  data() {
    return {
      videos: [],
      displayVideos: [],
      categories: [],
      categorysearchlists: [],
      keyword: '',
      tab: null,
      requestUrl: "videos",
        page: {
          currentPage: 1,
          totalPages: 1,
        }
    }
  },
  computed: {
    searchLists: function() {
      var searchlists = [];
      for (var i in this.videos) {
        var video  = this.videos[i];
        if (
          video.title.indexOf(this.keyword) !== -1
        )
        { searchlists.push(video);}
      }
      return searchlists;
    },
  },
    mounted() {
    this.fetchVideos();
    this.fetchCategories();
    this.fetchDisplayVideos();
  },
  methods: {
    async fetchVideos() {
      this.$axios.get('videos')
        .then(res => this.videos = res.data)
        .catch(err => console.log(err.status));
    },
    async fetchDisplayVideos() {
      const res = await this.$axios.get('videos/display_videos')
      this.page.totalPages = Number(res.headers["total-pages"])
      this.displayVideos = res.data
    },
    fetchCategories() {
      this.$axios.get("categories")
        .then(res => this.categories = res.data)
        .catch(err => console.log(err.status));
    },
    categorysearch(searchcategory){
      this.categorysearchlists = []
      for (var i in this.videos) {
        var video  = this.videos[i];
        for (var i in video.categories) {
          var category  = video.categories[i];
          if ( category.name === searchcategory.name)
          { this.categorysearchlists.push(video);}
        }
      }
      this.tab = 1
    },
    async changePage(val) {
      goTo(0)  // ページ最上部までスクロール。Vuetifyのメソッド
      const res = await this.$axios.get(`videos/display_videos/?page=`+ val)
      this.displayVideos = res.data
    }
  }
}
</script>

<style scoped>

</style>