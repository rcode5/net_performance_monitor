import React from 'react';
import { render } from 'react-dom';
import NetworkSpeedGraph from './components/networkSpeedGraph/';
const App = (_props) => (
  <div className="main-container">
    <div className="main wrapper clearfix">
      <article>
        Data
       </article>
      <NetworkSpeedGraph />
    </div>
  </div>
);


export default App;
