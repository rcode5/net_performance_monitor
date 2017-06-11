import React from 'react';
import { render } from 'react-dom';
import Header from '../header';
import NetworkSpeedGraph from '../networkSpeedGraph';
const App = (_props) => (
  <div className='application'>
    <Header />
    <div className="main-container">
      <div className="main wrapper clearfix">
        <article>
          Data
         </article>
        <NetworkSpeedGraph />
      </div>
    </div>
  </div>
);


export default App;
