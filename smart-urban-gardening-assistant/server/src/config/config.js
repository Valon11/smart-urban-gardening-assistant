module.exports = {
  port: process.env.PORT || 3001,
  db: {
    host: process.env.DB_HOST || 'localhost',
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASS || 'pw123',
    database: process.env.DB_NAME || 'db'
  },
  authentication: {
    jwtSecret: process.env.JWT_SECRET || 'secret'
  }
}