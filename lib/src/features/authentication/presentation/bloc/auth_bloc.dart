import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sarang_app/src/features/likes_you/data/data_user_account_local.dart';
import 'package:sarang_app/src/features/likes_you/domain/user_account.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<RegisterAuthEvent>((event, emit) async {
      //ketika tombol get started ditekan authloading jalan untuk progress indicator
      emit(AuthLoading());
      //lalu disimpen kelocal storage
      DataUserAccountLocal.setDataUserAccountToStorage(event.userAccount);
      UserAccountRegister.setUserAccountRegister(event.isRegister);
      //delay seakan akan lagi menyimpan ke database 
      await Future.delayed(Duration(seconds: 2));
      //mengembalikan state yang sukses disimpan diregister
      emit(
        AuthSucces(
          userAccount: event.userAccount, 
          isRegister: event.isRegister,
        ),
      );
    });
  }
}
