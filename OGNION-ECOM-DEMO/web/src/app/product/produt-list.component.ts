import { Component } from '@angular/core';
import { Product } from './product';
import { ProductService } from './product.service';


@Component({
  moduleId: module.id,
  selector: 'hike-list',
  templateUrl: 'product-list.component.html'
})

export class ProductListComponent {

  constructor(private _prodcutSerivve: ProductService) { }

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
