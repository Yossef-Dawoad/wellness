import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/login_request_body.dart';
import '../../data/repo/login_repo.dart';
import 'login_state.dart';
import 'package:wellness/core/utils/types/networking_error_types.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;
  LoginCubit(this._loginRepo) : super(LoginInitial());

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void emitLoginStates() async {
    emit(LoginLoading());

    final response = await _loginRepo.login(
      LoginRequestBody(
        username: userNameController.text,
        password: passwordController.text,
      ),
    );

    response.fold((error) {
      final errorType = NetworkErrorHandler.handle(error);
      final errorMessage = NetworkErrorHandler.getErrorMessage(errorType);
      emit(LoginError(error: errorMessage));
    }, (response) => emit(LoginSuccess(data: response)));
  }
}
