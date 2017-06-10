// load data saga
import { take, put, call } from 'redux-saga/effects';
import api from '../api';
import { LOAD, loadSuccess, loadError } from '../actions';

export default function* () {
  while (true) {
    yield take(LOAD);
    try {
      const response = yield call(api.load);

      const hash = response.data.reduce((memo, member) => Object.assign(memo, { [member.id]: member }), {});
      yield put(loadSuccess(hash));
    } catch (error) {
      yield put(loadError(error.response.data.errors));
    }
  }
}
