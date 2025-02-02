import { user } from "../model/usermodel.js";

export const getUserDetails = async (req, res) => {
    try {
        const { email } = req.query;

        if (!email) {
            return res.status(400).json({
                success: false,
                message: 'Email is required'
            });
        }

        const userDetails = await user.findOne({ email }, { password: 0 }); // Exclude password from the response

        if (!userDetails) {
            return res.status(404).json({
                success: false,
                message: 'User not found'
            });
        }

        return res.status(200).json({
            success: true,
            user: userDetails
        });

    } catch (error) {
        console.error('User fetch error:', error);
        return res.status(500).json({
            success: false,
            message: 'Internal server error while fetching user details'
        });
    }
}
