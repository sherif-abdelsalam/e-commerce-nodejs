import dotenv from "dotenv"
dotenv.config();
import express from "express";
import cookieParser from "cookie-parser"
import path from "path";
import { fileURLToPath } from "url";

import { dbConnect } from "./Database/dbConnect.js";

import productRoute from "./Routes/product.route.js";
import categoryRoute from "./Routes/category.route.js";
import adminRoute from "./Routes/admin.route.js";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

import userRouter from "./Routes/user.route.js";
import CartRoutes from "./Routes/cart.route.js";
import AppErrors from "./Utils/appErrors.js";
import globalErrorHandler from "./Controllers/globalError.controller.js";
import paymentRoutes from "./Routes/payment.route.js"
import orderRouter from "./Routes/order.route.js"
await dbConnect(); 

const app = express();
app.use(express.json());
app.use(cookieParser());
// Serve static files
app.use(express.static(path.join(__dirname, "public")));


app.get('/health', (req, res) => {
  res.status(200).json({
    status: 'ok',
    message: 'Server is healthy',
    uptime: process.uptime(),
    timestamp: new Date()
  })
})

app.use("/categories", categoryRoute);
app.use("/products", productRoute);
app.use("/payment", paymentRoutes);
app.use("/admin", adminRoute);
const PORT = process.env.PORT || 3004;


app.use("/api/v1/users", userRouter);
app.use("/api/v1/cart", CartRoutes)
app.use("/api/v1/orders", orderRouter);

app.use((req, res, next) => {
  next(new AppErrors(`Can't find ${req.originalUrl} on this server!`, 404));
});


app.use(globalErrorHandler);

app.listen(PORT, () => {
    console.log(`Server up and running on port ${PORT}`);
});

