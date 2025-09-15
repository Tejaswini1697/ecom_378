
import 'package:ecom_378/ui/sign_up/bloc/user_event.dart';
import 'package:ecom_378/ui/sign_up/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/remote/repositories/user_repo.dart';
import '../../../domain/constants/app_constants.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserRepo userRepo;

  UserBloc({required this.userRepo}) : super(UserInitialState()) {
    on<UserRegisterEvent>((event, emit) async {
      emit(UserLoadingState());

      try {
       dynamic mData = await userRepo.registerUser(
          email: event.email,
          name: event.name,
          mobNo: event.mobNo,
          password: event.password,
        );

       if(mData["status"]) {
         print(mData["token"]);
         emit(UserSuccessState());
       } else {
         emit(UserFailureState(errorMsg: mData["message"]));
       }

      } catch (e) {
        emit(UserFailureState(errorMsg: e.toString()));
      }
    });

    on<UserLoginEvent>((event, emit) async{
      emit(UserLoadingState());

      try{

       dynamic mData = await userRepo.loginUser(email: event.email, password: event.pass);

       if(mData["status"]){
         emit(UserSuccessState());
         SharedPreferences prefs = await SharedPreferences.getInstance();
         prefs.setString(AppConstants.PREF_KEY_USER_TOKEN, mData["tokan"]);
       } else {
         emit(UserFailureState(errorMsg: mData["message"]));
       }

      } catch (e){
        emit(UserFailureState(errorMsg: e.toString()));
      }

    });
  }
}
