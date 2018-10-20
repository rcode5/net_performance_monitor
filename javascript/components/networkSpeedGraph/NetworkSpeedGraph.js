import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import { pick } from 'lodash';

import { load as loadFiles } from './actions/files';
import Graph from './components/Graph';

class NetworkSpeedGraph extends Component {

  componentWillMount() {
    this.props.loadFiles();
  }

  render() {
    const { files, file } = this.props;

    if ((files.status == 'loading') || (file.status !== "ok")) {
      return <div className='loader'></div>;
    }
    const graphData = pick(file.data, files.data)
    if ( graphData && Object.keys(graphData).length ) {
      return (<div className='graphs'>
              <Graph data={graphData} parameter='ping' />
              <Graph data={graphData} parameter='upload' />
              <Graph data={graphData} parameter='download' />
              <Graph data={graphData} parameter='bytes_sent' />
              </div>
             );
    }
    return null;

  }

}

NetworkSpeedGraph.propTypes = {
  loadFiles: PropTypes.func.isRequired,
  files: PropTypes.object,
  file: PropTypes.object
};

const mapStateToProps = state => ({
  files: state.files,
  file: state.file
});

const mapDispatchToProps = dispatch => bindActionCreators({ loadFiles }, dispatch);

const connectedComponent = connect(mapStateToProps, mapDispatchToProps)(NetworkSpeedGraph);

export { NetworkSpeedGraph as NetworkSpeedGraphComponent }
export default connectedComponent
