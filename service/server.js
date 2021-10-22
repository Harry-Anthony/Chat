"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
var express_1 = __importDefault(require("express"));
var firebase_1 = __importDefault(require("firebase"));
var user_routes_1 = require("./routes/user.routes");
var body_parser_1 = __importDefault(require("body-parser"));
var app = express_1.default();
var config = {
    apiKey: "AIzaSyBcwRD-_jCAmBfjXlBT5ZmXj5cvAwov34g",
    authDomain: "chat-tuto-88829.firebaseapp.com",
    projectId: "chat-tuto-88829",
    databaseUrl: "https://chat-tuto-88829-default-rtdb.firebaseio.com/",
    storageBucket: "gs://chat-tuto-88829.appspot.com"
};
firebase_1.default.initializeApp(config);
console.log("hello");
app.use(body_parser_1.default.json());
app.use('/api', user_routes_1.router);
app.get('/', function (reqs, res) {
    res.send('hello');
});
app.listen(3000);
