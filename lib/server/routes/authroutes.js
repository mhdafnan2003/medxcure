import express from 'express'
import { login, signup } from '../controllers/authcontroller.js'
import { companyCheck, companyreg } from '../controllers/companyController.js'
import { getUserDetails } from '../controllers/userfetch.js'

const route = express.Router()

route.post('/signup', signup)
route.post('/login', login)
route.post('/companyreg', companyreg)
route.post('/companyCheck', companyCheck)
route.get('/user', getUserDetails)

export default route;