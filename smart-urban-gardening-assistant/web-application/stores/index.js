import { createStore } from 'vuex'

export default createStore({
  state: {
    auth: {
      user: null
    }
  },
  mutations: {
    setUser(state, user) {
      state.auth.user = user
    }
  },
  getters: {
    getUser: state => state.auth.user,
    isUserLoggedIn: state => !!state.auth.user,
    loggedInUserId: state => state.auth.user?.id
  }
})
