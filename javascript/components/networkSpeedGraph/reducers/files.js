import {
  LOAD_SUCCESS
} from '../actions/files';

const defaultState = {
  status: 'notLoaded',
  data: []
};

export default function (state = defaultState, action) {
  switch (action.type) {
  case LOAD_SUCCESS:
    return Object.assign({}, state, { data: action.data, status: 'ok' });
  default:
    return state;
  }
}
