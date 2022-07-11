import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../model/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<LoadProduct>((event, emit) async {
      // TODO: implement event handler
      List<Product> productList;
      if (event.restaurantId == null) {
        if (state is ProductInitial) {
          productList = await Product.connectToAPI(null, 1, 6);
          emit(ProductLoaded(
              page: 1, productList: productList, hasReachedMax: false));
        } else {
          ProductLoaded productLoaded = state as ProductLoaded;
          productList =
              await Product.connectToAPI(null, (productLoaded.page)! + 1, 6);
          emit((productList.isEmpty)
              ? productLoaded.copyWith(hasReachedMax: true)
              : ProductLoaded(
                  productList: productLoaded.productList + productList,
                  hasReachedMax: false,
                  page: productLoaded.page! + 1));
        }
      } else {
        productList = await Product.connectToAPI((event.restaurantId), 0, 0);
        emit(ProductLoaded(productList: productList));
      }
    });
  }
}
