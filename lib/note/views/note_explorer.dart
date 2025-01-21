import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nebula/note/bloc/note_bloc.dart';

class NoteExplorer extends StatelessWidget {
  const NoteExplorer({super.key});

  Future<void> _pickDirectory(BuildContext context) async {
    final directoryPath = await getDirectoryPath(confirmButtonText: 'Select Directory');
    if (directoryPath != null) {
      context.read<NoteBloc>().add(LoadNotes(directoryPath));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nebula')),
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          if (state is NoteInitial) {
            return Center(
              child: ElevatedButton(
                onPressed: () => _pickDirectory(context),
                child: Text('Pick Directory'),
              ),
            );
          }

          if (state is NotesLoaded) {
            final files = state.files;
            final content = state.hasContent ? state.content : 'Select a note to view content';

            return Row(
              children: [
                // Left: File List
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    itemCount: files.length,
                    itemBuilder: (context, index) {
                      final file = files[index];
                      return ListTile(
                        title: Text(file.path.split('/').last),
                        onTap: () {
                          context.read<NoteBloc>().add(LoadContent(file));
                        },
                      );
                    },
                  ),
                ),
                // Right: File Content Viewer
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      content,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            );
          }

          // Default to a loading spinner if in an unexpected state
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
