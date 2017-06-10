import axios from 'axios';

const JSON_HEADERS = {
  'X-Requested-With': 'XMLHttpRequest',
  'Content-Type': 'application/json'
};
function request(url, method, data = {}) {
  return axios({
    method,
    url,
    headers: Object.assign({}, JSON_HEADERS),
    data
  });
}

export const get = (url, data) => (
  axios.get(url, {
    params: data,
    headers: JSON_HEADERS
  })
);

export const post = (url, data) => request(url, 'post',  data);

export const put = (url, data) => request(url, 'put',  data);

export const patch = (url, data) => request(url, 'patch',  data);

export const destroy = (url) => request(url, 'delete');
