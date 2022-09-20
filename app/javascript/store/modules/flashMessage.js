const state = () => ({
  // 初期状態を定義
  message: "",
  type: "",
  status: false,
});
const getters = {
  message: (state) => state.message,
  type: (state) => state.type,
  status: (state) => state.status,
};

const mutations = {
  setMessage(state, message) {
    state.message = message;
  },
  setType(state, type) {
    state.type = type;
  },
  setStatus(state, bool) {
    state.status = bool;
  },
};

const actions = {
  showMessage({ commit }, { message, type, status }) {
    commit("setMessage", message);
    commit("setType", type);
    commit("setStatus", status);
    setTimeout(() => {
      commit("setStatus", !status);
    }, 3000);
  },
};

export default {
  namespaced: true,
  getters,
  state,
  mutations,
  actions,
};