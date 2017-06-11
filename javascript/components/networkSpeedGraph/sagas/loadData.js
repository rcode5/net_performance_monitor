// load data saga
import { take, put, call } from 'redux-saga/effects';
import api from '../api';
import { LOAD, loadSuccess, loadError } from '../actions/files';

export default function* () {
  while (true) {
    yield take(LOAD);
    try {
      const response = yield call(api.index);
      yield put(loadSuccess(response.data));
    } catch (error) {
      yield put(loadError([]));
    }
  }
}
