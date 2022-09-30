<template>
  <div>
    <v-row>
      <v-col
        md="2"
        xs="12"
      >
        <v-container class="ml-4 mt-4">
          <v-card
            class="pt-1 pb-1"
            color="grey lighten-3"
            elevation="3"
          >
            <v-card-subtitle class="mt-2 ml-3">
              CATEGORY
            </v-card-subtitle>
            <div class="mb-5 ml-3 mt-2">
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
          </v-card>
        </v-container>
      </v-col>
      <v-col cols="10">
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
                :videos="videos"
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
import VideoItem from "./components/VideoItem.vue"
export default {
  name: "VideoIndex",
    components: {
    VideoItem,
  },
  data() {
    return {
      videos: [],
      categories: [],
      categorysearchlists: [],
      keyword: '',
      tab: null
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
  },
  methods: {
    fetchVideos() {
      this.$axios.get("videos")
        .then(res => this.videos = res.data)
        .catch(err => console.log(err.status));
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
    }
  }
}
</script>

<style scoped>

</style>