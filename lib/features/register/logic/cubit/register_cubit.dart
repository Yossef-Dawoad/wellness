import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellness/core/utils/types/networking_error_types.dart';
import 'package:wellness/features/register/data/models/register_request_body.dart';

import '../../data/repo/register_repo.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepo _registerRepo;
  RegisterCubit(this._registerRepo) : super(RegisterInitial());

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void emitRegisterStates() async {
    emit(RegisterLoading());

    final response = await _registerRepo.register(
      RegisterRequestBody(
        userName: userNameController.text,
        password: passwordController.text,
        email: emailController.text,
      ),
    );

    response.fold((error) {
      final errorType = NetworkErrorHandler.handle(error);
      final errorMessage = NetworkErrorHandler.getErrorMessage(errorType);
      emit(RegisterError(error: errorMessage));
    }, (response) => emit(RegisterSuccess(data: response)));
  }
}
