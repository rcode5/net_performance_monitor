import React, { Component } from 'react';
import PropTypes from 'prop-types';
import moment from 'moment';
import { XYPlot, XAxis, YAxis, HorizontalGridLines, LineMarkSeries } from 'react-vis';

import { present, isValid } from '../../../services/SpeedtestData';

class Graph extends Component {

  extractTitle(data, parameter) {
    let title;
    Object.entries(data).some( ([file, info]) => {
      if (!isValid(info)) return;
      const titleParam = `${parameter}_title`;
      const dataPoint = present(info);
      title = dataPoint[titleParam] || parameter;
    });
    return title;
  }
  extractGraphData(data, parameter) {
    let points = [];
    Object.entries(data).forEach( ([file, info]) => {
      if (!isValid(info)) return;
      const dataPoint = present(info);
      points.push( { x: dataPoint.timestamp, y: dataPoint[parameter] } );
    });
    return points.sort( (a,b) => b.x - a.x );
  }

  formatTimestampForGraph(ts) {
    return moment.unix(ts).format("YYYY-MM-DD");
  }

  render() {
    const { parameter, data } = this.props;

    const graphData = this.extractGraphData(data, parameter);
    const title = this.extractTitle(data, parameter);
    return ( <div className='graph'>
        <XYPlot width={ 800 } height={ 500 }>
          <HorizontalGridLines />
          <LineMarkSeries
            stroke="#ccaa55"
            style={{fill: 'none'}}
      curve={'curve'}
      format={ (pt) => { [ { title: 'T', value: pt.y } ] } }
            data={ graphData }
          />
      <XAxis
      tickFormat={v => this.formatTimestampForGraph(v)} tickLabelAngle={-90}
      />
          <YAxis title={ title } />
        </XYPlot>
      </div>);
  }
}

Graph.propTypes = {
  data: PropTypes.object.isRequired,
  parameter: PropTypes.string.isRequired
};

export default Graph;
