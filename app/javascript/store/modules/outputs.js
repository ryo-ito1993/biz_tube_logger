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
        const video = res.data[0]
        if ('title' in video) {
          router.push({ name: 'VideoIndex' });
        }
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