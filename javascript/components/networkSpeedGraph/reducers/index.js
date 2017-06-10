import {
  LOAD_SUCCESS
} from '../actions';

const defaultState = {
  networkData: { data: [] }
};

export default function (state = defaultState, action) {
  switch (action.type) {
  case LOAD_SUCCESS:
    return Object.assign({}, state, action.data);
  default:
    return state;
  }
}
