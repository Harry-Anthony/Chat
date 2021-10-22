"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.router = void 0;
var express_1 = require("express");
var user_controller_1 = __importDefault(require("../controller/user.controller"));
var multer_1 = __importDefault(require("multer"));
exports.router = express_1.Router();
// Multer is required to process file uploads and make them available via
// req.files.
var multer = multer_1.default({
    storage: multer_1.default.memoryStorage(),
    limits: {
        fileSize: 5 * 1024 * 1024, // no larger than 5mb, you can change as needed.
    },
});
exports.router.get('/read', user_controller_1.default.apiGetUser);
exports.router.post('/post', user_controller_1.default.apiCreateUser);
exports.router.put('/update/:id', user_controller_1.default.apiUpdateUser);
exports.router.post('/upload/:id', multer.single('file'), user_controller_1.default.apiUpdatePdp);
// router.delete('/',)
