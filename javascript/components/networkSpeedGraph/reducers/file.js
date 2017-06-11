import { isObject } from 'lodash';
import {
  LOAD_SUCCESS
} from '../actions/file';

const defaultState = {
  data: {}
};

const isInvalid = (action) => !((action.filename && action.filename.length) && isObject(action.data))

export default function (state = defaultState, action) {
  switch (action.type) {
  case LOAD_SUCCESS:
    if ( isInvalid(action) ) return state;

    const newData = Object.assign( {}, state.data, {[action.filename]:action.data});
    return Object.assign({}, state, { data: newData });
  default:
    return state;
  }
}
