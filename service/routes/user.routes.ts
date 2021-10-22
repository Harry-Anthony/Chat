import { Router } from 'express'
import UserController from '../controller/user.controller'
import Multer from 'multer'
export let router = Router()

// Multer is required to process file uploads and make them available via
// req.files.
const multer = Multer({
    storage: Multer.memoryStorage(),
    limits: {
      fileSize: 5 * 1024 * 1024, // no larger than 5mb, you can change as needed.
    },
  });
router.get('/read',UserController.apiGetUser)

router.post('/post',UserController.apiCreateUser)

router.put('/update/:id',UserController.apiUpdateUser)

router.post('/upload/:id',multer.single('file'),UserController.apiUpdatePdp)
// router.delete('/',)
