part of 'product_bloc.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoaded extends ProductState {
  final int? page;
  final List<Product> productList;
  final bool? hasReachedMax;
  ProductLoaded({required this.productList, this.page, this.hasReachedMax});

  ProductLoaded copyWith(
      {int? page, List<Product>? productList, bool? hasReachedMax}) {
    return ProductLoaded(
        page: page ?? this.page,
        productList: productList ?? this.productList,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }
}
