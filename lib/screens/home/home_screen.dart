import 'package:flutter/material.dart';
import 'package:machine_test/core/constants/api_constants.dart';
import 'package:machine_test/models/homemodel.dart';
import 'package:machine_test/widgets/product_card.dart';
import 'package:provider/provider.dart';
import '../../providers/home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<HomeProvider>().loadHomeData());
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: Image.asset("assets/logo.png"),
        elevation: 0,
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 16),
          Icon(Icons.favorite_outline),
          SizedBox(width: 16),
          Icon(Icons.notification_add_outlined),
          SizedBox(width: 16),
        ],
      ),
      body: _buildBody(provider),
    );
  }

  Widget _buildBody(HomeProvider provider) {
    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.errorMessage != null) {
      return Center(child: Text(provider.errorMessage!));
    }

    if (provider.homeData == null) {
      return const Center(child: Text("No Data"));
    }

    final data = provider.homeData!;

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        /// 🔶 Banner Slider
        _buildBannerSlider(data.banner1),

        const SizedBox(height: 20),

        /// 🟤 Categories
        _sectionTitle("Categories"),
        const SizedBox(height: 10),
        _buildCategories(data.categories),

        const SizedBox(height: 20),

        /// 🔵 Trending Products
        _sectionTitle("Featured Products"),
        const SizedBox(height: 10),
        _buildHorizontalProducts(data.bestSeller),

        const SizedBox(height: 20),

        /// 🔴 Daily Best Selling
        _sectionTitle("Daily Best Selling"),
        const SizedBox(height: 10),
        _buildHorizontalProducts(data.flashSale),

        const SizedBox(height: 20),

        _buildBannerSlider(data.banner2),

        const SizedBox(height: 20),

        /// 🟢 Recently Added
        _sectionTitle("Recently Added"),
        const SizedBox(height: 10),
        _buildHorizontalProducts(data.newArrivals),

        const SizedBox(height: 20),

        /// 🟡 Popular Products (Grid)
        _sectionTitle("Popular Products"),
        const SizedBox(height: 10),
        _buildGridProducts(data.ourProducts),

        const SizedBox(height: 20),

        _sectionTitle("Trending Products"),
        const SizedBox(height: 10),
        _buildGridProducts(data.flashSale),

        const SizedBox(height: 20),
      ],
    );
  }

  // ===========================
  // BANNER SLIDER
  // ===========================

  Widget _buildBannerSlider(List<BannerModel> banners) {
    if (banners.isEmpty) return const SizedBox();

    return SizedBox(
      height: 170,
      child: PageView.builder(
        itemCount: banners.length,
        itemBuilder: (context, index) {
          final banner = banners[index];

          return Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: banner.image != null && banner.image!.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(
                        "${ApiConstants.imageBaseUrl}"
                        "${ApiConstants.bannerImagePath}"
                        "${banner.image}",
                      ),
                      fit: BoxFit.cover,
                    )
                  : null,
              color: Colors.orange.shade100,
            ),
            child: Image.network(
              "${ApiConstants.imageBaseUrl}"
              "${ApiConstants.bannerImagePath}"
              "${banner.image}",
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }

  // ===========================
  // CATEGORIES
  // ===========================

  Widget _buildCategories(List<CategoryModel> categories) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];

          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.brown.shade200,
                  backgroundImage: category.image != null && category.image!.isNotEmpty
                      ? NetworkImage(category.image!)
                      : null,
                  child: category.image == null || category.image!.isEmpty
                      ? Text(
                          category.name?.substring(0, 1) ?? "",
                          style: const TextStyle(color: Colors.white),
                        )
                      : null,
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: 70,
                  child: Text(
                    category.name ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ===========================
  // HORIZONTAL PRODUCTS
  // ===========================
  Widget _buildHorizontalProducts(List<ProductModel> products) {
    if (products.isEmpty) return const SizedBox();

    return SizedBox(
      height: 230,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return ProductCard(product: products[index]);
        },
      ),
    );
  }

  // ===========================
  // GRID PRODUCTS
  // ===========================

  Widget _buildGridProducts(List<ProductModel> products) {
    if (products.isEmpty) return const SizedBox();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.1,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final product = products[index];

        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    product.image ?? "",
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(color: Colors.grey[200]),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                product.name ?? "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 4),
              Text(
                "QAR ${product.price ?? ""}",
                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ],
          ),
        );
      },
    );
  }

  // ===========================
  // PROMO BANNER
  // ===========================

  Widget _sectionTitle(String title) {
    return Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
  }
}
