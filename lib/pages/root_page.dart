import 'package:book_app/pages/root_vm.dart';
import 'package:book_app/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RootPage extends StackedView<RootVm> {
  const RootPage({super.key});
  @override
  RootVm viewModelBuilder(BuildContext context) => RootVm();

  @override
  Widget builder(BuildContext context, RootVm viewModel, Widget? child) {
    return Scaffold(
      body: viewModel.getPage(viewModel.selectIndex),
      bottomNavigationBar: AnimatedContainer(
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
                    onTap: () => viewModel.setIndex(index),
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          Icon(
                            viewModel.getIcon(index),
                            color: viewModel.selectIndex == index
                                ? AppColors.textColor
                                : AppColors.grey.withOpacity(0.7),
                          ),
                          Text(
                            viewModel.getName(index),
                            style: TextStyle(
                              color: viewModel.selectIndex == index
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
      ),
    );
  }
}
