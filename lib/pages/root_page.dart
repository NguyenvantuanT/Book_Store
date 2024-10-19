import 'package:book_app/notifiers/app_root_notifier.dart';
import 'package:book_app/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<AppRootNotifier>(context);
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: notifier.getPage(notifier.selectIndex),
      bottomNavigationBar: _buildBottomNavigator(),
    );
  }

  Widget _buildBottomNavigator() {
    return Consumer<AppRootNotifier>(builder: (_, notifier, ___) {
      return AnimatedContainer(
        height: 52.0,
        duration: const Duration(milliseconds: 2000),
        margin: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          bottom: MediaQuery.of(context).padding.bottom + 15.0,
        ),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
              3,
              (index) => GestureDetector(
                    onTap: () => notifier.setIndex(index),
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Icon(
                            notifier.getIcon(index),
                            color: notifier.selectIndex == index
                                ? AppColors.textColor
                                : AppColors.grey.withOpacity(0.7),
                          ),
                          Text(
                            notifier.getName(index),
                            style: TextStyle(
                              color: notifier.selectIndex == index
                                  ? AppColors.textColor
                                  : AppColors.grey.withOpacity(0.7),
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
        ),
      );
    });
  }
}
