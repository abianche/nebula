import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc() : super(NoteInitial()) {
    on<LoadNotes>(_onLoadNotes);
    on<LoadContent>(_onLoadContent);
  }

  void _onLoadNotes(LoadNotes event, Emitter<NoteState> emit) {
    final dir = Directory(event.directoryPath);
    if (dir.existsSync()) {
      final files = dir.listSync().where((file) => file.path.endsWith('.md')).map((e) => File(e.path)).toList();
      emit(NotesLoaded(files, hasContent: false));
    } else {
      emit(NotesLoaded([], hasContent: false));
    }
  }

  void _onLoadContent(LoadContent event, Emitter<NoteState> emit) async {
    if (state is NotesLoaded) {
      final files = (state as NotesLoaded).files;
      try {
        final content = await event.file.readAsString();
        emit(NotesLoaded(files, content: content, hasContent: true));
      } catch (e) {
        emit(NotesLoaded(files, content: 'Error loading file content', hasContent: true));
      }
    }
  }
}
