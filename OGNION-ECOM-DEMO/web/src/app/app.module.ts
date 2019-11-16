import { NgModule }      from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { HttpModule } from '@angular/http';


import { AppComponent } from './app.component';
import { ProductModule } from './product/Product.Module';



@NgModule({
  imports: [BrowserModule, ProductModule, HttpModule ],
  declarations: [ AppComponent ],
  bootstrap:    [ AppComponent ]
})
export class AppModule { }
