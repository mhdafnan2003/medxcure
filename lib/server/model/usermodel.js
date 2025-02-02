import mongoose from "mongoose";

const userschema = mongoose.Schema({
    email: {
        type : String,
        required: true,
        unique: true
    },
    password : {
        type: String,
        required : true,
    },
    name:{
        type:String,
        required:true
    },
    role:{
        type: String,
        required : true
    }
    
},{timestamps: true})

export const user = mongoose.model('user',userschema);