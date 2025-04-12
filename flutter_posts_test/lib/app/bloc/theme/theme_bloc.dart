import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts_test/app/bloc/theme/theme_event.dart';
import 'package:flutter_posts_test/app/bloc/theme/theme_state.dart';
import 'package:flutter_posts_test/app/repository/theme_repository/theme_repository.dart';
import 'package:flutter_posts_test/app/shared/either/either_extensions.dart';
import 'package:flutter_posts_test/app/shared/enum/theme_enum.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final ThemeRepository themeRepository;
  ThemeBloc({required this.themeRepository}) : super(ThemeInitial()) {
    on<ChangeTheme>(_onChangeTheme);
    on<LoadTheme>(_onLoadTheme);

    add(LoadTheme());
  }
  
  Future<void> _onChangeTheme(ChangeTheme event, Emitter<ThemeState> emit) async {
    emit(ThemeLoaded(event.themeEnum));
    await themeRepository.setTheme(event.themeEnum);
  } 

  Future<void> _onLoadTheme(LoadTheme event, Emitter<ThemeState> emit) async {
    final either = await themeRepository.getTheme();
    if (either.isLeft) {
      emit(ThemeLoaded(ThemeEnum.darkMode));
      return;
    }
    emit(ThemeLoaded(either.right!));
  }
}