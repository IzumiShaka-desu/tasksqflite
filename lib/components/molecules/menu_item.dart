
import 'package:flutter/material.dart';
import 'package:tasksqflite/constant/color_pallete.dart';

class MenuItemDefault extends StatelessWidget {
  const MenuItemDefault({
    Key key,
    @required this.ontap,
    @required this.icon,
    @required this.label, this.isActive=false,

  }) : super(key: key);
  final Widget icon;
  final bool isActive;
  final Function ontap;
  final String label;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon ?? SizedBox(),
      onTap: ontap,
      hoverColor: Colors.grey,
      tileColor:isActive??false?Colors.grey.withOpacity(0.3): null,
      title: Text(
        label ?? "",
        style: Theme.of(context)
            .textTheme
            .bodyText2
            .copyWith(color: ColorPallete.backgroundLight,fontWeight: FontWeight.w600),
      ),
    );
  }
}
