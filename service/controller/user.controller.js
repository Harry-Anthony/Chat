"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (_) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
var userService_1 = __importDefault(require("../services/userService"));
var firebase_1 = __importDefault(require("firebase"));
var storage_1 = require("@google-cloud/storage");
var util_1 = require("util");
var UserController = /** @class */ (function () {
    function UserController() {
    }
    UserController.apiGetUser = function (req, res, next) {
        return __awaiter(this, void 0, void 0, function () {
            var data;
            return __generator(this, function (_a) {
                data = req.body;
                firebase_1.default.database().ref('users/').on('value', function (snapshot) {
                    console.log(snapshot.val());
                    var data1 = snapshot.val();
                    console.log("data1", Object.entries(data1));
                    Object.entries(data1).forEach(function (element) {
                        if (element[1].username == data.username && element[1].email == data.email && element[1].password == data.password) {
                            console.log("if");
                            res.send({
                                "id": element[0],
                                "userInfo": element[1]
                            });
                        }
                    });
                });
                return [2 /*return*/];
            });
        });
    };
    UserController.apiCreateUser = function (req, res, next) {
        return __awaiter(this, void 0, void 0, function () {
            return __generator(this, function (_a) {
                console.log(req.body);
                userService_1.default.createUser(req.body).then(function (value) {
                    res.json(value);
                    res.send(value);
                    console.log(res);
                }).catch(function (error) {
                    console.log(error);
                });
                return [2 /*return*/];
            });
        });
    };
    UserController.apiUpdateUser = function (req, res, next) {
        return __awaiter(this, void 0, void 0, function () {
            return __generator(this, function (_a) {
                userService_1.default.updateUser(req.params.id, req.body).then(function (value) {
                    res.json(value);
                });
                return [2 /*return*/];
            });
        });
    };
    UserController.apiUpdatePdp = function (req, res, next) {
        return __awaiter(this, void 0, void 0, function () {
            var storage, bucket, blob, blobStream;
            return __generator(this, function (_a) {
                storage = new storage_1.Storage();
                if (!req.file) {
                    res.status(400).send('No file uploaded.');
                    return [2 /*return*/];
                }
                bucket = storage.bucket('gs://chat-tuto-88829.appspot.com');
                blob = bucket.file(req.file.originalname);
                blobStream = blob.createWriteStream();
                blobStream.on('error', function (err) {
                    next(err);
                });
                blobStream.on('finish', function () {
                    // The public URL can be used to directly access the file via HTTP.
                    var publicUrl = util_1.format("https://storage.googleapis.com/" + bucket.name + "/" + blob.name);
                    res.status(200).send(publicUrl);
                });
                blobStream.end(req.file.buffer);
                firebase_1.default.database().ref('users/' + req.params.id).update({ "image": req.file.originalname() });
                return [2 /*return*/];
            });
        });
    };
    return UserController;
}());
exports.default = UserController;
