import axios from '../../plugins/axios'

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

}

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions
}