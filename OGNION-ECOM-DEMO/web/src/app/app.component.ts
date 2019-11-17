import { Component } from '@angular/core';

import { Product } from './product/product';
import { ProductService } from './product/product.service';


@Component({
  moduleId: module.id,
  selector: 'my-app',
  templateUrl: `app.component.html`,
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
