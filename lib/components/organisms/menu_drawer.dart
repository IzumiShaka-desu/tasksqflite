
import 'package:flutter/material.dart';
import 'package:tasksqflite/constant/color_pallete.dart';
import 'package:tasksqflite/core/ui/viewmodel/main_viewmodel.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({
    Key key,
    @required this.size,
    this.provider,
    this.menu,
  }) : super(key: key);
  final MainViewModel provider;
  final Size size;
  final List<Widget> menu;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.5,
      child: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 15),
            Center(
              child: Container(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: CircleAvatar(
                    minRadius: 35,
                    maxRadius: 40,
                    backgroundColor: ColorPallete.backgroundLight,
                    backgroundImage: AssetImage('assets/images/icon.png'),
                  ),
                ),
                height: 75,
                width: size.width * 0.5,
              ),
            ),
            VerticalDivider(thickness: 2),
            Center(
              child: Container(
                padding: EdgeInsets.only(top: 20, left: 15),
                child: Text(
                  provider?.email ?? "anonim  ",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        color: ColorPallete.backgroundLight,
                      ),
                ),
              ),
            ),
            Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: menu ?? [],
              ),
            )
          ],
        ),
      ),
    );
  }
}
