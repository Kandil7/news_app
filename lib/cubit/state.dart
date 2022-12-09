abstract class NewsState {}

class NewsInitialState extends NewsState {}

class NewsBottomNavBarState extends NewsState {}

class NewsGetBusinessLoadingState extends NewsState {}

class NewsGetBusinessSuccessfulState extends NewsState {}

class NewsGetBusinessErrorState extends NewsState {
  final String? error;
  NewsGetBusinessErrorState(this.error);
}

class NewsGetScienceLoadingState extends NewsState {}

class NewsGetScienceSuccessfulState extends NewsState {}

class NewsGetScienceErrorState extends NewsState {
  final String? error;
  NewsGetScienceErrorState(this.error);
}

class NewsGetSportLoadingState extends NewsState {}

class NewsGetSportSuccessfulState extends NewsState {}

class NewsGetSportErrorState extends NewsState {
  final String? error;
  NewsGetSportErrorState(this.error);
}
class NewsChangeAppModeState extends NewsState{}

class NewsSearchState extends NewsState{}
class NewsSearchLoadingState extends NewsState{}
class NewsSearchErrorState extends NewsState{
  final String? error;
  NewsSearchErrorState(this.error);
}