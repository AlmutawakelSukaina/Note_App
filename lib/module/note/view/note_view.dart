


import '../../../libs.dart';

class NoteViewPage extends StatefulWidget {
  const NoteViewPage({super.key});

  @override
  State<NoteViewPage> createState() => _NoteViewPageState();
}

class _NoteViewPageState extends State<NoteViewPage> {
  final TextEditingController searchNote = TextEditingController();
   final responseNote=ValueNotifier<Future?>(null);
  final responseNotTag=ValueNotifier<Future?>(null);
  Map<int,List> tagNote={};
  String?currentTag;


  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  void dispose() {
    searchNote.dispose();
    responseNote.dispose();
    responseNotTag.dispose();
    super.dispose();
  }

  void _fetchData() {
    responseNotTag.value =  NoteDatabase.instance.getAllTags();
  }
  void _fetchTag(String ?tag) {
    Future.delayed(Duration.zero,() {
      responseNote.value =  NoteDatabase.instance.getNotesByTag(tag??"");

    },);
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              context.pushName(AppRoutes.addNote);
            },
            backgroundColor: AppColors.orange,
            child: Icon(
              Icons.add,
              color: AppColors.white,
            ),
          ),
          body:ValueListenableBuilder(valueListenable: responseNotTag,builder: (context, value, child) {
            return  FutureBuilder(
                future: value,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const LoadingIndicator();
                  } else if (snapshot.data.isEmpty ) {
                    return const Center(
                      child: CustomTextApp(
                        text: "No Data Found",
                        size: 20,
                      ),
                    );
                  } else {
                    if(currentTag==null) {
                      currentTag=snapshot.data[0][TageTable.tag];
                      _fetchTag(currentTag);
                    }


                    return DefaultTabController(
                        length: snapshot.data.length,
                        child: Column(
                          children: [
                            Container(
                              color: AppColors.backgroundColor,

                              child: TabBar(
                                labelColor: AppColors.white,
                                tabAlignment: TabAlignment.start,

                                unselectedLabelColor: Colors.grey,
                                dividerColor: AppColors.white,
                                isScrollable: true,
                                labelStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: appFont,
                                    color: AppColors.white),
                                onTap: (int index){
                                  currentTag=snapshot.data[index][TageTable.tag];

                                  _fetchTag(currentTag);
                                },
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.orange[50],
                                ),
                                tabs: [
                                  for (Map tag in snapshot.data)
                                    Tab(
                                      child: CustomTextApp(
                                        text: tag[TageTable.tag],
                                        size: 24,
                                      ).symmetricPadding(0, 5),
                                    ),
                                ],
                              ),
                            ),
                            2.ph,

                            ValueListenableBuilder(valueListenable: responseNote,

                              builder: (context, value, child) {
                                return  FutureBuilder(future: value, builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const LoadingIndicator();
                                  } else if (snapshot.data.isEmpty
                                  ) {
                                    return const Center(
                                      child: CustomTextApp(
                                        text: "No Data Found",
                                        size: 20,
                                      ),
                                    );
                                  }else
                                  {
                                    return Expanded(
                                      child: NoteList(noteList:snapshot.data, onBack: () {
                                       currentTag=null;
                                        _fetchData();
                                      } ,),
                                    );
                                  }
                                },);
                              },)

                          ],
                        ).symmetricPadding(10, 20));
                  }
                });
          },)),
    );
  }
}
