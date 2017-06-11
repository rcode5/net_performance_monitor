// actions
export const LOAD = 'file/LOAD';
export const LOAD_ERROR = 'file/LOAD_ERROR';
export const LOAD_SUCCESS = 'file/LOAD_SUCCESS';

export const load = (filename) => ({type: LOAD, filename});
export const loadSuccess = (data) => ({type: LOAD_SUCCESS, data});
export const loadError = (data) => ({type: LOAD_ERROR, data});
