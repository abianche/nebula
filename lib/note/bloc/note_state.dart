part of 'note_bloc.dart';

@immutable
sealed class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];
}

final class NoteInitial extends NoteState {}

class DirectorySelected extends NoteState {
  final String directoryPath;

  const DirectorySelected(this.directoryPath);

  @override
  List<Object> get props => [directoryPath];
}

class NotesLoaded extends NoteState {
  final List<File> files;
  final String content;
  final bool hasContent;

  const NotesLoaded(this.files, {this.content = '', this.hasContent = false});

  @override
  List<Object> get props => [files, content, hasContent];
}
