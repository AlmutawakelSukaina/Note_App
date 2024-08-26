


import 'package:note_app/module/note/view/note_card.dart';

import '../../../../libs.dart';

class NoteList extends StatelessWidget {
final List noteList;
final VoidCallback onBack;
  const NoteList({
    super.key, required this.noteList, required this.onBack,

  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: <Widget>[

        SliverList(
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return NoteCard(note: noteList[index] ,onBack:onBack ).containerWithBorderSide(
                  AppColors.colorsEvent[index % 5]).symmetricPadding(2, 4).
              onTap((){

              });
            },
            childCount: noteList.length, // Number of items in the list
          ),
        ),
      SliverToBoxAdapter(
        child: 20.ph,
      )
    ]);
  }
}
