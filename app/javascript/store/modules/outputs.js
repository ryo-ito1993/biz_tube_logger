import axios from '../../plugins/axios'
import router from '../../router'


const state = {
  outputs: []
}

const getters =  {
  outputs: state => state.outputs
}

const mutations = {
  setOutputs: (state, outputs) => {
    state.outputs = outputs
  },
  updateOutput: (state, updateOutput) => {
    const index = state.outputs.findIndex(output => {
      return output.id == updateOutput.id
    })
    state.outputs.splice(index, 1, updateOutput)
  },
  deleteOutput: (state, deleteOutput) => {
    state.outputs = state.outputs.filter(output => {
      return output.id != deleteOutput.id
    })
  },
  addOutput: (state, output) => {
    state.outputs.push(output)
  }

}

const actions = {
  fetchOutputs({ commit }, id) {
    axios.get('outputs/' + id)
      .then(res => {
        commit('setOutputs', res.data)
      })
      .catch(err => console.log(err.response));
  },
  updateOutput({commit}, output) {
    return axios.patch('outputs/' + output.id , output)
      .then(res => {
        commit('updateOutput', res.data)
      })
  },
  deleteOutput({commit}, output) {
    return axios.delete('outputs/' + output.id)
      .then(res => {
        commit('deleteOutput', res.data)
        console.log(res.data)
        if (res.data[0] && 'title' in res.data[0]) {
          router.push({ name: 'VideoIndex' })
          dispatch(
            "flashMessage/showMessage",
            {
              message: "投稿を削除しました。",
              type: "warning",
              status: true,
            },
            { root: true }
          )
        }
      })
  },
  createOutput({ commit }, output) {
    return axios.post('outputs', output)
      .then(res => {
        commit('addOutput', res.data)
      })
    },
    createComment({ commit }, comment) {
      return axios.post('comments', comment)
        .then(res => {
          console.log(res.data)
          commit('updateOutput', res.data)
        })
    },
    deleteComment({commit}, comment) {
      return axios.delete('comments/' + comment.id)
        .then(res => {
          commit('updateOutput', res.data)
          console.log(res.data)
        })
    },
    updateComment({commit}, comment) {
      return axios.patch('comments/' + comment.id , comment)
        .then(res => {
          commit('updateOutput', res.data)
        })
    },
    createLike({ commit }, output) {
      return axios.post('outputs/' + output.id + '/likes', output)
        .then(res => {
          console.log(res.data)
          commit('updateOutput', res.data)
        })
    },
    deleteLike({commit}, output) {
      return axios.delete('likes/'+output.id)
        .then(res => {
          commit('updateOutput', res.data)
          console.log(res.data)
        })
    },
}

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions
}