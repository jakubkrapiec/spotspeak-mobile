import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'friends_tab_event.dart';
part 'friends_tab_state.dart';

class FriendsTabBlocBloc extends Bloc<FriendsTabBlocEvent, FriendsTabBlocState> {
  FriendsTabBlocBloc() : super(FriendsTabBlocInitial()) {
    on<FriendsTabBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
