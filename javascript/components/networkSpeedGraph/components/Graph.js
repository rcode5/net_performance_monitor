import React, { Component } from 'react';
import PropTypes from 'prop-types';
import moment from 'moment';
import {
  XYPlot,
  XAxis,
  YAxis,
  HorizontalGridLines,
  LineMarkSeries,
  Crosshair,
  Hint,
  makeWidthFlexible
} from 'react-vis';
import Highlight from './highlight';

import { present, isValid } from '../../../services/SpeedtestData';

const FlexibleXYPlot = makeWidthFlexible(XYPlot);

class Graph extends Component {

  constructor(props) {
    super(props);
    this.state = { lastDrawLocation: null }
  }

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
    return moment.unix(ts).format("YYYY-MM-DD HH:mm");
  }

  resetZoom = () => this.setState({lastDrawLocation: null});

  render() {
    const { parameter, data } = this.props;
    const { lastDrawLocation } = this.state;

    const graphData = this.extractGraphData(data, parameter);
    const title = this.extractTitle(data, parameter);

    console.log(graphData);

    return ( <div className='graph'>
      <FlexibleXYPlot
      animation
      margin={{bottom: 130}}
      xDomain={ lastDrawLocation && [ lastDrawLocation.left, lastDrawLocation.right ] }
        height={ 500 }>
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
      <Highlight onBrushEnd={(area) => {
        this.setState({
          lastDrawLocation: area
        });
      }} />
      </FlexibleXYPlot>

      <button
        className="button -dark"
        disabled={Boolean(lastDrawLocation===null)}
        onClick={this.resetZoom}
      >
      Reset Zoom
      </button>
      </div>);
  }
}

Graph.propTypes = {
  data: PropTypes.object.isRequired,
  parameter: PropTypes.string.isRequired
};

export default Graph;
