import 'package:book_app/pages/setting/setting_vm.dart';
import 'package:book_app/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SettingPage extends StackedView<SettingVm> {
  const SettingPage({super.key});

  @override
  SettingVm viewModelBuilder(BuildContext context) => SettingVm();

  @override
  void onViewModelReady(SettingVm viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.init();
  }

  @override
  Widget builder(BuildContext context, SettingVm viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Setting",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: viewModel.items.length,
            separatorBuilder: (_, int __) => const SizedBox(),
            itemBuilder: (context, index) {
              final item = viewModel.items[index];
              return ListTile(
                title: Text(item["title"]),
                leading: Icon(item["icon"]),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => item['widget'],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
