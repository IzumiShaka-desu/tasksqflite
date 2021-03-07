
import 'package:flutter/material.dart';
import 'package:tasksqflite/components/atoms/text_subtitle_widget.dart';
import 'package:tasksqflite/components/organisms/form_default.dart';
import 'package:tasksqflite/constant/color_pallete.dart';
import 'package:tasksqflite/core/data/models/pegawai.dart';

class AddFloatingActionButton extends StatelessWidget {
  final Function(dynamic newWorker) function;
  const AddFloatingActionButton({
    Key key, this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
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
                              TextSubtitleWidget(text: 'Tambah Pegawai'),
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
                                    function(newWorker);
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
      backgroundColor: ColorPallete.primary,
    );
  }
}
