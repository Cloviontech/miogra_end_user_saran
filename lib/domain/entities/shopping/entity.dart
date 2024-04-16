import 'package:equatable/equatable.dart';

class MobileEntity extends Equatable {

  final String productId;
  final String shopId;
  final String status;
  final String category;
  final String subCategory;
  final List product;
  

  //  int id;
  //  int userId;

    MobileEntity( {required this.productId, required this.shopId, required this.status, required this.category, required this.subCategory, required this.product, });
   
     @override
     List<Object?> get props => [this.productId, this.shopId,
     this.status, this.category,
     this.subCategory, this.category,
     this.product,
     ];
}