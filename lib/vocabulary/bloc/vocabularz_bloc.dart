
import 'package:bloc/bloc.dart';
import 'package:language_partner/main.dart';
import 'package:language_partner/vocabulary/models/word.dart';
import 'package:language_partner/vocabulary/repo/vocabulary_repo.dart';
import 'package:meta/meta.dart';

part 'vocabularz_event.dart';
part 'vocabularz_state.dart';

class VocabularyBloc extends Bloc<VocabularyEvent, VocabularyState> {

  final VocabularyRepo repo;

  VocabularyBloc(this.repo) : super(VocabularyInitial()) {
    on<RequestNormal>((event, emit) async {
      List<Word>? words = await repo.getVocabulary(UserId.userId); // TODO: change when auth has been implemented
      words == null
          ? emit(LoadingFailed())
          : emit(LoadingSuccess(words));
    });

    on<AddWords>((event, emit) {
      // further action is unnecessary, because the event is only being called in the chat
      repo.addWords(event.message, event.userId);
    });

  }
}
