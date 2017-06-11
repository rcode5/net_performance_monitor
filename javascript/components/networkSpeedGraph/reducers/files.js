import {
  LOAD_SUCCESS
} from '../actions/files';

const defaultState = {
  data: []
};

export default function (state = defaultState, action) {
  switch (action.type) {
  case LOAD_SUCCESS:
    return Object.assign({}, state, { data: action.data });
  default:
    return state;
  }
}
