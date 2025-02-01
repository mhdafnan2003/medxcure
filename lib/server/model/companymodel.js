import mongoose from "mongoose";

const companySchema = mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    licenseNumber: {
        type: String,
        required: true,
        unique: true
    },
    lotNumber: {
        type: String,
        required: true
    },
    expirydate: {
        type: Date,
        required: true
    }
}, { timestamps: true });

export const companyDetails = mongoose.model('companyDetails', companySchema);