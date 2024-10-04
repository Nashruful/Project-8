import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:onze_cofe_project/data_layer/data_layer.dart';
import 'package:onze_cofe_project/setup/setup_init.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final supabase = getIt.get<DataLayer>().supabase;
  List names = [];
  List filteredNames = [];
  String searchQuery = 'matc';
  String? selectedFilter = 'All';
  List<Map<String, dynamic>> items = [];
  HomeBloc() : super(HomeInitial()) {
    //will load first when landing on home screen
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
    //

    on<SearchEvent>((event, emit) async {
      emit(LoadingState());
      try {
        names = await supabase.from('product').select('names');
        filteredNames = names.where((e) => e.contains(searchQuery)).toList();

        emit(SuccessState());
      } on FormatException catch (e) {
        emit(ErrorState());
        // emit(ErrorState(msg: e.message));
      } catch (e) {
        emit(ErrorState());
        // emit(ErrorState(msg: e.toString()));
      }
    });



///search 
    on<FilterSelectedEvent>((event, emit) async {
      emit(LoadingState());
      try {
        final productIDResponse = await supabase
            .from("product")
            .select()
            .eq("category", event.selectedFilter);

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
