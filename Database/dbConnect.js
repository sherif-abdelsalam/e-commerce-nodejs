import mongoose from "mongoose";

export const dbConnect = async () => {
    try {

        // const DB_HOST = "mongo";
        // const DB_PORT =  27017;
        // const DB_USER = "root";
        // const DB_PASSWORD = "example";
        // const DB_NAME = "ecommerce";

        // const uri = `mongodb://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}`;
        const uri = process.env.MONGODB_URL;

        await mongoose.connect(uri);

        console.log("Connected to MongoDB successfully!");   

    } catch (error) {
        console.log(error);
    }
};