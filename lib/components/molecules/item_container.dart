import 'package:flutter/material.dart';
import 'package:tasksqflite/constant/color_pallete.dart';
import 'package:tasksqflite/core/data/models/pegawai.dart';
import 'package:tasksqflite/core/ui/viewmodel/main_viewmodel.dart';

class ItemContainer extends StatelessWidget {
  const ItemContainer({
    Key key,
    @required this.item,
    this.provider,
    this.index,
    this.trailing,
  }) : super(key: key);

  final Pegawai item;
  final int index;
  final MainViewModel provider;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    var txtTheme = Theme.of(context).textTheme;
    return Card(
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text(
          item.nama,
          style: txtTheme.bodyText1.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 17,
          ),
        ),
        trailing: trailing ?? SizedBox(),
      ),
      color: ColorPallete.backgroundLight,
    );
  }
}
