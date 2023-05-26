
import 'package:bloc/bloc.dart';
import 'package:language_partner/vocabulary/vocabulary_content.dart';
import 'package:meta/meta.dart';

part 'vocabularz_event.dart';
part 'vocabularz_state.dart';

class VocabularyBloc extends Bloc<VocabularyEvent, VocabularyState> {
  VocabularyBloc() : super(VocabularyInitial()) {
    on<RequestNormal>((event, emit) async {
      List<Word>? words = await VocabularyContent.getVocabulary();
      words == null
          ? emit(LoadingFailed())
          : emit(LoadingSuccess(words));
    });
    on<RequestParam>((event, emit) async {
      List<Word>? words = await VocabularyContent.addWords(event.word.toJson());
      words == null
          ? emit(LoadingFailed())
          : emit(LoadingSuccess(words));
    });
  }
}
