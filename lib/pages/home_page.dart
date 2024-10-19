import 'package:book_app/components/app_search_box.dart';
import 'package:book_app/notifiers/app_status_notifier.dart';
import 'package:book_app/pages/book_show/status_book.dart';
import 'package:book_app/resources/app_colors.dart';
import 'package:book_app/utils/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Status {
  fiction,
  animeManga,
  actionAdventure, 
  novel,
  horror,
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _initializeTabController();
  }

  void _initializeTabController() {
    _tabController = TabController(
      length: Status.values.length,
      vsync: this,
    )..addListener((){
      Provider.of<AppStatusNotifier>(context,listen: false).updateView(_tabController.index);
    } );

  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            _buildStoreTitle(),
            _buildSearchBar(),
            _buildTopSellersTitle(),
            _buildCategoryTabs(),
          ],
          body: _buildTabBarView(),
        ),
      ),
    );
  }

  Widget _buildStoreTitle() {
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

  Widget _buildSearchBar() {
    return  const SliverAppBar(
      backgroundColor: AppColors.bgColor,
      toolbarHeight: 70.0,
      flexibleSpace:AppSearchBox(),
    );
  }

  Widget _buildTopSellersTitle() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0)
            .copyWith(bottom: 10.0),
        child: Text(
          "Top Sellers",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return SliverPersistentHeader(
      pinned: true,
      floating: true,
      delegate: CategoryTabBarDelegate(
        TabBar(
          controller: _tabController,
          isScrollable: true,
          dividerColor: Colors.transparent,
          indicator: _buildTabIndicator(),
          tabAlignment: TabAlignment.center,
          indicatorColor: Colors.transparent,
          labelStyle: Theme.of(context).textTheme.headlineSmall,
          unselectedLabelStyle: _buildUnselectedTabLabelStyle(),
          tabs: _buildTabsList(),
        ),
      ),
    );
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

  List<Widget> _buildTabsList() {
    return Status.values.map((category) {
      return Tab(
        height: 50.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 10.0,
          ),
          child: Text(
            category.tabLabel,
            style: const TextStyle(fontSize: 16.0),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: List.generate(
        Status.values.length,
        (index) => const StatusBook(),
      ),
    );
  }
}

class CategoryTabBarDelegate extends SliverPersistentHeaderDelegate {
  CategoryTabBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: _tabBar.preferredSize.height,
      color: AppColors.bgColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(CategoryTabBarDelegate oldDelegate) {
    return false;
  }
}