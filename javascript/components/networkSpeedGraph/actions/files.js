// actions
export const LOAD = 'files/LOAD';
export const LOAD_ERROR = 'files/LOAD_ERROR';
export const LOAD_SUCCESS = 'files/LOAD_SUCCESS';

export const load = () => ({type: LOAD});
export const loadSuccess = (data) => ({type: LOAD_SUCCESS, data});
export const loadError = (data) => ({type: LOAD_ERROR, data});
