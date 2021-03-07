import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasksqflite/components/atoms/text_subtitle_widget.dart';
import 'package:tasksqflite/components/molecules/item_container.dart';
import 'package:tasksqflite/components/organisms/add_floating_action_button.dart';
import 'package:tasksqflite/components/organisms/form_default.dart';
import 'package:tasksqflite/constant/color_pallete.dart';
import 'package:tasksqflite/core/data/models/pegawai.dart';
import 'package:tasksqflite/core/ui/viewmodel/main_viewmodel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _key = GlobalKey<AnimatedListState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.backgroundLight,
      body: Container(
        padding: EdgeInsets.all(10),
        child: Consumer<MainViewModel>(
          builder: (context, provider, child) {
            List<Pegawai> workers = provider.workers;
            if (workers == null) {
              provider.loadWorkersList();
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if ((workers?.length ?? 0) < 1) {
              return Center(
                child:
                    TextSubtitleWidget(text: "maaf data pegawai masih kosong"),
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Container(
                    child: SingleChildScrollView(
                      child: AnimatedList(
                        shrinkWrap: true,
                        reverse: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(8),
                        key: _key,
                        initialItemCount: workers.length,
                        itemBuilder: (BuildContext context, int index, anim) {
                          Pegawai item = workers[index];
                          return _buildItem(anim, item, provider, index);
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            );
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AddFloatingActionButton(
          function: (newWorker) => addTask(newWorker),
        ),
      ),
    );
  }

  Widget _buildItem(
    Animation<double> anim,
    Pegawai item,
    MainViewModel provider,
    int index,
  ) {
    return ScaleTransition(
      scale: anim,
      child: ItemContainer(
        item: item,
        provider: provider,
        index: index,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () => showGeneralDialog(
                context: context,
                transitionDuration: Duration(milliseconds: 400),
                pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  String gender = "laki-laki";
                  return ScaleTransition(
                    scale: animation,
                    child: Material(
                      child: SafeArea(
                        child: StatefulBuilder(
                          builder: (BuildContext context,
                                  void Function(void Function()) setState) =>
                              Container(
                            color: ColorPallete.backgroundLight,
                            width: double.infinity,
                            height: double.infinity,
                            child: Stack(children: [
                              Positioned.fill(
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 50,
                                      ),
                                      TextSubtitleWidget(
                                          text: 'detail Pegawai'),
                                      Container(
                                        child: FormDefault(
                                          field: [
                                            'nama',
                                            'alamat',
                                            'email',
                                            'phone',
                                            'divisi',
                                            'jabatan',
                                          ],
                                          defaultValue: (item
                                              .toJson()
                                              .map<String, String>(
                                                (key, value) => MapEntry(
                                                  key,
                                                  value.toString(),
                                                ),
                                              )),
                                          submitButtonLabel: "update data",
                                          fieldtypeNumber: ['phone'],
                                          customField: [
                                            Row(
                                              children: [
                                                Radio<String>(
                                                  value: 'laki-laki',
                                                  groupValue: gender,
                                                  onChanged: (val) {
                                                    setState(
                                                      () {
                                                        gender = val;
                                                      },
                                                    );
                                                  },
                                                ),
                                                Text('laki-laki'),
                                                SizedBox(width: 5),
                                                Radio<String>(
                                                  value: 'perempuan',
                                                  groupValue: gender,
                                                  onChanged: (val) {
                                                    setState(
                                                      () {
                                                        gender = val;
                                                      },
                                                    );
                                                  },
                                                ),
                                                Text('perempuan'),
                                              ],
                                            )
                                          ],
                                          onSubmit: (result) {
                                            result['gender'] = gender;
                                            Pegawai newWorker =
                                                Pegawai.fromJson(result);
                                            update(newWorker);
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 100,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Transform.scale(
                                    scale: 0.7,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.close_outlined,
                                          size: 30,
                                        ),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _removeTask(index);
              },
            ),
          ],
        ),
      ),
    );
  }

  addTask(newTask) {
    var provider = Provider.of<MainViewModel>(context, listen: false);
    provider
        .addWorkers(
      newTask,
      context,
    )
        .then((value) {
      provider.refresh();

      int index = provider.workers.indexOf(provider.workers.last);
      _key.currentState.insertItem(index);
    });
  }

  showSnackbar(String _msg) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 3),
          backgroundColor: Colors.grey,
          content: Material(
            type: MaterialType.transparency,
            child: Container(
              height: 50,
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _msg,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  _removeTask(int index) async {
    var provider = Provider.of<MainViewModel>(context, listen: false);
    Pegawai deletedTask = await provider.deleteWorkers(index, context);
    if (deletedTask != null) {
      _key.currentState.removeItem(
        index,
        (context, anim) => _buildItem(
          anim,
          deletedTask,
          provider,
          index,
        ),
      );
      provider.loadWorkersList();
    }
  }

  void update(Pegawai newWorker) async {
    var provider = Provider.of<MainViewModel>(context, listen: false);
    await provider.updateWorkers(newWorker, context);
    await provider.loadWorkersList();
  }
}
