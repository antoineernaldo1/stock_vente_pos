import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../core/database/isar_service.dart';

// AUTH
import '../features/authentication/data/datasource/auth_remote_datasource_impl.dart';
import '../features/authentication/data/repository/auth_repository_impl.dart';
import '../features/authentication/domain/repository/auth_repository.dart';
import '../features/authentication/domain/usecases/current_user_usecase.dart';
import '../features/authentication/domain/usecases/google_login_usecase.dart';
import '../features/authentication/domain/usecases/login_usecase.dart';
import '../features/authentication/domain/usecases/logout_usecase.dart';

// PRODUCTS
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

final sl = GetIt.instance;

Future<void> setupLocator() async {
  //-------------------------
  // Firebase
  //-------------------------

  sl.registerLazySingleton(() => FirebaseAuth.instance);

  sl.registerLazySingleton(() => GoogleSignIn());

  //-------------------------
  // Isar
  //-------------------------

  final isar = await IsarService.instance();

  sl.registerSingleton(isar);

  //-------------------------
  // Authentication
  //-------------------------

  sl.registerLazySingleton(
    () => AuthRemoteDataSourceImpl(sl<FirebaseAuth>(), sl<GoogleSignIn>()),
  );

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  sl.registerLazySingleton(() => LoginUseCase(sl()));

  sl.registerLazySingleton(() => LogoutUseCase(sl()));

  sl.registerLazySingleton(() => GoogleLoginUseCase(sl()));

  sl.registerLazySingleton(() => CurrentUserUseCase(sl()));

  //-------------------------
  // Products
  //-------------------------

  sl.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => AddProductUseCase(sl()));

  sl.registerLazySingleton(() => UpdateProductUseCase(sl()));

  sl.registerLazySingleton(() => DeleteProductUseCase(sl()));

  sl.registerLazySingleton(() => GetProductsUseCase(sl()));

  sl.registerLazySingleton(() => SearchProductUseCase(sl()));

  sl.registerLazySingleton(() => GetProductByBarcodeUseCase(sl()));
}
