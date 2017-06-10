// actions
export const LOAD = 'networkData/LOAD';
export const LOAD_ERROR = 'networkData/LOAD_ERROR';
export const LOAD_SUCCESS = 'networkData/LOAD_SUCCESS';

export const load = () => ({type: LOAD});
export const loadSuccess = (data) => ({type: LOAD_SUCCESS, data});
export const loadError = (data) => ({type: LOAD_ERROR, data});
