"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
var core_1 = require("@angular/core");
var product_service_1 = require("./product.service");
var ProductListComponent = (function () {
    function ProductListComponent(_prodcutSerivve) {
        this._prodcutSerivve = _prodcutSerivve;
    }
    ProductListComponent.prototype.ngOnInit = function () {
        var _this = this;
        this._prodcutSerivve.GetProduct()
            .subscribe(function (res) { return _this.products = res; }, function (err) { return console.log(err.status); });
        console.log(this.products);
    };
    return ProductListComponent;
}());
ProductListComponent = __decorate([
    core_1.Component({
        moduleId: module.id,
        selector: 'hike-list',
        templateUrl: 'product-list.component.html'
    }),
    __metadata("design:paramtypes", [product_service_1.ProductService])
], ProductListComponent);
exports.ProductListComponent = ProductListComponent;
//# sourceMappingURL=produt-list.component.js.map