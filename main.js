const express = require('express');
require('dotenv').config();

const port = process.env.PORT || 4000;
const environment = process.env.ENVIRONMENT;

const app = express();

app.use('/', (req, res, next) => {
  if (req.path === '/') {
    req.url = '/health';
  }
  next();
});

app.get('/health', (req, res) => {
  res.status(200).send('OK');
});

const server = app.listen(port, () => {
  console.log(`Server running on port ${port}`);
  console.log(`Environment: ${environment}`);
});

module.exports = {app, server}; // Ekspor objek app dan server
