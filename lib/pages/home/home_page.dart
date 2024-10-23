import 'package:book_app/components/app_search_box.dart';
import 'package:book_app/pages/home/status_book.dart';
import 'package:book_app/pages/home/home_vm.dart';
import 'package:book_app/resources/app_colors.dart';
import 'package:book_app/utils/app_enum.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomePage extends StackedView<HomeVm> {
  const HomePage({super.key});

  @override
  HomeVm viewModelBuilder(BuildContext context) => HomeVm();

  @override
  void onViewModelReady(HomeVm viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.init();
  }

  @override
  Widget builder(BuildContext context, HomeVm viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            _buildStoreTitle(context),
            _buildSearchBar(context, viewModel),
            _buildTopSellersTitle(context),
            _buildCategoryTabs(context, viewModel),
          ],
          body: _buildTabBarView(viewModel),
        ),
      ),
    );
  }

  Widget _buildStoreTitle(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        child: Text(
          "Book Store",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, HomeVm viewModel) {
    return SliverAppBar(
      backgroundColor: AppColors.bgColor,
      toolbarHeight: 70.0,
      flexibleSpace: AppSearchBox(
        controller: viewModel.searchController,
        onChanged: viewModel.search,
      ),
    );
  }

  Widget _buildTopSellersTitle(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 20.0).copyWith(bottom: 10.0),
        child: Text(
          "Top Sellers",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }

  Widget _buildCategoryTabs(BuildContext context, HomeVm viewModel) {
    List<String> nameTab = ['Fiction', 'Anime', 'Adventure', 'Novel', 'Horror'];

    return SliverToBoxAdapter(
        child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
            nameTab.length,
            (index) => GestureDetector(
                  onTap: () => viewModel.updateView(index),
                  child: Container(
                    margin: const EdgeInsets.only(left: 20.0),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ).copyWith(top: 8.0, bottom: 5.0),
                    decoration: _buildTabIndicator(),
                    child: Text(nameTab[index],
                        style: index == viewModel.currentIndex
                            ? TextStyle(
                                color: AppColors.textColor.withOpacity(0.7),
                                fontWeight: FontWeight.bold)
                            : _buildUnselectedTabLabelStyle()),
                  ),
                )),
      ),
    ));
  }

  BoxDecoration _buildTabIndicator() {
    return BoxDecoration(
      color: AppColors.primaryC,
      border: Border.all(
        color: AppColors.discount,
        width: 1.2,
      ),
      borderRadius: BorderRadius.circular(10.0),
    );
  }

  TextStyle _buildUnselectedTabLabelStyle() {
    return TextStyle(
      color: AppColors.grey.withOpacity(0.7),
    );
  }

  Widget _buildTabBarView(HomeVm viewModel) {
    return IndexedStack(
      index: viewModel.currentIndex,
      children: List.generate(
        Status.values.length,
        (idx) => StatusBook(viewModel.searchBooks),
      ),
    );
  }
}
