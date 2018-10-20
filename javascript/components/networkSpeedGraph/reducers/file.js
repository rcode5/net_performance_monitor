import { isObject } from 'lodash';
import {
  LOAD,
  LOAD_SUCCESS,
  ALL_FILES_LOADED,
} from '../actions/file';

const defaultState = {
  status: 'notLoaded',
  data: {}
};

const isInvalid = (action) => !((action.filename && action.filename.length) && isObject(action.data))

export default function (state = defaultState, action) {
  switch (action.type) {
  case LOAD:
    return Object.assign({}, state, { data: [], status: "loading"})

  case LOAD_SUCCESS:
    if ( isInvalid(action) ) return state;
    const newData = Object.assign({}, state.data, {[action.filename]:action.data});
    return Object.assign({}, state, { data: newData });
  case ALL_FILES_LOADED:
    return Object.assign({}, state, { status: 'ok' });
    return state;
  default:
    return state;
  }
}
