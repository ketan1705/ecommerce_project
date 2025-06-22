import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'domain/auth/auth_di.dart';
import 'domain/category/category_di.dart';
import 'domain/order/order_di.dart';
import 'domain/product/product_di.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Firebase instances
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  /// services
  // auth firebase service
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl(
    auth: sl<FirebaseAuth>(),
    firestore: sl<FirebaseFirestore>(),
  ));
  // category firebase service
  sl.registerSingleton<CategoryFirebaseService>(CategoryFirebaseServiceImpl(
    firestore: sl<FirebaseFirestore>(),
  ));
  // product firebase service
  sl.registerSingleton<ProductFirebaseService>(ProductFirebaseServiceImpl(
    auth: sl<FirebaseAuth>(),
    firestore: sl<FirebaseFirestore>(),
  ));
  // order firebase service
  sl.registerSingleton<OrderFirebaseService>(OrderFirebaseServiceImpl(
    auth: sl<FirebaseAuth>(),
    firestore: sl<FirebaseFirestore>(),
  ));

  /// repositories
  // auth repository
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  // category repository
  sl.registerSingleton<CategoryRepository>(CategoryRepositoryImpl());
  // product repository
  sl.registerSingleton<ProductRepository>(ProductRepositoryImpl());
  // order repository
  sl.registerSingleton<OrderRepository>(OrderRepositoryImpl());

  ///UseCases

  // auth usesCases
  sl.registerSingleton<SignUpUseCase>(SignUpUseCase());
  sl.registerSingleton<GetAgesUseCase>(GetAgesUseCase());
  sl.registerSingleton<SignInUseCase>(SignInUseCase());
  sl.registerSingleton<SendPasswordResetEmailUseCase>(
      SendPasswordResetEmailUseCase());
  sl.registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase());
  sl.registerSingleton<GetUserUseCase>(GetUserUseCase());

  // category usesCases
  sl.registerSingleton<GetCategoryUseCase>(GetCategoryUseCase());

  // product usesCases
  sl.registerSingleton<GetTopSellingUseCase>(GetTopSellingUseCase());
  sl.registerSingleton<GetNewInUseCase>(GetNewInUseCase());
  sl.registerSingleton<GetProductsByCategoryIdUseCase>(
      GetProductsByCategoryIdUseCase());
  sl.registerSingleton<GetProductsByTitleUseCase>(GetProductsByTitleUseCase());
  sl.registerSingleton<AddOrRemoveFavProductsUseCase>(
      AddOrRemoveFavProductsUseCase());
  sl.registerSingleton<IsFavoriteUseCase>(IsFavoriteUseCase());
  sl.registerSingleton<GetFavoriteProductsUseCase>(
      GetFavoriteProductsUseCase());

  // order usesCases
  sl.registerSingleton<AddToCartUseCase>(AddToCartUseCase());
  sl.registerSingleton<GetCartProductsUseCase>(GetCartProductsUseCase());
  sl.registerSingleton<RemoveCartProductsUseCase>(RemoveCartProductsUseCase());
  sl.registerSingleton<PlaceOrderUseCase>(PlaceOrderUseCase());
  sl.registerSingleton<GetOrdersUseCase>(GetOrdersUseCase());
}
