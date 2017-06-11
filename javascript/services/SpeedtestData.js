// handle converting raw speedtest data into good stuff for a graph
//
// input should look like:
// {
//   bytes_received: 2307040,
//   bytes_sent: 9543680,
//   download: 1050406.4677215228
//   ping: 20.648
//   server: { ...server info}
//   share: null
//   timestamp: "2017-06-04T02:30:01.038578Z"
//   upload: 7434629.123086754
// }
import moment from 'moment';
import { has, pick, isUndefined } from 'lodash';

const DEFAULT_ATTRS = {
  upload_title: 'Upload in MB/s',
  download_title: 'Download MB/s',
  ping_title: 'Ping (ms)',
  bytes_sent_title: 'Bytes Sent (MB)',
  bytes_received_title: 'Bytes Rcvd (MB)'
}

const inMB = (val) => val / 1000000.0;

const FIELD_CONVERTERS = {
  timestamp: (value) => moment(value).format('X'),
  upload: inMB,
  download: inMB,
  bytes_sent: inMB,
  bytes_received: inMB
}

const convertFields = (info) => {
  const result = {};
  Object.entries(FIELD_CONVERTERS).forEach( ([key,converter]) => {
    const originalValue = info[key];
    if (isUndefined(originalValue)) return;
    result[key] = converter(originalValue);
  })
  return result;
}

export const isValid = (info) => has(info, 'timestamp')

export const present = (info) => {
  return Object.assign({}, DEFAULT_ATTRS, info, convertFields(info));
}
