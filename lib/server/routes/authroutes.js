import express from 'express'
import { login, signup } from '../controllers/authcontroller.js'
import { companyCheck, companyreg } from '../controllers/companyController.js'

const route = express.Router()

route.post('/signup', signup)
route.post('/login', login)
route.post('/companyreg', companyreg)
route.post('/companyCheck', companyCheck)

export default route;