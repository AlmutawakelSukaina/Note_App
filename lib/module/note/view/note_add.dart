import '../../../libs.dart';

class NoteAdd extends StatefulWidget {
  final Note? note;

  const NoteAdd({
    super.key,
    this.note,
  });

  @override
  State<NoteAdd> createState() => _NoteAddState();
}

class _NoteAddState extends State<NoteAdd> {
  final TextEditingController noteTitle = TextEditingController();
  final TextEditingController noteContent = TextEditingController();
  final TextEditingController noteTag = TextEditingController();
   final selectedValue = ValueNotifier<String?>(null);
   final refreshTag = ValueNotifier<bool>(false);
  final isPinned = ValueNotifier<bool>(false);
  final List<String> items = ['10 minutes', '1 hour', '1 day'];
  List<String> tags = [];
  List<String> removedTags = [];
  bool isEdit=false;
  final _formKey = GlobalKey<FormState>();
  void getTags()async
  {
    tags=await NoteDatabase.instance.getTagsByNoteId(widget.note!.id!);
    refreshTag.value=!refreshTag.value;
  }
  @override
  void initState() {
    super.initState();
    isEdit=widget.note!=null;
    if(isEdit)
      {
        noteTitle.text=widget.note!.title;
        noteContent.text=widget.note!.content;
        isPinned.value=widget.note?.isPinned==1;
        selectedValue.value=widget.note?.reminderTime;
        getTags();
      }

  }

  @override
  void dispose() {
    noteTitle.dispose();
    noteContent.dispose();
    noteTag.dispose();
    selectedValue.dispose();
    isPinned.dispose();
    refreshTag.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar:
          customAppBar(title: isEdit ? "Edit Note" : "Add Note"),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextField(
              textEditingController: noteTitle,
              hint: "Title",
              textInputType: TextInputType.text,
              validator: (String value) {
                if (value.isEmpty || value.length < 3) {
                  return "Note title must be greater than 3 character";
                }
              },
            ),
            20.ph,
            CustomTextField(
              textEditingController: noteContent,
              hint: "Content",
              textInputType: TextInputType.text,
              maxLines: 8,
              validator: (String value) {
                if (value.isEmpty) {
                  return "Note Content must not be empty";
                }
              },
            ),
            20.ph,
            ValueListenableBuilder(
              valueListenable: selectedValue,
              builder: (context, value, child) => DropdownButton<String>(
                value: value,
                hint: const CustomTextApp(
                  text: "Select reminder time",
                  colors: Colors.black38,
                  font: FontWeight.w700,
                ),
                underline: const Nothing(),
                onChanged: (newValue) {
                  selectedValue.value = newValue!;
                },
                items: items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
              ).symmetricPadding(0, 20).fullWidth().roundedWidget(),
            ),
            20.ph,
            StatefulBuilder(builder: (context, setState) {
              return Column(
                children: [
                  CustomTextField(
                    textEditingController: noteTag,
                    hint: "Note tag",
                    textInputType: TextInputType.text,
                    suffixIcon: const Icon(Icons.add).onTap(() {
                      addTag(setState);
                    }),
                  ),
                  10.ph,
                  ValueListenableBuilder(valueListenable: refreshTag,
                    builder: (context, value, child) {
                    return   Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: tags.map((tag) {
                        return Chip(
                          label: CustomTextApp(text: tag),
                          backgroundColor: AppColors.white,
                          deleteIcon: const Icon(Icons.delete),
                          onDeleted: () {
                            int index = tags.indexOf(tag);

                            setState(() {
                              tags.removeAt(index);
                              removedTags.add(tag);
                            });
                          },
                        );
                      }).toList(),
                    );

                  },)

                ],
              );
            }),
            20.ph,
            CustomAppCheckBox(
              checkBox: isPinned,
              title: 'Pin Note',
            ),
            20.ph,
            CustomButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final note = Note(

                      id:widget.note?.id,
                      title: noteTitle.text,
                      content: noteContent.text,
                      isPinned: isPinned.value ? 1 : 0,
                      reminderTime: selectedValue.value,
                      archive: widget.note?.archive
                    );
                       await Future.wait([

                       if (tags.isNotEmpty)
                        NoteDatabase.instance
                          .insertNoteWithTags(note, tags),
                        if(tags.isEmpty)
                          NoteDatabase.instance.insertNote(
                            note,
                          ),
                         if(isEdit &&removedTags.isNotEmpty)
                           NoteDatabase.instance.deleteTagsByNoteIdAndTags(
                             widget.note!.id!,
                             removedTags
                           )
                         ,
                       ]);


                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: CustomTextApp(
                        text: "Note ${isEdit?"Edited":"Added"} successfully.",
                        colors: AppColors.white,
                      )),
                    );
                    context.pushReplacementName(AppRoutes.viewNote);
                  }
                },
                text: "Save")
          ],
        ).symmetricPadding(10, 20),
      )),
    );
  }

  void addTag(Function setState) {
    String trimmedTag = noteTag.text.trim(); // Trim leading/trailing whitespace

    if (trimmedTag.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: CustomTextApp(
          text: 'Please enter a tag.',
          colors: AppColors.white,
        )),
      );
      return;
    }

    if (tags.contains(trimmedTag)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: CustomTextApp(
          text: 'Tag already exists.',
          colors: AppColors.white,
        )),
      );
      return;
    }

    setState(() {
      tags.add(trimmedTag);
      noteTag.clear();
    });
  }
}
