import express from "express";
import dashboard from "./routes/dashboard";
import prisma from "./client";
import { Request, Response, NextFunction } from "express";
import { ValidationError } from "express-validation";
import { CustomError } from "./errors/CustomError";
const app = express();

app.use(express.json());
app.use(dashboard);

app.use(
  async (
    err: CustomError,
    _req: Request,
    res: Response,
    next: NextFunction
  ) => {
    console.error("Error handler start ", err);
    console.error(err.stack);
    if (res.headersSent) {
      return next(err);
    }

    const message = err.message || "Server error. Please retry.";
    const status = typeof err.statusCode === "number" ? err.statusCode : 500;

    if (err instanceof ValidationError) {
      res.status(err.statusCode).json(err);
      return res.end();
    }

    res.status(status).json({
      message: message,
    });
    console.error("Error handler end");
    return res.end();
  }
);

app.listen(3000, () => {
  console.log("Server is running on port 3000");
});

process.on("SIGINT", async () => {
  await prisma.$disconnect();
  process.exit();
});
process.on("SIGTERM", async () => {
  await prisma.$disconnect();
  process.exit();
});
