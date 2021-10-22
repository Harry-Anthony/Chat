import express from 'express'
import firebase from 'firebase'
import {router} from './routes/user.routes'
import bodyParser from 'body-parser'
const app = express()

const config = {
    apiKey: "AIzaSyBcwRD-_jCAmBfjXlBT5ZmXj5cvAwov34g",
    authDomain: "chat-tuto-88829.firebaseapp.com",
    projectId: "chat-tuto-88829",
    databaseUrl: "https://chat-tuto-88829-default-rtdb.firebaseio.com/",
    storageBucket: "gs://chat-tuto-88829.appspot.com"
} 

firebase.initializeApp(config)

console.log("hello")
app.use(bodyParser.json())
app.use('/api',router)
app.get('/',(reqs,res)=>{
    res.send('hello')
})

app.listen(3000)