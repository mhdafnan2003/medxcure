import bcrypt from 'bcrypt';
import { user} from "../model/usermodel.js";

export const signup = async(req,res)=>{
    try {
        const {email, password, name,role} = req.body;
        
        if(!email || !password || !name ||!role){
            return res.status(400).json({ 
                success: false, 
                message: 'Name, email, and password are required' 
            });
        }

        const userexist = await user.findOne({email});

        if (userexist) {
            return res.status(400).json({ 
                success: false, 
                message: 'User already exists' 
            });
        }

        const hashPassword = await bcrypt.hash(password, 10);
        
        console.log('Attempting to create user with email:', email);
        
        const newUser = await user.create({
            name,
            email,
            password: hashPassword,
            role
        });
        
        console.log('User created successfully:', newUser._id);

        return res.status(201).json({
            success: true, 
            message: 'User created successfully'
        });
        
    } catch (error) {
        console.error('Signup error details:', {
            error: error.message,
            stack: error.stack,
            body: req.body
        });
        
        return res.status(500).json({ 
            success: false, 
            message: 'Internal server error during signup',
            error: error.message
        });
    }
}

export const login = async(req,res)=>{
    try {
        const {email,password} = req.body;

        if(!email || !password){
            return res.status(400).json({ 
                success: false, 
                message: 'Email and password are required' 
            });
        }

        const userexist = await user.findOne({email});

        if (!userexist) {
            return res.status(400).json({ 
                success: false, 
                message: 'Invalid email or password' 
            });
        }

        const isValidPassword = await bcrypt.compare(password, userexist.password);

        if(!isValidPassword){
            return res.status(400).json({ 
                success: false, 
                message: 'Invalid email or password' 
            });
        }

        return res.status(200).json({
            success: true, 
            message: 'Login successful',
            user: {
                name: userexist.name,
                email: userexist.email
            }
        });
        
    } catch (error) {
        console.error('Login error:', error);
        return res.status(500).json({ 
            success: false, 
            message: 'Internal server error during login' 
        });
    }
}