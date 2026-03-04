import 'package:flutter/material.dart';
import 'package:machine_test/models/homemodel.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../services/api_service.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;
  final String slug;

  const ProductDetailsScreen({super.key, required this.productId, required this.slug});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ApiService _apiService = ApiService();

  bool isLoading = true;
  String? error;
  ProductModel? product;

  @override
  void initState() {
    super.initState();
    fetchDetails();
  }

  Future<void> fetchDetails() async {
    try {
      final data = await _apiService.fetchProductDetails(id: widget.productId, slug: widget.slug);

      setState(() {
        product = ProductModel.fromJson(data["product"]);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product Details")),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(child: Text(error!));
    }

    if (product == null) {
      return const Center(child: Text("No Data"));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Image
          Image.network(
            product!.image ?? "",
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          const SizedBox(height: 20),

          /// Name
          Text(
            product!.name ?? "",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          /// Price
          Text(
            "QAR ${product!.price ?? ""}",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),

          const SizedBox(height: 20),

          /// Description
          // Text(product!.productId ?? ""),
        ],
      ),
    );
  }
}
