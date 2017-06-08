import React, { Component } from 'react';
import PropTypes from 'prop-types';

class NetworkSpeedGraph extends Component {

  render() (<div>graph goes here {this.props.networkData.data}</div>)

}

EditMember.propTypes = {
  updateMember: PropTypes.func.isRequired,
  cloudinaryConfig: PropTypes.object.isRequired,
  member: PropTypes.object.isRequired,
  countries: PropTypes.array.isRequired,
  token: PropTypes.string.isRequired,
  errors: PropTypes.object.isRequired,
  success: PropTypes.string.isRequired
};

const mapStateToProps = state => ({
  networkData: state.networkData
});

const mapDispatchToProps = dispatch => bindActionCreators({ }, dispatch);

const connectedComponent = connect(mapStateToProps, mapDispatchToProps)(NetworkSpeedGraph);

export { NetworkSpeedGraph as NetworkSpeedGraphComponent }
export default connectedComponent
