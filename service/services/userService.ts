import firebase from 'firebase'
export default class UserService {
    static async createUser(data:any){
        firebase.database().ref('users/').push().set(
            {
                username: data.username,
                email: data.email,
                password: data.password,
            }
        )
    }
    static async updateUser(uid:any, data:any){
        firebase.database().ref('users/'+uid).update(
            data
        )
    }
}