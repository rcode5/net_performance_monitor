import React from 'react';
import { render } from 'react-dom';
import Header from '../header/Header';
import NetworkSpeedGraph from '../networkSpeedGraph/NetworkSpeedGraph';

const App = (_props) => (
  <div className='application'>
    <Header />
    <div className="main-container">
      <div className="main wrapper clearfix">
        <NetworkSpeedGraph />
      </div>
    </div>
  </div>
);


export default App;
