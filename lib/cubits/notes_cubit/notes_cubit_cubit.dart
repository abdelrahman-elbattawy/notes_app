import 'package:bloc/bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/models/note_model.dart';

part 'notes_cubit_state.dart';

class NotesCubit extends Cubit<NotesCubitState> {
  NotesCubit() : super(NotesCubitInitial());

  fetchAllNotes() async {
    try {
      Box<NoteModel> notesBox = Hive.box<NoteModel>(kNotesBox);

      List<NoteModel> notesList = notesBox.values.toList();
      emit(NotesCubitSuccess(notesList: notesList));
    } catch (e) {
      emit(NotesCubitFailure(errMessage: e.toString()));
    }
  }
}
