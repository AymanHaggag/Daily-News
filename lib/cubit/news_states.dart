abstract class NewsStates{}

class InitialState extends NewsStates {}

class ChangeCurrentIndexState extends NewsStates{}

class NewsBusinessLoadingState extends NewsStates{}

class NewsGetBusinessSuccessfulState extends NewsStates{}

class NewsGetBusinessErrorState extends NewsStates{}

class NewsTechLoadingState extends NewsStates{}

class NewsGetTechSuccessfulState extends NewsStates{}

class NewsGetTechErrorState extends NewsStates{}

class NewsSportsLoadingState extends NewsStates{}

class NewsGetSportsSuccessfulState extends NewsStates{}

class NewsGetSportsErrorState extends NewsStates{}

class AllNewsLoadingState extends NewsStates{}

class AllNewsGetSuccessfulState extends NewsStates{}

class ChangeThemeModeState extends NewsStates{}

class NewsSearchLoadingState extends NewsStates{}

class NewsGetSearchSuccessfulState extends NewsStates{}

class NewsGetSearchErrorState extends NewsStates{}




