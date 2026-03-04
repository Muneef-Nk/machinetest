import 'package:flutter/material.dart';

import '../../core/constants/api_constants.dart';
import '../../models/homemodel.dart';
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

      print("DETAILS RESPONSE: $data");

      if (data == null) {
        throw Exception("Empty response from server");
      }

      // Adjust according to your real API structure
      final productJson = data["product"] ?? data["data"]?["product"] ?? data["product_details"];

      if (productJson == null) {
        throw Exception("Product data not found in response");
      }

      setState(() {
        product = ProductModel.fromJson(productJson);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  String? get fullImageUrl {
    if (product?.image == null || product!.image!.isEmpty) {
      return null;
    }

    return "${ApiConstants.imageBaseUrl}"
        "${ApiConstants.productImagePath}"
        "${product!.image}";
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
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            error!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }

    if (product == null) {
      return const Center(child: Text("No Product Found"));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: fullImageUrl != null
                ? Image.network(
                    fullImageUrl!,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return const SizedBox(
                        height: 250,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    },
                    errorBuilder: (_, __, ___) => Container(height: 250, color: Colors.grey[200]),
                  )
                : Container(height: 250, color: Colors.grey[200]),
          ),

          const SizedBox(height: 20),

          /// Product Name
          Text(
            product!.name ?? "",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          /// Price
          Text(
            "QAR ${product!.price ?? ""}",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),

          const SizedBox(height: 20),

          /// Category (if exists)
          if (product!.category != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                product!.category!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

          const SizedBox(height: 20),

          /// Description Title
          const Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
