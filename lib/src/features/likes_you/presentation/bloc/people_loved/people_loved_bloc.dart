import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sarang_app/src/features/authentication/data/data_match_dummy.dart';
import 'package:sarang_app/src/features/authentication/domain/user.dart';
import 'package:flutter/cupertino.dart';

part 'people_loved_event.dart';
part 'people_loved_state.dart';

class PeopleLovedBloc extends Bloc<PeopleLovedEvent, PeopleLovedState> {
  PeopleLovedBloc() : super(PeopleLovedInitial()) {
    on<OnPeopleLovedEventCalled>((event, emit) async {
      emit(PeopleLovedLoading());
      await Future.delayed( const Duration(seconds: 1));
      emit(PeopleLovedLoaded(userMatch: dataMatchDummy));
    });

    on<AddPeopleLoved>((event, emit){
      emit(PeopleLovedLoading());
      dataMatchDummy.add(event.user);
      emit(PeopleLovedLoaded(userMatch: dataMatchDummy));
    });
  }
}
