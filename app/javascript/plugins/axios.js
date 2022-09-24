import axios from 'axios'

const axiosInstance = axios.create({
  baseURL: `${process.env.VUE_APP_API_ORIGIN}/api/`
})

if (localStorage.auth_token) {
  axiosInstance.defaults.headers.common['Authorization'] = `Bearer ${localStorage.auth_token}`
}

export default axiosInstance