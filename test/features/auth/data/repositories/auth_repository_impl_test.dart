// // اختبار تنفيذ مستودع المصادقة
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:grocery_shop_app/features/auth/data/repositories/auth_repository_impl.dart';
// import 'package:grocery_shop_app/features/auth/data/datasources/auth_remote_data_source.dart';
// import 'package:grocery_shop_app/features/auth/data/datasources/auth_local_data_source.dart';
// import 'package:grocery_shop_app/features/auth/data/models/auth_token_model.dart';
// import 'package:grocery_shop_app/features/auth/data/models/user_model.dart';
// import 'package:grocery_shop_app/features/auth/data/models/user_register_model.dart';
// import 'package:grocery_shop_app/core/error/exception.dart';
// import 'package:grocery_shop_app/core/error/failure.dart';

// class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

// class MockAuthLocalDataSource extends Mock implements AuthLocalDataSource {}

// void main() {
//   late AuthRepositoryImpl repository;
//   late MockAuthRemoteDataSource mockRemoteDataSource;
//   late MockAuthLocalDataSource mockLocalDataSource;

//   setUp(() {
//     mockRemoteDataSource = MockAuthRemoteDataSource();
//     mockLocalDataSource = MockAuthLocalDataSource();
//     repository = AuthRepositoryImpl(
//       remoteDataSource: mockRemoteDataSource,
//       localDataSource: mockLocalDataSource,
//     );
//   });

//   group('login', () {
//     const testEmail = 'user@example.com';
//     const testPassword = 'P@ssw0rd!';
//     const testTokenModel = AuthTokenModel(
//       accessToken: 'access_token_123',
//       refreshToken: 'refresh_token_123',
//       expiresIn: 3600,
//     );

//     test('should return AuthToken when login is successful', () async {
//       // Arrange
//       when(mockRemoteDataSource.login(testEmail, testPassword))
//           .thenAnswer((_) async => testTokenModel);
//       when(mockLocalDataSource.saveTokens(testTokenModel))
//           .thenAnswer((_) async => {});

//       // Act
//       final result = await repository.login(testEmail, testPassword);

//       // Assert
//       expect(result, isA<Right<Failure, AuthTokenModel>>());
//       verify(mockRemoteDataSource.login(testEmail, testPassword)).called(1);
//       verify(mockLocalDataSource.saveTokens(testTokenModel)).called(1);
//     });

//     test('should return ServerFailure when ServerException occurs', () async {
//       // Arrange
//       when(mockRemoteDataSource.login(testEmail, testPassword))
//           .thenThrow(ServerException('Invalid credentials'));

//       // Act
//       final result = await repository.login(testEmail, testPassword);

//       // Assert
//       expect(result, isA<Left<Failure, AuthTokenModel>>());
//       result.fold(
//         (failure) => expect(failure, isA<ServerFailure>()),
//         (_) => fail('should return failure'),
//       );
//     });

//     test('should return NetworkFailure when NetworkException occurs', () async {
//       // Arrange
//       when(mockRemoteDataSource.login(testEmail, testPassword))
//           .thenThrow(NetworkException('Network error'));

//       // Act
//       final result = await repository.login(testEmail, testPassword);

//       // Assert
//       expect(result, isA<Left<Failure, AuthTokenModel>>());
//       result.fold(
//         (failure) => expect(failure, isA<NetworkFailure>()),
//         (_) => fail('should return failure'),
//       );
//     });
//   });

//   group('register', () {
//     const testRegisterModel = UserRegisterModel(
//       name: 'John Doe',
//       email: 'user@example.com',
//       password: 'P@ssw0rd!',
//       passwordConfirmation: 'P@ssw0rd!',
//     );
//     const testUserModel = UserModel(
//       id: 'u1',
//       name: 'John Doe',
//       email: 'user@example.com',
//     );

//     test('should return User when registration is successful', () async {
//       // Arrange
//       when(mockRemoteDataSource.register(testRegisterModel))
//           .thenAnswer((_) async => testUserModel);

//       // Act
//       final result = await repository.register(
//         name: testRegisterModel.name,
//         email: testRegisterModel.email,
//         password: testRegisterModel.password,
//         passwordConfirmation: testRegisterModel.passwordConfirmation,
//       );

//       // Assert
//       expect(result, isA<Right<Failure, UserModel>>());
//       verify(mockRemoteDataSource.register(testRegisterModel)).called(1);
//     });

//     test('should return ValidationFailure when ValidationException occurs',
//         () async {
//       // Arrange
//       when(mockRemoteDataSource.register(testRegisterModel))
//           .thenThrow(ValidationException({
//         'email': ['already taken']
//       }));

//       // Act
//       final result = await repository.register(
//         name: testRegisterModel.name,
//         email: testRegisterModel.email,
//         password: testRegisterModel.password,
//         passwordConfirmation: testRegisterModel.passwordConfirmation,
//       );

//       // Assert
//       expect(result, isA<Left<Failure, UserModel>>());
//       result.fold(
//         (failure) {
//           expect(failure, isA<ValidationFailure>());
//           if (failure is ValidationFailure) {
//             expect(failure.errors['email'], ['already taken']);
//           }
//         },
//         (_) => fail('should return failure'),
//       );
//     });
//   });
// }
