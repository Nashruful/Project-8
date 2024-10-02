import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:onze_cofe_project/data_layer/data_layer.dart';
import 'package:onze_cofe_project/setup/setup_init.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final supabase = getIt.get<DataLayer>().supabase;
  List<Map<String, dynamic>> items = [];
  HomeBloc() : super(HomeInitial()) {
    on<LoadScreenEvent>((event, emit) async {
      emit(LoadingState());
      try {
        final productIDResponse = await supabase.from("product").select();

        items = List<Map<String, dynamic>>.from(productIDResponse);

        emit(SuccessState());
      } on FormatException catch (e) {
        emit(ErrorState());
        // emit(ErrorState(msg: e.message));
      } catch (e) {
        emit(ErrorState());
        // emit(ErrorState(msg: e.toString()));
      }
    });
  }
}
