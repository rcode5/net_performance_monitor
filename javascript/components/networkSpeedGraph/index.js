import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';

class NetworkSpeedGraph extends Component {

  render() {
    return <div>graph goes here {this.props.networkData.data}</div>;
  }

}

NetworkSpeedGraph.propTypes = {
  networkData: PropTypes.object
};

const mapStateToProps = state => ({
  networkData: state.networkData
});

const mapDispatchToProps = dispatch => bindActionCreators({ }, dispatch);

const connectedComponent = connect(mapStateToProps, mapDispatchToProps)(NetworkSpeedGraph);

export { NetworkSpeedGraph as NetworkSpeedGraphComponent }
export default connectedComponent
