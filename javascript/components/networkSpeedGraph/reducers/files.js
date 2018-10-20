import {
  LOAD,
  LOAD_ERROR,
  LOAD_SUCCESS
} from '../actions/files';

const defaultState = {
  status: 'notLoaded',
  data: []
};

export default function (state = defaultState, action) {
  switch (action.type) {
  case LOAD:
    return Object.assign({}, state, { data: [], status: "loading"})
  case LOAD_SUCCESS:
    return Object.assign({}, state, { data: action.data, status: 'ok' });
  case LOAD_ERROR:
    return Object.assign({}, state, defaultState);
  default:
    return state;
  }
}
