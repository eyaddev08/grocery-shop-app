// // اختبار صفحة تسجيل الدخول
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mockito/mockito.dart';
// import 'package:grocery_shop_app/features/auth/presentation/pages/login_page.dart';
// import 'package:grocery_shop_app/features/auth/presentation/cubit/auth_cubit.dart';
// import 'package:grocery_shop_app/features/auth/presentation/cubit/auth_state.dart';

// class MockAuthCubit extends Mock implements AuthCubit {}

// void main() {
//   late MockAuthCubit mockAuthCubit;

//   setUp(() {
//     mockAuthCubit = MockAuthCubit();
//     when(mockAuthCubit.state).thenReturn(AuthInitial());
//   });

//   Widget createTestWidget(Widget child) => MaterialApp(
//         home: BlocProvider<AuthCubit>.value(
//           value: mockAuthCubit,
//           child: child,
//         ),
//       );

//   testWidgets('should display email and password fields', (tester) async {
//     // Arrange & Act
//     await tester.pumpWidget(createTestWidget(const LoginScreen()));

//     // Assert
//     expect(find.text('Email'), findsOneWidget);
//     expect(find.text('Password'), findsOneWidget);
//     expect(find.text('Welcome Back'), findsOneWidget);
//   });

//   testWidgets('should show validation error for invalid email', (tester) async {
//     // Arrange
//     await tester.pumpWidget(createTestWidget(const LoginScreen()));

//     // Act
//     final emailField = find.byType(TextFormField).first;
//     await tester.enterText(emailField, 'invalid-email');
//     await tester.tap(find.text('Login'));
//     await tester.pump();

//     // Assert
//     expect(find.text('Please enter a valid email'), findsOneWidget);
//   });

//   testWidgets('should toggle password visibility', (tester) async {
//     // Arrange
//     await tester.pumpWidget(createTestWidget(const LoginScreen()));

//     // Act
//     final passwordField = find.byType(TextFormField).last;
//     await tester.enterText(passwordField, 'password123');
//     await tester.tap(find.byIcon(Icons.visibility_outlined));
//     await tester.pump();

//     // Assert
//     expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
//   });

//   testWidgets('should call login when form is valid', (tester) async {
//     // Arrange
//     await tester.pumpWidget(createTestWidget(const LoginScreen()));

//     // Act
//     final emailField = find.byType(TextFormField).first;
//     final passwordField = find.byType(TextFormField).last;
//     await tester.enterText(emailField, 'user@example.com');
//     await tester.enterText(passwordField, 'P@ssw0rd!');
//     await tester.tap(find.text('Login'));
//     await tester.pump();

//     // Assert
//     verify(mockAuthCubit.login('user@example.com', 'P@ssw0rd!')).called(1);
//   });

//   testWidgets('should show loading overlay when state is AuthLoading',
//       (tester) async {
//     // Arrange
//     when(mockAuthCubit.state).thenReturn(AuthLoading());

//     // Act
//     await tester.pumpWidget(createTestWidget(const LoginScreen()));
//     await tester.pump();

//     // Assert
//     expect(find.byType(CircularProgressIndicator), findsWidgets);
//   });

//   testWidgets('should navigate to forgot password page', (tester) async {
//     // Arrange
//     await tester.pumpWidget(
//       MaterialApp(
//         routes: {
//           '/': (context) => BlocProvider<AuthCubit>.value(
//                 value: mockAuthCubit,
//                 child: const LoginScreen(),
//               ),
//           '/auth/forgot-password': (context) =>
//               const Scaffold(body: Text('Forgot Password')),
//         },
//       ),
//     );

//     // Act
//     await tester.tap(find.text('Forgot Password?'));
//     await tester.pumpAndSettle();

//     // Assert
//     expect(find.text('Forgot Password'), findsOneWidget);
//   });
// }
