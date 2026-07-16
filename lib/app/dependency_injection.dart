import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../core/database/isar_service.dart';

// Authentication
import '../features/authentication/data/datasource/auth_remote_datasource_impl.dart';
import '../features/authentication/data/repository/auth_repository_impl.dart';
import '../features/authentication/domain/repository/auth_repository.dart';
import '../features/authentication/domain/usecases/current_user_usecase.dart';
import '../features/authentication/domain/usecases/google_login_usecase.dart';
import '../features/authentication/domain/usecases/login_usecase.dart';
import '../features/authentication/domain/usecases/logout_usecase.dart';

// Products
import '../features/products/data/datasources/product_local_datasource.dart';
import '../features/products/data/datasources/product_local_datasource_impl.dart';
import '../features/products/data/repositories/product_repository_impl.dart';
import '../features/products/domain/repositories/product_repository.dart';

import '../features/products/domain/usecases/add_product_usecase.dart';
import '../features/products/domain/usecases/delete_product_usecase.dart';
import '../features/products/domain/usecases/get_product_by_barcode_usecase.dart';
import '../features/products/domain/usecases/get_products_usecase.dart';
import '../features/products/domain/usecases/search_product_usecase.dart';
import '../features/products/domain/usecases/update_product_usecase.dart';

class DependencyInjection {
  DependencyInjection._();

  //==========================
  // AUTH
  //==========================

  static AuthRepository authRepository() {
    final firebaseAuth = FirebaseAuth.instance;
    final googleSignIn = GoogleSignIn();

    final remoteDataSource = AuthRemoteDataSourceImpl(
      firebaseAuth,
      googleSignIn,
    );

    return AuthRepositoryImpl(remoteDataSource);
  }

  static LoginUseCase loginUseCase() => LoginUseCase(authRepository());

  static LogoutUseCase logoutUseCase() => LogoutUseCase(authRepository());

  static GoogleLoginUseCase googleLoginUseCase() =>
      GoogleLoginUseCase(authRepository());

  static CurrentUserUseCase currentUserUseCase() =>
      CurrentUserUseCase(authRepository());

  //==========================
  // PRODUCTS
  //==========================

  static Future<ProductLocalDataSource> productLocalDataSource() async {
    final isar = await IsarService.instance();
    return ProductLocalDataSourceImpl(isar);
  }

  static Future<ProductRepository> productRepository() async {
    return ProductRepositoryImpl(await productLocalDataSource());
  }

  static Future<AddProductUseCase> addProductUseCase() async {
    return AddProductUseCase(await productRepository());
  }

  static Future<UpdateProductUseCase> updateProductUseCase() async {
    return UpdateProductUseCase(await productRepository());
  }

  static Future<DeleteProductUseCase> deleteProductUseCase() async {
    return DeleteProductUseCase(await productRepository());
  }

  static Future<GetProductsUseCase> getProductsUseCase() async {
    return GetProductsUseCase(await productRepository());
  }

  static Future<SearchProductUseCase> searchProductUseCase() async {
    return SearchProductUseCase(await productRepository());
  }

  static Future<GetProductByBarcodeUseCase> getProductByBarcodeUseCase() async {
    return GetProductByBarcodeUseCase(await productRepository());
  }
}
