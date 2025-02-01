import { companyDetails } from "../model/companymodel.js";

export const companyreg = async (req, res) => {
    try {
        const { name, licenseNumber, lotNumber, expirydate } = req.body;

        // Validate required fields
        if (!name || !licenseNumber || !lotNumber || !expirydate) {
            return res.status(400).json({ 
                success: false, 
                message: 'All fields are required' 
            });
        }

        // Check if company with same license number exists
        const existingCompany = await companyDetails.findOne({ licenseNumber });
        if (existingCompany) {
            return res.status(400).json({ 
                success: false, 
                message: 'Company with this license number already exists' 
            });
        }

        // Create new company
        const newCompany = await companyDetails.create({
            name,
            licenseNumber,
            lotNumber,
            expirydate: new Date(expirydate)
        });

        return res.status(201).json({
            success: true,
            message: 'Company registered successfully',
            company: newCompany
        });

    } catch (error) {
        console.error('Company registration error:', error); // This will help with debugging
        return res.status(400).json({ 
            success: false, 
            message: 'Something went wrong',
            error: error.message // Including the actual error message for debugging
        });
    }
};

export const companyCheck = async (req, res) => {
    try {
        const { licenseNumber, lotNumber } = req.body;

        if (!licenseNumber || !lotNumber) {
            return res.status(400).json({ 
                success: false, 
                message: 'All fields are Required' 
            });
        }

        const companyExist = await companyDetails.findOne({ licenseNumber });

        if (!companyExist) {
            return res.status(400).json({ 
                success: false, 
                message: 'Company not found' 
            });
        }

        // Since lotNumber is not hashed in the database, compare directly
        if (lotNumber !== companyExist.lotNumber) {
            return res.status(400).json({ 
                success: false, 
                message: 'Invalid credentials' 
            });
        }

        // Include company details in the response
        return res.status(200).json({
            success: true, 
            message: 'Company Found',
            data: {
                licenseNumber: companyExist.licenseNumber,
                lotNumber: companyExist.lotNumber,
                companyName: companyExist.companyName,
                // Add any other fields you want to send
            }
        });
        
    } catch (error) {
        console.error('Company check error:', error);
        return res.status(400).json({ 
            success: false, 
            message: 'Something went wrong',
            error: error.message 
        });
    }
}