import UserService from '../services/userService';
import firebase from 'firebase';

import {Storage} from '@google-cloud/storage'
import {format} from 'util'

export default class UserController {
    static async apiGetUser(req:any, res:any, next:any){
        let data = req.body
        firebase.database().ref('users/').on('value',(snapshot)=>{
            console.log(snapshot.val())
            const data1 = snapshot.val()
            console.log("data1",Object.entries(data1))
            Object.entries(data1).forEach((element: any) => {
                if(element[1].username==data.username && element[1].email == data.email && element[1].password == data.password){
                    console.log("if")
                    res.send(
                        {
                            "id": element[0],
                            "userInfo": element[1]
                        }
                    )
                }
            })
            
        })
    }
    static async apiCreateUser(req:any, res:any, next:any){
        console.log(req.body)
        UserService.createUser(req.body).then((value)=>{
            res.json(value)
            res.send(value)
            console.log(res)
        }).catch((error)=>{
            console.log(error);
        })
    }
    static async apiUpdateUser(req:any, res:any, next:any){
        UserService.updateUser(req.params.id, req.body).then((value)=>{
            res.json(value)
        })
    }
    static async apiUpdatePdp(req:any, res:any, next:any){
        const storage = new Storage()
        if (!req.file) {
            res.status(400).send('No file uploaded.');
            return;
        }
        // A bucket is a container for objects (files).
        const bucket = storage.bucket('gs://chat-tuto-88829.appspot.com');
        const blob = bucket.file(req.file.originalname);
        const blobStream = blob.createWriteStream();
        blobStream.on('error', err => {
            next(err)
        })

        blobStream.on('finish', () => {
            // The public URL can be used to directly access the file via HTTP.
            const publicUrl = format(
              `https://storage.googleapis.com/${bucket.name}/${blob.name}`
            );
            res.status(200).send(publicUrl);
          });

        blobStream.end(req.file.buffer);
        firebase.database().ref('users/'+req.params.id).update(
            {"image": req.file.originalname()}
        )
    }
}