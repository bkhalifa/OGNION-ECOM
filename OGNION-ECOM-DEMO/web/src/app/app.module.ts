import { NgModule }      from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { HttpModule } from '@angular/http';
import { RouterModule } from '@angular/router';


import { AppComponent } from './app.component';
import { ProductModule } from './product/Product.Module';
import { ProductListComponent } from './product/produt-list.component';
import { HomeModule } from './home/home.module';
import { HomeComponent } from './home/home.component';

import { PageNotFoundComponent } from './page-not-found.component';



@NgModule({
  imports: [BrowserModule, HttpModule, ProductModule, HomeModule,
    RouterModule.forRoot([
      { path: 'home', component: HomeComponent },
      { path: 'products', component: ProductListComponent },
      { path: '', redirectTo: 'home', pathMatch: 'full' },
      { path: '**', component: PageNotFoundComponent } ])
     ],
  declarations: [AppComponent, PageNotFoundComponent ],
  bootstrap:    [ AppComponent ]
})
export class AppModule { }
