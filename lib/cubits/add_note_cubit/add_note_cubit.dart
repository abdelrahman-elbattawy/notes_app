import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/models/note_model.dart';

part 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit() : super(AddNoteInitial());

  Color color = kColors[0];

  addNote(NoteModel note) async {
    emit(AddNoteInitial());
    try {
      var notesBox = Hive.box<NoteModel>(kNotesBox);
      note.color = color.value;
      notesBox.add(note);
      emit(AddNoteSuccess());
    } catch (e) {
      emit(AddNoteFaliure(errMessage: e.toString()));
    }
  }
}
