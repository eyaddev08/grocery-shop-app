// // اختبار حالة استخدام تسجيل الدخول
// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:grocery_shop_app/features/auth/domain/entities/auth_token.dart';
// import 'package:grocery_shop_app/features/auth/domain/repositories/auth_repository.dart';
// import 'package:grocery_shop_app/features/auth/domain/usecases/login.dart';
// import 'package:grocery_shop_app/core/error/failure.dart';

// class MockAuthRepository extends Mock implements AuthRepository {}

// void main() {
//   late Login loginUseCase;
//   late MockAuthRepository mockRepository;

//   setUp(() {
//     mockRepository = MockAuthRepository();
//     loginUseCase = Login(mockRepository);
//   });

//   const testEmail = 'user@example.com';
//   const testPassword = 'P@ssw0rd!';
//   const testToken = AuthToken(
//     accessToken: 'access_token_123',
//     refreshToken: 'refresh_token_123',
//     expiresIn: 3600,
//   );

//   test('should return AuthToken when login is successful', () async {
//     // Arrange
//     when(mockRepository.login(testEmail, testPassword))
//         .thenAnswer((_) async => const Right<Failure, AuthToken>(testToken));

//     // Act
//     final result = await loginUseCase(testEmail, testPassword);

//     // Assert
//     expect(result, isA<Right<Failure, AuthToken>>());
//     verify(mockRepository.login(testEmail, testPassword)).called(1);
//     verifyNoMoreInteractions(mockRepository);
//   });

//   test('should return ServerFailure when credentials are invalid', () async {
//     // Arrange
//     when(mockRepository.login(testEmail, testPassword)).thenAnswer(
//       (_) async => Left<Failure, AuthToken>(
//         ServerFailure(message: 'Invalid credentials'),
//       ),
//     );

//     // Act
//     final result = await loginUseCase(testEmail, testPassword);

//     // Assert
//     expect(result, isA<Left<Failure, AuthToken>>());
//     result.fold(
//       (failure) {
//         expect(failure, isA<ServerFailure>());
//         expect(failure.message, 'Invalid credentials');
//       },
//       (_) => fail('Expected failure, got success'),
//     );
//     verify(mockRepository.login(testEmail, testPassword)).called(1);
//   });

//   test('should return NetworkFailure when network error occurs', () async {
//     // Arrange
//     when(mockRepository.login(testEmail, testPassword)).thenAnswer(
//       (_) async => Left<Failure, AuthToken>(
//         NetworkFailure(message: 'Network error'),
//       ),
//     );

//     // Act
//     final result = await loginUseCase(testEmail, testPassword);

//     // Assert
//     expect(result, isA<Left<Failure, AuthToken>>());
//     result.fold(
//       (failure) {
//         expect(failure, isA<NetworkFailure>());
//         expect(failure.message, 'Network error');
//       },
//       (_) => fail('Expected failure, got success'),
//     );
//     verify(mockRepository.login(testEmail, testPassword)).called(1);
//   });
// }
