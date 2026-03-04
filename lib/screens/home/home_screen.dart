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
      backgroundColor: Colors.white,
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
        _buildBannerSlider(data.banner1),

        const SizedBox(height: 20),

        _sectionTitle("Categories"),
        const SizedBox(height: 10),
        _buildCategories(data.categories),

        const SizedBox(height: 20),

        _sectionTitle("Featured Products"),
        const SizedBox(height: 10),
        _buildHorizontalProducts(data.bestSeller),

        const SizedBox(height: 20),

        _sectionTitle("Daily Best Selling"),
        const SizedBox(height: 10),
        _buildHorizontalProducts(data.bestSeller),

        const SizedBox(height: 20),

        _buildBannerSlider(data.banner2),

        const SizedBox(height: 20),

        _sectionTitle("Recently Added"),
        const SizedBox(height: 10),
        _buildHorizontalProducts(data.newArrivals),

        const SizedBox(height: 20),

        _sectionTitle("Popular Products"),
        const SizedBox(height: 10),
        _buildHorizontalProducts(data.ourProducts),

        const SizedBox(height: 20),

        _sectionTitle("Trending Products"),
        const SizedBox(height: 10),
        _buildHorizontalProducts(data.flashSale),

        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildBannerSlider(List<BannerModel> banners) {
    if (banners.isEmpty) return const SizedBox();

    return SizedBox(
      height: 170,
      child: PageView.builder(
        itemCount: banners.length,
        itemBuilder: (context, index) {
          final banner = banners[index];

          final imageUrl =
              "${ApiConstants.imageBaseUrl}"
              "${ApiConstants.bannerImagePath}"
              "${banner.image}";

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: banner.image != null && banner.image!.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.orange.shade100,
                          child: const Center(child: Icon(Icons.image_not_supported)),
                        );
                      },
                    )
                  : Container(color: Colors.orange.shade100),
            ),
          );
        },
      ),
    );
  }

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
                      ? NetworkImage(
                          "${ApiConstants.imageBaseUrl}"
                          "${ApiConstants.categoryImagePath}"
                          "${category.image}",
                        )
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

  Widget _buildHorizontalProducts(List<ProductModel> products) {
    if (products.isEmpty) return const SizedBox();

    return SizedBox(
      height: 250,
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

  Widget _sectionTitle(String title, {VoidCallback? onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        InkWell(onTap: onTap, child: const Icon(Icons.arrow_forward_ios, size: 16)),
      ],
    );
  }
}
