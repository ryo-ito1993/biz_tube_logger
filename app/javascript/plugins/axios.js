import axios from 'axios'

let baseUrl ;
if ( process.env.NODE_ENV == 'production' ) {
  baseUrl = 'https://www.biztube-logger.com/api'
} else {
  baseUrl = 'http://localhost:3000/api/'
}

const axiosInstance = axios.create({
  baseURL: baseUrl
})


if (localStorage.auth_token) {
  axiosInstance.defaults.headers.common['Authorization'] = `Bearer ${localStorage.auth_token}`
}

export default axiosInstance