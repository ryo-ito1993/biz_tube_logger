import axios from '../../plugins/axios'

const state = {
  bookmarks: [],
}

const getters =  {
  bookmarks: state => state.bookmarks,
}

const mutations = {
  setBookmarks: (state, bookmarks) => { state.bookmarks = bookmarks},
  addBookmark: (state, bookmark) => { state.bookmarks.push(bookmark)},
  deleteBookmark: (state, deleteBookmark) => {
    state.bookmarks = state.bookmarks.filter(bookmark => {
      return bookmark.id != deleteBookmark.id
    })
  }
}
const actions = {
  fetchmyBookmarks({ commit }) {
    axios.get('bookmarks')
      .then(res => { commit('setBookmarks', res.data) })
      .catch(err => console.log(err.response));
  },
  fetchmyBookmarkList({ commit }) {
    axios.get('bookmarks/bookmark_list')
      .then(res => { commit('setBookmarks', res.data) })
      .catch(err => console.log(err.response));
  },
  createBookmark({ commit }, video) {
    return axios.post('videos/' + video.id + '/bookmarks', video)
    .then(res => { commit('addBookmark', res.data) })
    .catch(err => console.log(err.response));
  },

  deleteBookmark({ commit }, video) {
    return axios.delete('bookmarks/'+video.id)
    .then(res => { commit('deleteBookmark', res.data) })
    .catch(err => console.log(err.response));
  }
}

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions
}