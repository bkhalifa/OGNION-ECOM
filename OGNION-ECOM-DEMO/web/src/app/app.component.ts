import { Component } from '@angular/core';

import { Product } from './product/product';
import { ProductService } from './product/product.service';


@Component({
  selector: 'my-app',
  template: `<h1>Hello {{name}}</h1>`,
})
export class AppComponent  {
  constructor(private _prodcutSerivve: ProductService) {}

  products: Product[];


  ngOnInit() {
    this._prodcutSerivve.GetProduct()
      .subscribe(
        res => this.products = res,
        err => console.log(err.status)
      );
    console.log(this.products);
  }
}
