import { NgModule } from "@angular/core";
import { CommonModule } from "@angular/common";

import { ProductListComponent } from './produt-list.component';
import { ProductService } from './product.service';


@NgModule({
  imports: [CommonModule],
  declarations: [ProductListComponent],
  exports: [ProductListComponent],
  providers: [ProductService]

})
export class ProductModule {}
