import { createStore, applyMiddleware } from 'redux';
import createSagaMiddleware from 'redux-saga';
import sagas from '../sagas';
import reducers from '../reducers';

export default function configureStore(initialState) {
  const sagaMiddleware = createSagaMiddleware();
  const middlewares = [sagaMiddleware];

  const { createLogger } = require('redux-logger');
  middlewares.push(createLogger());

  const store = createStore(
    reducers,
    initialState,
    applyMiddleware(...middlewares)
  );

  Object.keys(sagas).forEach((key) => {
    sagaMiddleware.run(sagas[key]);
  });

  return store;
}
