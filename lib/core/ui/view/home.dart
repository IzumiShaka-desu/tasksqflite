import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasksqflite/components/molecules/menu_item.dart';
import 'package:tasksqflite/components/organisms/menu_drawer.dart';
import 'package:tasksqflite/constant/color_pallete.dart';
import 'package:tasksqflite/core/ui/view/pages/home_page.dart';
import 'package:tasksqflite/core/ui/viewmodel/main_viewmodel.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  TabController _controller;
  List<Widget> pages = [HomePage(), Container()];
  bool isMenuOpened = false;
  @override
  void initState() {
    _controller = TabController(length: pages.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Consumer<MainViewModel>(
          builder: (context, provider, child) => Stack(
            children: [
              Container(
                color: ColorPallete.backgroundDark,
              ),
              MenuDrawer(
                size: size,
                menu: [
                  MenuItemDefault(
                    isActive: _controller.index==0,
                    ontap: () {
                      setState(() {
                        isMenuOpened = false;
                      });
                      _controller.animateTo(0);
                    },
                    icon: Icon(
                      Icons.home_outlined,
                      color: ColorPallete.backgroundLight,
                    ),
                    label: 'Home',
                  ),
                  MenuItemDefault(
                     isActive: _controller.index==1,
                    ontap: () {
                      setState(() {
                        isMenuOpened = false;
                      });
                      _controller.animateTo(1);
                    },
                    icon: Icon(
                      Icons.account_circle,
                      color: ColorPallete.backgroundLight,
                    ),
                    label: 'Profile',
                  ),
                  MenuItemDefault(
                    ontap: null,
                    icon: Icon(
                      Icons.exit_to_app_outlined,
                      color: ColorPallete.backgroundLight,
                    ),
                    label: 'Logout',
                  ),
                ],
              ),
              Positioned(
                top: size.height * 0.1,
                left: size.width * 0.51,
                child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: ColorPallete.backgroundLight.withOpacity(0.5),
                      ),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.chevron_left_outlined),
                      iconSize: 32,
                      onPressed: () {
                        setState(() {
                          isMenuOpened = false;
                        });
                      },
                      color: ColorPallete.backgroundLight,
                    )),
              ),
              AnimatedPositioned(
                top: isMenuOpened ? size.height * 0.08 : 0,
                left: isMenuOpened ? size.width * 0.6 : 0,
                duration: Duration(milliseconds: 250),
                child: SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Transform.scale(
                    alignment: Alignment.topRight,
                    scale: isMenuOpened ? 0.85 : 1,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      padding: EdgeInsets.all(
                        isMenuOpened ? 25 : 0,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ColorPallete.backgroundLight,
                      ),
                      child: Scaffold(
                        backgroundColor: ColorPallete.backgroundLight,
                        appBar: AppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          leading: IconButton(
                            icon: Icon(
                              Icons.menu_rounded,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                isMenuOpened = !isMenuOpened;
                              });
                            },
                          ),
                          actions: _controller.index==1?[]:[
                            IconButton(
                              icon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.notifications_none_outlined,
                                color: Colors.grey,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        body: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          controller: _controller,
                          children: pages,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
