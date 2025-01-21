part of 'note_bloc.dart';

@immutable
sealed class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

class LoadNotes extends NoteEvent {
  final String directoryPath;

  const LoadNotes(this.directoryPath);

  @override
  List<Object> get props => [directoryPath];
}

class LoadContent extends NoteEvent {
  final File file;
  const LoadContent(this.file);

  @override
  List<Object> get props => [file];
}
