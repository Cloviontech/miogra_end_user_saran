// get_used_products_category

// To parse this JSON data, do
//
//     final getUsedProductsCategory = getUsedProductsCategoryFromJson(jsonString);

import 'dart:convert';

List<GetUsedProductsCategory> getUsedProductsCategoryFromJson(String str) => List<GetUsedProductsCategory>.from(json.decode(str).map((x) => GetUsedProductsCategory.fromJson(x)));

String getUsedProductsCategoryToJson(List<GetUsedProductsCategory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetUsedProductsCategory {
    String user;
    String productId;
    String status;
    String category;
    String subcategory;
    Product product;

    GetUsedProductsCategory({
        required this.user,
        required this.productId,
        required this.status,
        required this.category,
        required this.subcategory,
        required this.product,
    });

    factory GetUsedProductsCategory.fromJson(Map<String, dynamic> json) => GetUsedProductsCategory(
        user: json["user"],
        productId: json["product_id"],
        status: json["status"],
        category: json["category"],
        subcategory: json["subcategory"],
        product: Product.fromJson(json["product"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "product_id": productId,
        "status": status,
        "category": category,
        "subcategory": subcategory,
        "product": product.toJson(),
    };
}

class Product {
    dynamic name;
    String brand;
    String actualPrice;
    String? discountPrice;
    String category;
    String subcategory;
    String productId;
    String primaryImage;
    String otherImages;
    double? sellingPrice;
    String? modelName;
    String? productDescription;

    Product({
        required this.name,
        required this.brand,
        required this.actualPrice,
        this.discountPrice,
        required this.category,
        required this.subcategory,
        required this.productId,
        required this.primaryImage,
        required this.otherImages,
        this.sellingPrice,
        this.modelName,
        this.productDescription,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json["name"],
        brand: json["brand"],
        actualPrice: json["actual_price"],
        discountPrice: json["discount_price"],
        category: json["category"],
        subcategory: json["subcategory"],
        productId: json["product_id"],
        primaryImage: json["primary_image"],
        otherImages: json["other_images"],
        sellingPrice: json["selling_price"]?.toDouble(),
        modelName: json["model_name"],
        productDescription: json["product_description"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "brand": brand,
        "actual_price": actualPrice,
        "discount_price": discountPrice,
        "category": category,
        "subcategory": subcategory,
        "product_id": productId,
        "primary_image": primaryImage,
        "other_images": otherImages,
        "selling_price": sellingPrice,
        "model_name": modelName,
        "product_description": productDescription,
    };
}
