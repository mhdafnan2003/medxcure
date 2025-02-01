import bcrypt from 'bcrypt';
import { user} from "../model/usermodel.js";

export const signup = async(req,res)=>{
    try {

        const {email,password} = req.body;
        

        if(!email || !password){
            throw new Error('All fields are Required')
        }

        const userexist = await user.findOne({email});

        if (userexist) {
            return res.status(400).json({ success: false, message: 'User already Exists' })
            
        }

        const hashPassword = await bcrypt.hash(password, 10);
        
        const newUser = await user.create({
            email,
            password: hashPassword,
        });

        return res.status(201).json({success: true, message: 'User Created'})
        
    } catch (error) {
        return res.status(400).json({ success: false, message: 'Something went Wrong' })
        
    }

    
}

export const login = async(req,res)=>{
    try {
        const {email,password} = req.body;

        if(!email || !password){
            throw new Error('All fields are Required')
        }

        const userexist = await user.findOne({email});

        if (!userexist) {
            return res.status(400).json({ success: false, message: 'User not found' })
        }

        const isValidPassword = await bcrypt.compare(password, userexist.password)

        if(!isValidPassword){
            return res.status(400).json({ success: false, message: 'Invalid credentials' })
        }

        return res.status(200).json({success: true, message: 'Login successful'})
        
    } catch (error) {
        return res.status(400).json({ success: false, message: 'Something went Wrong' })
    }
}