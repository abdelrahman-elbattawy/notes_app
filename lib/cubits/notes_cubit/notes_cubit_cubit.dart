import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/models/note_model.dart';

part 'notes_cubit_state.dart';

class NotesCubit extends Cubit<NotesCubitState> {
  NotesCubit() : super(NotesCubitInitial());

  List<NoteModel>? notesList;

  fetchAllNotes() async {
    Box<NoteModel> notesBox = Hive.box<NoteModel>(kNotesBox);

    notesList = notesBox.values.toList();
  }
}
