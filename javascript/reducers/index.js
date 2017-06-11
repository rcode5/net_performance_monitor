import { combineReducers } from 'redux';
import files from '../components/networkSpeedGraph/reducers/files';
import file from '../components/networkSpeedGraph/reducers/file';

export default combineReducers({
  files,
  file
});
