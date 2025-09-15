import '../../../data/remote/models/cat_model.dart';

abstract class CategoryState{}
class CategoryInitialState extends CategoryState{}
class CategoryLoadingState extends CategoryState{}
class CategoryLoadedState extends CategoryState{
  List<CatModel> allCategories;
  CategoryLoadedState({required this.allCategories});
}
class CategoryErrorState extends CategoryState{
  String errorMsg;
  CategoryErrorState({required this.errorMsg});
}