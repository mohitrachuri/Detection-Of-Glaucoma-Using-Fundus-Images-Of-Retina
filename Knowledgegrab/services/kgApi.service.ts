import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
// import { RequestOptions, } from 'https';
import { KgUserReg } from 'models/kg-user-reg';

import { Observable } from 'rxjs';
import { KgUserLogin } from 'models/kg-user-login';

@Injectable({
  providedIn: 'root'
})
export class KgapiserviceService {

// apiURL:string='http://localhost:3000';

// public loginPage:string="";
// public signupPage:string="";


  constructor( ) { }
















  
  // createUser():Observable <KgUserReg[]>{
  //   return this._httpClient.post<KgUserReg[]>(`${this.apiURL}/user_signup`, KgUserReg);
  // }

  // getUserDetails():Observable<any>{
  //   return this._httpClient.get(`${this.apiURL}`);
  // }
//   // getUserById(id: number){}

// //   getUsers(url?:string){}

//   getDetails(){
// return this._httpClient.get<Kguser[]>(`${this.apiURL}/user_signup`);
//   }
// getHeaders(){
// const headers = new Headers();
// headers.append('Content-type', 'application/json');
// //TODO: add token
// return headers;
// }

// getRequestOptions(): RequestOptions{
//   const options = new RequestOptions();
//   options.headers = this.getHeaders();
//   return options;
// }
// get(url:string){
// return this._httpClient.get(url, this.getRequestOptions());
// }
// post(url:string,data:any){
// return this._httpClient.post(url,data, this.getRequestOptions());
// }
}
