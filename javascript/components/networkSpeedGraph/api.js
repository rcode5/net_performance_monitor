import axios from 'axios';

import { get } from '../../services/api.js';

export default {
  index: () => get('/api/files/'),
  show: (file) => get(file)
};
