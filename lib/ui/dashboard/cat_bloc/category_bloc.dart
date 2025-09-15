
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/remote/models/cat_model.dart';
import '../../../data/remote/repositories/cat_repo.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState>
{
  CatRepo catRepo;

  CategoryBloc({required this.catRepo}):
        super(CategoryInitialState()){
          on<CategoryFetchEvent>((event, emit) async {
            emit(CategoryLoadingState());
            try {
              dynamic mData = await catRepo.fetchCategories();
              if (mData['status']) {
                CatDataModel catDataModel = CatDataModel.fromJson(mData);
                print(catDataModel.data);
                emit(CategoryLoadedState(allCategories: catDataModel.data ?? []));
              } else {
                emit(CategoryErrorState(errorMsg: mData['message']));
              }
            } catch (e) {
              emit(CategoryErrorState(errorMsg: e.toString()));
            }
          });

        }

}