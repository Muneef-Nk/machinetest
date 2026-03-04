class HomeDataModel {
  final int? success;
  final String? message;

  final List<BannerModel> banner1;
  final List<BannerModel> banner2;
  final List<BannerModel> banner3;

  final List<RecentView> recentViews;
  final List<ProductModel> ourProducts;
  final List<ProductModel> suggestedProducts;
  final List<ProductModel> bestSeller;
  final List<ProductModel> flashSale;
  final List<ProductModel> newArrivals;

  final List<CategoryModel> categories;
  final List<BrandModel> featuredBrands;

  final int cartCount;
  final int wishlistCount;
  final int notificationCount;

  final Currency? currency;

  HomeDataModel({
    this.success,
    this.message,
    this.banner1 = const [],
    this.banner2 = const [],
    this.banner3 = const [],
    this.recentViews = const [],
    this.ourProducts = const [],
    this.suggestedProducts = const [],
    this.bestSeller = const [],
    this.flashSale = const [],
    this.newArrivals = const [],
    this.categories = const [],
    this.featuredBrands = const [],
    this.cartCount = 0,
    this.wishlistCount = 0,
    this.notificationCount = 0,
    this.currency,
  });

  factory HomeDataModel.fromJson(Map<String, dynamic> json) {
    return HomeDataModel(
      success: json['success'],
      message: json['message'],

      banner1: _parseList(json['banner1'], BannerModel.fromJson),
      banner2: _parseList(json['banner2'], BannerModel.fromJson),
      banner3: _parseList(json['banner3'], BannerModel.fromJson),

      recentViews: _parseList(json['recentviews'], RecentView.fromJson),

      ourProducts: _parseList(json['our_products'], ProductModel.fromJson),
      suggestedProducts: _parseList(json['suggested_products'], ProductModel.fromJson),
      bestSeller: _parseList(json['best_seller'], ProductModel.fromJson),
      flashSale: _parseList(json['flash_sail'], ProductModel.fromJson),
      newArrivals: _parseList(json['newarrivals'], ProductModel.fromJson),

      categories: _parseList(json['categories'], CategoryModel.fromJson),

      featuredBrands: _parseList(json['featuredbrands'], BrandModel.fromJson),

      cartCount: json['cartcount'] ?? 0,
      wishlistCount: json['wishlistcount'] ?? 0,
      notificationCount: json['notification_count'] ?? 0,

      currency: json['currency'] != null ? Currency.fromJson(json['currency']) : null,
    );
  }

  static List<T> _parseList<T>(dynamic jsonList, T Function(Map<String, dynamic>) fromJson) {
    if (jsonList == null) return [];
    return List<T>.from((jsonList as List).map((e) => fromJson(e)));
  }
}

class BannerModel {
  final int? id;
  final int? linkType;
  final String? linkValue;
  final String? image;
  final String? video;
  final String? title;
  final String? subTitle;
  final String? buttonText;
  final String? logo;

  BannerModel({
    this.id,
    this.linkType,
    this.linkValue,
    this.image,
    this.video,
    this.title,
    this.subTitle,
    this.buttonText,
    this.logo,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'],
      linkType: json['link_type'],
      linkValue: json['link_value'],
      image: json['image'],
      video: json['video'],
      title: json['title'],
      subTitle: json['sub_title'],
      buttonText: json['button_text'],
      logo: json['logo'],
    );
  }
}

class ProductModel {
  final int? productId;
  final String? slug;
  final String? code;
  final String? image;
  final String? name;
  final String? category;
  final String? store;
  final String? manufacturer;
  final String? price;
  final String? oldPrice;
  final int? cart;
  final int? wishlist;

  ProductModel({
    this.productId,
    this.slug,
    this.code,
    this.image,
    this.name,
    this.category,
    this.store,
    this.manufacturer,
    this.price,
    this.oldPrice,
    this.cart,
    this.wishlist,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['productId'],
      slug: json['slug'],
      code: json['code'],
      image: json['image'] ?? json['home_img'],
      name: json['name'],
      category: json['category'],
      store: json['store'],
      manufacturer: json['manufacturer'],
      price: json['price'],
      oldPrice: json['oldprice'],
      cart: json['cart'],
      wishlist: json['wishlist'],
    );
  }
}

class CategoryModel {
  final int? id;
  final String? slug;
  final String? image;
  final String? name;
  final String? description;

  CategoryModel({this.id, this.slug, this.image, this.name, this.description});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    final category = json['category'] ?? json;

    return CategoryModel(
      id: category['id'],
      slug: category['slug'],
      image: category['image'],
      name: category['name'],
      description: category['description'],
    );
  }
}

class BrandModel {
  final int? id;
  final String? image;
  final String? slug;
  final String? name;

  BrandModel({this.id, this.image, this.slug, this.name});

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(id: json['id'], image: json['image'], slug: json['slug'], name: json['name']);
  }
}

class Currency {
  final String? name;
  final String? code;
  final String? symbolLeft;
  final String? symbolRight;
  final String? value;
  final int? isDefault;
  final int? status;

  Currency({
    this.name,
    this.code,
    this.symbolLeft,
    this.symbolRight,
    this.value,
    this.isDefault,
    this.status,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      name: json['name'],
      code: json['code'],
      symbolLeft: json['symbol_left'],
      symbolRight: json['symbol_right'],
      value: json['value'],
      isDefault: json['is_default'],
      status: json['status'],
    );
  }
}

class RecentView {
  final int? productId;
  final String? slug;
  final String? code;
  final String? homeImg;
  final String? name;
  final String? category;
  final String? store;
  final String? manufacturer;
  final String? price;
  final String? oldPrice;
  final int? cart;
  final int? wishlist;

  RecentView({
    this.productId,
    this.slug,
    this.code,
    this.homeImg,
    this.name,
    this.category,
    this.store,
    this.manufacturer,
    this.price,
    this.oldPrice,
    this.cart,
    this.wishlist,
  });

  factory RecentView.fromJson(Map<String, dynamic> json) {
    return RecentView(
      productId: json['productId'],
      slug: json['slug'],
      code: json['code'],
      homeImg: json['home_img'],
      name: json['name'],
      category: json['category'],
      store: json['store'],
      manufacturer: json['manufacturer'],
      price: json['price'],
      oldPrice: json['oldprice'],
      cart: json['cart'],
      wishlist: json['wishlist'],
    );
  }
}
