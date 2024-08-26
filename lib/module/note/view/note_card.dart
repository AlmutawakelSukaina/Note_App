
import '/libs.dart';

class NoteCard extends StatelessWidget {

  final Map<String,dynamic> note;
  final VoidCallback onBack;
  const NoteCard({
    super.key, required this.note, required this.onBack,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextApp(
          text:  note[NoteFields.title],
            size: 18,

          ),
          8.ph,
          CustomTextApp(
            text:  note[NoteFields.content],
            size: 16,

          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: (){

                      context.pushPage(NoteAdd(
                        note: Note(
                          title: note[NoteFields.title],
                          content: note[NoteFields.content],
                          id: note[NoteFields.id],
                          isPinned: note[NoteFields.isPined],
                          archive: note[NoteFields.archive],
                          reminderTime: note[NoteFields.reminderTime],
                        ),
                      )).then((value){
                        onBack();
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.archive),
                    onPressed: (){},
                    color: note[NoteFields.archive]==1 ? Colors.grey : Colors.black,
                  ),
                ],
              ),
              IconButton(
                icon: Icon(note[NoteFields.isPined]==1 ? Icons.push_pin : Icons.push_pin_outlined),
                onPressed: (){},
                color: note[NoteFields.isPined]==1 ? Colors.blue : Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}