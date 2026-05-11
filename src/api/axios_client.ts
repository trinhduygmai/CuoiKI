import axios from 'axios';

const axiosClient = axios.create({
  baseURL: 'https://api.example.com/v1', // Replace with your real API URL
  headers: {
    'Content-Type': 'application/json',
  },
});

// Request Interceptor
axiosClient.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem('token');
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

// Response Interceptor
axiosClient.interceptors.response.use(
  (response) => {
    return response.data;
  },
  (error) => {
    // Handle global errors here (e.g., 401 unauthorized)
    return Promise.reject(error);
  }
);

export default axiosClient;
