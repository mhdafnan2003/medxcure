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
    role:{
        type: String,
        enum : ['doc','user','admin']
    }
    
},{timestamps: true})

export const user = mongoose.model('user',userschema);