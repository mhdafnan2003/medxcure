import express from 'express'
import { connectDB } from './db/connectDB.js'
import dotenv from 'dotenv'
import authroute from './routes/authroutes.js'

dotenv.config()
const app = express()
app.use(express.json())
app.use('/api/auth', authroute)

const startServer = async () => {
    try {
        await connectDB();
        app.listen(3000, () => {
            console.log('Server is running on Port 3000')
        });
    } catch (error) {
        console.error('Server startup error:', error);
    }
}

startServer();