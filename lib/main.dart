import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_pratice/core/app_colors.dart';
import 'package:hello_pratice/core/app_input_themes.dart';
import 'package:hello_pratice/core/app_text_styles.dart';
import 'package:hello_pratice/features/auth/application/bloc/auth_bloc.dart';
import 'package:hello_pratice/features/auth/application/usecases/check_user_role_usecase.dart';
import 'package:hello_pratice/features/auth/application/usecases/login_usecase.dart';
import 'package:hello_pratice/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:hello_pratice/features/auth/infrastructure/auth_repository_impl.dart';
import 'package:hello_pratice/features/auth/presentation/screens/login_screen.dart';
import 'package:hello_pratice/features/centers/Infrastructure/center_repository_impl.dart';
import 'package:hello_pratice/features/centers/application/bloc/center_bloc.dart';
import 'package:hello_pratice/features/centers/application/usecases/add_center_usecase.dart';
import 'package:hello_pratice/features/centers/application/usecases/delete_center_usecase.dart';
import 'package:hello_pratice/features/centers/application/usecases/edit_center_usecase.dart';
import 'package:hello_pratice/features/centers/application/usecases/get_all_centers_usecase.dart';
import 'package:hello_pratice/features/centers/application/usecases/get_center_details_usecase.dart';
import 'package:hello_pratice/features/centers/application/usecases/make_phone_call_usecase.dart';
import 'package:hello_pratice/features/centers/application/usecases/pick_image_usecase.dart';
import 'package:hello_pratice/features/centers/application/usecases/pick_location_usecase.dart';
import 'package:hello_pratice/features/centers/application/usecases/search_centers_usecase.dart';
import 'package:hello_pratice/features/centers/application/usecases/search_location_usecase.dart';
import 'package:hello_pratice/features/centers/domain/repositories/i_center_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<IAuthRepository>(
          create: (context) => AuthRepositoryImpl(),
        ),
        RepositoryProvider<ICenterRepository>(
          create: (context) => CenterRepositoryImpl(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              loginUsecase: LoginUsecase(context.read<IAuthRepository>()),
              checkUserRoleUsecase: CheckUserRoleUsecase(
                context.read<IAuthRepository>(),
              ),
            ),
          ),
          BlocProvider(
            create: (context) => CenterBloc(
              pickLocationUseCase: PickLocationUseCase(
                context.read<ICenterRepository>(),
              ),
              deleteCenterUsecase: DeleteCenterUsecase(
                context.read<ICenterRepository>(),
              ),
              centersUsecase: GetAllCentersUsecase(
                context.read<ICenterRepository>(),
              ),
              addCenterUseCase: AddCenterUseCase(
                context.read<ICenterRepository>(),
              ),
              editCenterUsecase: EditCenterUsecase(
                context.read<ICenterRepository>(),
              ),
              getCenterDetailsUsecase: GetCenterDetailsUsecase(
                context.read<ICenterRepository>(),
              ),
              searchCentersUsecase: SearchCentersUsecase(
                context.read<ICenterRepository>(),
              ),
              makePhoneCallUseCase: MakePhoneCallUseCase(
                context.read<ICenterRepository>(),
              ),
              pickImageUseCase: PickImageUseCase(
                context.read<ICenterRepository>(),
              ),
              searchLocationUsecase: SearchLocationUsecase(
                context.read<ICenterRepository>(),
              ),
            ),
          ),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundPrimary,
        inputDecorationTheme: AppInputThemes.inputDecorationTheme,
        textTheme: TextTheme(
          headlineLarge: AppTextStyles.headlineLarge,
          bodyLarge: AppTextStyles.bodyLarge,
          headlineSmall: AppTextStyles.headlineSmal,
          bodySmall: AppTextStyles.bodySmall,
          bodyMedium: AppTextStyles.bodyMeduim,
        ),
      ),
      home: LoginScreen(),
    );
  }
}
