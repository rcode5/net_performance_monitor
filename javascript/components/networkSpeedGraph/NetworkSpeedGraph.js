import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';

import { load as loadFiles } from './actions/files';

class NetworkSpeedGraph extends Component {

  componentWillMount() {
    this.props.loadFiles();
  }

  render() {
    const { files } = this.props;

    if (files.status !== 'ok') {
      return <div className='loader'></div>;
    }

    return <ul>{ files.data.map( file => <li key={file}>{file}</li> ) }</ul>
  }

}

NetworkSpeedGraph.propTypes = {
  loadFiles: PropTypes.func.isRequired,
  files: PropTypes.object
};

const mapStateToProps = state => ({
  files: state.files
});

const mapDispatchToProps = dispatch => bindActionCreators({ loadFiles }, dispatch);

const connectedComponent = connect(mapStateToProps, mapDispatchToProps)(NetworkSpeedGraph);

export { NetworkSpeedGraph as NetworkSpeedGraphComponent }
export default connectedComponent
