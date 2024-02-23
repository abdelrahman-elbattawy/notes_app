import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/views/widgets/colors_list_view.dart';
import 'package:notes_app/views/widgets/custom_button.dart';
import 'package:notes_app/views/widgets/custom_text_field.dart';

class AddNoteForm extends StatefulWidget {
  const AddNoteForm({
    super.key,
  });

  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  String? title;
  String? subTitle;

  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        children: [
          const SizedBox(
            height: 32,
          ),
          CustomFormTextField(
            onSaved: (value) => title = value,
            hintText: 'Title',
          ),
          const SizedBox(
            height: 16,
          ),
          CustomFormTextField(
            onSaved: (value) => subTitle = value,
            hintText: 'Content',
            maxLines: 5,
          ),
          const SizedBox(
            height: 32,
          ),
          const ColorListView(),
          const SizedBox(
            height: 32,
          ),
          BlocBuilder<AddNoteCubit, AddNoteState>(
            builder: (context, state) {
              return CustomButton(
                isLoading: state is AddNoteLoading ? true : false,
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();

                    addNote(context);
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
                title: 'Add',
              );
            },
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }

  void addNote(BuildContext context) {
    DateTime currentDate = DateTime.now();
    String formattedCurrentDate = DateFormat.yMMMd().format(currentDate);

    NoteModel noteModel = NoteModel(
      title: title!,
      subTitle: subTitle!,
      date: formattedCurrentDate,
      color: Colors.blue.value,
    );

    BlocProvider.of<AddNoteCubit>(context).addNote(noteModel);
  }
}
