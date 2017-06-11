// load data saga
import { take, takeEvery, put, call, fork, race, cancel } from 'redux-saga/effects';
import api from '../api';
import { LOAD_SUCCESS } from '../actions/files';
import { LOAD_SUCCESS as LOAD_FILE_SUCCESS,
         LOAD_ERROR as LOAD_FILE_ERROR,
         loadError as loadFileError,
         loadSuccess as loadFileSuccess,
         allFilesLoaded
       } from '../actions/file';


function *fetchFile(file) {
  try {
    const response = yield call(api.show, file);
    yield put(loadFileSuccess(file, response.data));
  } catch (error) {
    yield put(loadFileError({}));
  }
}

function *safeFetchFile(file) {
  const task = yield fork(fetchFile, file);
  const resp = yield race({
    success: take(LOAD_FILE_SUCCESS),
    error: take(LOAD_FILE_ERROR),
  })

  if(resp.error) {
    yield cancel(task)
  }
}

export default function* () {
  while(true) {
    const action = yield take(LOAD_SUCCESS);
    yield action.data.map( file => call(safeFetchFile, file) )
    yield put(allFilesLoaded());
  }
}
