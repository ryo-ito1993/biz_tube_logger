import axios from '../../plugins/axios'

const state = {
  likes: [],
}

const getters =  {
  likes: state => state.likes,
}

const mutations = {
  setLikes: (state, likes) => { state.likes = likes},
  addLike: (state, like) => { state.likes.push(like)},
  deleteLike: (state, deleteLike) => {
    state.likes = state.likes.filter(like => {
      return like.id != deleteLike.id
    })
  }
}
const actions = {
  fetchmyLikes({ commit }) {
    axios.get('likes')
      .then(res => { commit('setLikes', res.data) })
      .catch(err => console.log(err.response));
  },
  createLike({ commit }, output) {
    return axios.post('outputs/' + output.id + '/likes', output)
    .then(res => { commit('addLike', res.data) })
    .catch(err => console.log(err.response));
  },

  deleteLike({ commit }, output) {
    return axios.delete('likes/'+output.id)
    .then(res => { commit('deleteLike', res.data) })
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