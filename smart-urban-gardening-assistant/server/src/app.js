const express = require('express')
const cors = require('cors')
const morgan = require('morgan')
const config = require('./config/config')
const routes = require('./routes')

const app = express()
const corsOptions = {
  origin: 'http://localhost:3000',
  methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
  credentials: true,
  optionsSuccessStatus: 204
}

app.use(cors(corsOptions)).use(morgan('combined')).use(express.json()).use('/', routes)
app.listen(config.port, () => console.log(`Server on port ${config.port}`))