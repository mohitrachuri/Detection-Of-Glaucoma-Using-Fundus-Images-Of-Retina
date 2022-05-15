import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import {environment} from '../src/environments/environment';
import {map} from 'rxjs/operators';
import { Observable } from 'rxjs';
import { KgUserLogin } from 'models/kg-user-login';
import { KgUserReg } from 'models/kg-user-reg';
@Injectable({
  providedIn: 'root'
})
export class WebRequestService {

 baseURL ='http://54.174.115.150:3000/';

constructor(private _http:HttpClient) {


   }






getUser(url,payload):Observable<KgUserLogin>{
return this._http.post<KgUserLogin>(`${this.baseURL}${url}`,payload).pipe(map(res =>{

return res;
}));



//"http://localhost:3000/api/user_signup
}
postUser(url, payload):Observable<KgUserReg>{
  return this._http.post<KgUserReg>(`${this.baseURL}${url}`,payload).pipe(map(res =>{

    return res;
  }));

}

get(url):Observable<KgUserLogin>{
  return this._http.get<KgUserLogin>(`${this.baseURL}${url}`).pipe(map(res =>{

  return res;
  }));


}
post(url, payload){
  return this._http.post(`${this.baseURL}${url}`,payload).pipe(map(res =>{
  return res;
  }));
}










// Just testing

// login(email: string, password: string) {
//   return this._http.post(`${this.baseURL}api/user_signup`, {
//     email,
//     password
//   }, {
//       observe: 'response'
//     });
// }

// signup(firstName:string,lastName:string, email: string, password: string) {
//   return this._http.post(`${this.baseURL}api/user_signup`, {
//     firstName,
//     lastName,
//     email,
//     password
//   }, {
//       observe: 'response'
//     });
// }

}
