import { Injectable } from "@angular/core";
import { Http } from "@angular/http";

import { Product } from './product';

import 'rxjs/add/operator/map';
import 'rxjs/add/operator/do';

@Injectable()
export class ProductService {

  constructor(private _http:Http) {

  }

  GetProduct() {

  
    return this._http.get('http://localhost:8081/api/product')
      .do(x => console.log(x))
      .map(products => products.json())
  }
}
