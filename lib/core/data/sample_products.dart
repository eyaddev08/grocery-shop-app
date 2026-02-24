// lib/data/sample_products.dart

import 'package:grocery_shop_app/features/products/domain/entities/product_entity.dart';

import '../constants/images_constants.dart';

const List<ProductEntity> productsList = [
  // Fish (fish_)
  ProductEntity(
    id: 'f1',
    name: 'Clownfish',
    filterLabel: 'Popular',
    tag: 'fish_clownfish',
    unit: 'pcs',
    price: 12.99,
    originalPrice: 15.00,
    discount: 2.01,
    discountType: 'amount',
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1-lwEZK8RSFBZIf2yZkfmGn8VmcjfgPw5',
    images: [
      'https://drive.google.com/uc?export=view&id=1-lwEZK8RSFBZIf2yZkfmGn8VmcjfgPw5'
    ],
    rating: 4.6,
    reviewCount: 72,
    currentStock: 24,
    shortDescription: 'Bright clownfish — colorful and lively for displays.',
    categoryIds: [1],
    brand: 'SeaFarm',
    minOrderQty: 1,
    shippingCost: 3.0,
    status: 1,
  ),

  ProductEntity(
    id: 'f2',
    name: 'Cod',
    filterLabel: 'Low Price',
    tag: 'fish_cod',
    unit: 'kg',
    price: 8.50,
    originalPrice: 10.00,
    discount: 15,
    discountType: 'percent',
    thumbnail:
        'https://drive.google.com/uc?export=view&id=12SI_5PO0cZ8wiRKijzxQROKykjMsmBbH',
    images: [
      'https://drive.google.com/uc?export=view&id=12SI_5PO0cZ8wiRKijzxQROKykjMsmBbH'
    ],
    rating: 4.3,
    reviewCount: 41,
    currentStock: 60,
    shortDescription:
        'Fresh cod — flaky white fillets great for frying or baking.',
    categoryIds: [1],
    brand: 'OceanCatch',
    minOrderQty: 1,
    shippingCost: 4.0,
    status: 1,
  ),

  ProductEntity(
    id: 'f3',
    name: 'Mixed Fish Fillets',
    filterLabel: '',
    tag: 'fish_fillet_mixed',
    unit: 'kg',
    price: 11.99,
    originalPrice: null,
    discount: null,
    discountType: null,
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1jheqY8FPwwe-jumJCGhYU-kSkNUcwImY',
    images: [
      'https://drive.google.com/uc?export=view&id=1jheqY8FPwwe-jumJCGhYU-kSkNUcwImY'
    ],
    rating: 4.5,
    reviewCount: 120,
    currentStock: 30,
    shortDescription: 'Assorted mixed fillets — ideal for family meals.',
    categoryIds: [1],
    brand: 'SeaHarvest',
    minOrderQty: 1,
    shippingCost: 5.0,
    status: 1,
  ),

  ProductEntity(
    id: 'f4',
    name: 'Mackerel',
    filterLabel: 'Popular',
    tag: 'fish_mackerel',
    unit: 'kg',
    price: 6.75,
    originalPrice: null,
    discount: null,
    discountType: null,
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1mND_YUn8cUVriKsC2aAorW769ryERTGY',
    images: [
      'https://drive.google.com/uc?export=view&id=1mND_YUn8cUVriKsC2aAorW769ryERTGY'
    ],
    rating: 4.2,
    reviewCount: 33,
    currentStock: 48,
    shortDescription: 'Fresh mackerel — rich flavor and great for grilling.',
    categoryIds: [1],
    brand: 'BlueSea',
    minOrderQty: 1,
    shippingCost: 3.5,
    status: 1,
  ),

  ProductEntity(
    id: 'f5',
    name: 'Prawns (Shrimp)',
    filterLabel: 'Sale',
    tag: 'fish_parwns',
    unit: 'kg',
    price: 14.99,
    originalPrice: 18.50,
    discount: 3.51,
    discountType: 'amount',
    thumbnail:
        'https://drive.google.com/uc?export=view&id=18dLw7Mm2TumAQB1anmKCl3kMO3HHIyZc',
    images: [
      'https://drive.google.com/uc?export=view&id=18dLw7Mm2TumAQB1anmKCl3kMO3HHIyZc'
    ],
    rating: 4.7,
    reviewCount: 99,
    currentStock: 36,
    shortDescription: 'Fresh prawns — succulent and ready to cook.',
    categoryIds: [1],
    brand: 'OceanDelights',
    minOrderQty: 1,
    shippingCost: 6.0,
    status: 1,
  ),

  ProductEntity(
    id: 'f6',
    name: 'Salmon',
    filterLabel: 'Premium',
    tag: 'fish_salmon',
    unit: 'kg',
    price: 19.99,
    originalPrice: 22.50,
    discount: 2.51,
    discountType: 'amount',
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1XC4ICPGpDpmJxLprETc7LMdMze7t73W5',
    images: [
      'https://drive.google.com/uc?export=view&id=1XC4ICPGpDpmJxLprETc7LMdMze7t73W5'
    ],
    rating: 4.8,
    reviewCount: 210,
    currentStock: 18,
    shortDescription: 'Premium salmon fillets — rich and flavorful.',
    categoryIds: [1],
    brand: 'NordicSea',
    minOrderQty: 1,
    shippingCost: 7.0,
    status: 1,
  ),

  ProductEntity(
    id: 'f7',
    name: 'Sardines',
    filterLabel: '',
    tag: 'fish_sardine',
    unit: 'kg',
    price: 4.20,
    originalPrice: null,
    discount: null,
    discountType: null,
    thumbnail:
        'https://drive.google.com/uc?export=view&id=16NhnjEipSwBNG_0ly8S9rZCWb5g0fQwX',
    images: [
      'https://drive.google.com/uc?export=view&id=16NhnjEipSwBNG_0ly8S9rZCWb5g0fQwX'
    ],
    rating: 4.0,
    reviewCount: 14,
    currentStock: 120,
    shortDescription: 'Small fresh sardines — great for grilling whole.',
    categoryIds: [1],
    brand: 'CoastLine',
    minOrderQty: 1,
    shippingCost: 2.5,
    status: 1,
  ),

  ProductEntity(
    id: 'f8',
    name: 'Seabass',
    filterLabel: 'New',
    tag: 'fish_seabass',
    unit: 'kg',
    price: 13.50,
    originalPrice: 15.00,
    discount: 10,
    discountType: 'percent',
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1zyDqAJRhWHoXL-izvsjIqRSwlIT71Zqb',
    images: [
      'https://drive.google.com/uc?export=view&id=1zyDqAJRhWHoXL-izvsjIqRSwlIT71Zqb'
    ],
    rating: 4.5,
    reviewCount: 55,
    currentStock: 26,
    shortDescription: 'Fresh seabass — delicate texture, excellent for baking.',
    categoryIds: [1],
    brand: 'SilverCatch',
    minOrderQty: 1,
    shippingCost: 5.5,
    status: 1,
  ),

  ProductEntity(
    id: 'f9',
    name: 'Tilapia',
    filterLabel: '',
    tag: 'fish_tilapia',
    unit: 'kg',
    price: 6.00,
    originalPrice: 7.00,
    discount: 1.00,
    discountType: 'amount',
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1b8SZH0bJbGUZMdgIbz61JxpXknw9jLwv',
    images: [
      'https://drive.google.com/uc?export=view&id=1b8SZH0bJbGUZMdgIbz61JxpXknw9jLwv'
    ],
    rating: 4.1,
    reviewCount: 30,
    currentStock: 80,
    shortDescription: 'Fresh tilapia — mild flavor and easy to cook.',
    categoryIds: [1],
    brand: 'RiverCatch',
    minOrderQty: 1,
    shippingCost: 3.0,
    status: 1,
  ),

  ProductEntity(
    id: 'f10',
    name: 'Tuna',
    filterLabel: 'Premium',
    tag: 'fish_tuna',
    unit: 'kg',
    price: 21.50,
    originalPrice: 24.00,
    discount: 2.50,
    discountType: 'amount',
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1ZYLcVQutjA5lC3IfyzhBvMM1BkSEDRnJ',
    images: [
      'https://drive.google.com/uc?export=view&id=1ZYLcVQutjA5lC3IfyzhBvMM1BkSEDRnJ'
    ],
    rating: 4.7,
    reviewCount: 142,
    currentStock: 12,
    shortDescription: 'High-quality tuna — great for sushi and grilling.',
    categoryIds: [1],
    brand: 'BlueOcean',
    minOrderQty: 1,
    shippingCost: 8.0,
    status: 1,
  ),

  // Vegetables (veg_)
  ProductEntity(
    id: 'v1',
    name: 'Bell Pepper',
    filterLabel: 'Popular',
    tag: 'veg_bellpepper',
    unit: 'kg',
    price: 2.49,
    originalPrice: 2.99,
    discount: 0.50,
    discountType: 'amount',
    thumbnail: ImagesConstants.vegBellpepper,
    images: [
      ImagesConstants.vegBellpepper,
    ],
    rating: 4.5,
    reviewCount: 58,
    currentStock: 120,
    shortDescription: 'Fresh bell peppers — crisp and colorful.',
    categoryIds: [2],
    brand: 'FarmFresh',
    minOrderQty: 1,
    shippingCost: 1.5,
    status: 1,
  ),

  ProductEntity(
    id: 'v2',
    name: 'Broccoli',
    filterLabel: 'Organic',
    tag: 'veg_broccoli',
    unit: 'kg',
    price: 1.79,
    originalPrice: null,
    discount: null,
    discountType: null,
    thumbnail: ImagesConstants.vegBroccoli,
    images: [
      ImagesConstants.vegBroccoli,
    ],
    rating: 4.4,
    reviewCount: 37,
    currentStock: 75,
    shortDescription: 'Fresh broccoli heads, ideal for steaming and salads.',
    categoryIds: [2],
    brand: 'GreenValley',
    minOrderQty: 1,
    shippingCost: 1.2,
    status: 1,
  ),

  ProductEntity(
    id: 'v3',
    name: 'Carrot',
    filterLabel: 'Low Price',
    tag: 'veg_carrot',
    unit: 'kg',
    price: 0.95,
    originalPrice: 1.20,
    discount: 21,
    discountType: 'percent',
    thumbnail:
        'https://drive.google.com/uc?export=view&id=12-2pO1I96VEkaaBNG76rtm-HR8kz3Dag',
    images: [
      'https://drive.google.com/uc?export=view&id=12-2pO1I96VEkaaBNG76rtm-HR8kz3Dag'
    ],
    rating: 4.3,
    reviewCount: 44,
    currentStock: 200,
    shortDescription:
        'Sweet and crunchy carrots, perfect for cooking and snacking.',
    categoryIds: [2],
    brand: 'RootHarvest',
    minOrderQty: 1,
    shippingCost: 1.0,
    status: 1,
  ),

  ProductEntity(
    id: 'v4',
    name: 'Cucumber',
    filterLabel: '',
    tag: 'veg_cucumber',
    unit: 'kg',
    price: 1.20,
    originalPrice: null,
    discount: null,
    discountType: null,
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1ykQsVGeg5CMEfOKGrNuXa7nVDIe9mX63',
    images: [
      'https://drive.google.com/uc?export=view&id=1ykQsVGeg5CMEfOKGrNuXa7nVDIe9mX63'
    ],
    rating: 4.2,
    reviewCount: 29,
    currentStock: 150,
    shortDescription: 'Cool and refreshing cucumbers, great for salads.',
    categoryIds: [2],
    brand: 'CoolFarm',
    minOrderQty: 1,
    shippingCost: 1.0,
    status: 1,
  ),

  ProductEntity(
    id: 'v5',
    name: 'Eggplant',
    filterLabel: '',
    tag: 'veg_eggplant',
    unit: 'kg',
    price: 1.89,
    originalPrice: null,
    discount: null,
    discountType: null,
    thumbnail:
        'https://drive.google.com/uc?export=view&id=17cgrfHE1gwFBeMuELsPFFzD7TBKJkm32',
    images: [
      'https://drive.google.com/uc?export=view&id=17cgrfHE1gwFBeMuELsPFFzD7TBKJkm32'
    ],
    rating: 4.1,
    reviewCount: 18,
    currentStock: 60,
    shortDescription: 'Fresh eggplants — perfect for grilling and stews.',
    categoryIds: [2],
    brand: 'Mediterrano',
    minOrderQty: 1,
    shippingCost: 1.4,
    status: 1,
  ),

  ProductEntity(
    id: 'v6',
    name: 'Lettuce',
    filterLabel: '',
    tag: 'veg_lettuce',
    unit: 'pcs',
    price: 0.99,
    originalPrice: 1.29,
    discount: 23,
    discountType: 'amount',
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1wFjgOsuJpqwKGSFdFfi1jKJgdSRU8qtM',
    images: [
      'https://drive.google.com/uc?export=view&id=1wFjgOsuJpqwKGSFdFfi1jKJgdSRU8qtM'
    ],
    rating: 4.0,
    reviewCount: 22,
    currentStock: 95,
    shortDescription: 'Crisp lettuce heads — ideal for fresh salads.',
    categoryIds: [2],
    brand: 'FreshLeaf',
    minOrderQty: 1,
    shippingCost: 1.0,
    status: 1,
  ),

  ProductEntity(
    id: 'v7',
    name: 'Onion',
    filterLabel: 'Popular',
    tag: 'veg_onion',
    unit: 'kg',
    price: 0.69,
    originalPrice: null,
    discount: null,
    discountType: null,
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1NMvNJjMU-cRpc0CSsHIVSWVVceF6RfWk',
    images: [
      'https://drive.google.com/uc?export=view&id=1NMvNJjMU-cRpc0CSsHIVSWVVceF6RfWk'
    ],
    rating: 4.4,
    reviewCount: 66,
    currentStock: 300,
    shortDescription: 'Yellow onions — staple for many recipes.',
    categoryIds: [2],
    brand: 'AllSeasons',
    minOrderQty: 1,
    shippingCost: 0.9,
    status: 1,
  ),

  ProductEntity(
    id: 'v8',
    name: 'Potato',
    filterLabel: 'Low Price',
    tag: 'veg_potato',
    unit: 'kg',
    price: 0.55,
    originalPrice: 0.79,
    discount: 24,
    discountType: 'percent',
    thumbnail:
        'https://drive.google.com/uc?export=view&id=112hXLJe42nF-gjOHgCIiovssRTOU3oLA',
    images: [
      'https://drive.google.com/uc?export=view&id=112hXLJe42nF-gjOHgCIiovssRTOU3oLA'
    ],
    rating: 4.2,
    reviewCount: 47,
    currentStock: 500,
    shortDescription: 'Versatile potatoes — perfect for roasting and mashing.',
    categoryIds: [2],
    brand: 'EarthRoot',
    minOrderQty: 1,
    shippingCost: 0.8,
    status: 1,
  ),

  ProductEntity(
    id: 'v9',
    name: 'Tomato',
    filterLabel: 'Popular',
    tag: 'veg_tomato',
    unit: 'kg',
    price: 1.49,
    originalPrice: 1.99,
    discount: 25,
    discountType: 'percent',
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1Nsi8no9AT2Pg7_dsGfcnSVCMcKXfgIRT',
    images: [
      'https://drive.google.com/uc?export=view&id=1Nsi8no9AT2Pg7_dsGfcnSVCMcKXfgIRT'
    ],
    rating: 4.6,
    reviewCount: 88,
    currentStock: 220,
    shortDescription: 'Juicy ripe tomatoes — perfect for sauces and salads.',
    categoryIds: [2],
    brand: 'VineValley',
    minOrderQty: 1,
    shippingCost: 1.2,
    status: 1,
  ),

  ProductEntity(
    id: 'v10',
    name: 'Vegetables Basket (Mixed)',
    filterLabel: 'Bundle',
    tag: 'vegetables_basket',
    unit: 'bundle',
    price: 7.99,
    originalPrice: 9.99,
    discount: 2.00,
    discountType: 'amount',
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1V6wQ6j2xnBIGd3Xxa7sbLkr678S-MCJk',
    images: [
      'https://drive.google.com/uc?export=view&id=1V6wQ6j2xnBIGd3Xxa7sbLkr678S-MCJk'
    ],
    rating: 4.7,
    reviewCount: 134,
    currentStock: 40,
    shortDescription:
        'Mixed vegetables bundle — tomatoes, cucumber, carrots and more.',
    categoryIds: [2],
    brand: 'FarmBundle',
    minOrderQty: 1,
    shippingCost: 2.5,
    status: 1,
  ),

  //  Organic Eggs(categoryIds: [4])
  ProductEntity(
    id: 'eg1',
    name: 'Organic Eggs - Carton of 6',
    filterLabel: 'Popular',
    tag: 'organic_eggs_carton_6',
    unit: 'carton',
    price: 3.49,
    originalPrice: 3.99,
    discount: 0.50,
    discountType: 'amount',
    thumbnail:
        'https://drive.google.com/uc?export=view&id=185pr1PuvfPxrPb6zU9R9tFwhWo2mpV26',
    images: [
      'https://drive.google.com/uc?export=view&id=185pr1PuvfPxrPb6zU9R9tFwhWo2mpV26'
    ],
    rating: 4.6,
    reviewCount: 92,
    currentStock: 120,
    shortDescription:
        'Carton of 6 organic eggs — golden yolks, farm-fresh quality.',
    categoryIds: [4],
    brand: 'FarmFresh Organics',
    minOrderQty: 1,
    shippingCost: 1.0,
    status: 1,
  ),

  ProductEntity(
    id: 'eg2',
    name: 'Organic Eggs - Carton of 12',
    filterLabel: 'Value',
    tag: 'organic_eggs_carton_12',
    unit: 'carton',
    price: 6.49,
    originalPrice: 7.49,
    discount: 1.00,
    discountType: 'amount',
    thumbnail:
        'https://drive.google.com/uc?export=view&id=15GhbQgWF9i3B_yZSjEtgrtET9_lHBQmk',
    images: [
      'https://drive.google.com/uc?export=view&id=15GhbQgWF9i3B_yZSjEtgrtET9_lHBQmk'
    ],
    rating: 4.5,
    reviewCount: 110,
    currentStock: 80,
    shortDescription: 'Family carton 12-pack — organic, high-quality eggs.',
    categoryIds: [4],
    brand: 'GreenHen Organics',
    minOrderQty: 1,
    shippingCost: 1.5,
    status: 1,
  ),

  ProductEntity(
    id: 'eg3',
    name: 'Organic Brown Eggs - Closeup',
    filterLabel: 'Premium',
    tag: 'organic_brown_eggs_closeup',
    unit: 'pcs',
    price: 0.55,
    originalPrice: null,
    discount: null,
    discountType: null,
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1sPIDrVwWs2rbNLJkwCi8E1tR6dnboG8P',
    images: [
      'https://drive.google.com/uc?export=view&id=1sPIDrVwWs2rbNLJkwCi8E1tR6dnboG8P'
    ],
    rating: 4.4,
    reviewCount: 48,
    currentStock: 220,
    shortDescription: 'High-detail brown eggs — farm fresh closeup shot.',
    categoryIds: [4],
    brand: 'BrownNest',
    minOrderQty: 6,
    shippingCost: 0.7,
    status: 1,
  ),

  ProductEntity(
    id: 'eg4',
    name: 'Organic White Eggs - Closeup',
    filterLabel: 'Fresh',
    tag: 'organic_white_eggs_closeup',
    unit: 'pcs',
    price: 0.50,
    originalPrice: null,
    discount: null,
    discountType: null,
    thumbnail:
        'https://drive.google.com/uc?export=view&id=15mP_a0E0KzbyRumNTdRgLiHhN8-lebSn',
    images: [
      'https://drive.google.com/uc?export=view&id=15mP_a0E0KzbyRumNTdRgLiHhN8-lebSn'
    ],
    rating: 4.3,
    reviewCount: 36,
    currentStock: 260,
    shortDescription:
        'Clean white organic eggs — smooth shells and consistent size.',
    categoryIds: [4],
    brand: 'PureLayer',
    minOrderQty: 6,
    shippingCost: 0.7,
    status: 1,
  ),

  ProductEntity(
    id: 'eg5',
    name: 'Free-Range Organic Eggs - Carton',
    filterLabel: 'Free Range',
    tag: 'free_range_eggs_carton',
    unit: 'carton',
    price: 4.29,
    originalPrice: 4.99,
    discount: 0.70,
    discountType: 'amount',
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1r4wSf0PVpiP4cpxekhXdjPMQuTJU2rUL',
    images: [
      'https://drive.google.com/uc?export=view&id=1r4wSf0PVpiP4cpxekhXdjPMQuTJU2rUL'
    ],
    rating: 4.7,
    reviewCount: 132,
    currentStock: 90,
    shortDescription:
        'Free-range organic eggs — ethically farmed with natural feed.',
    categoryIds: [4],
    brand: 'FreeFarm',
    minOrderQty: 1,
    shippingCost: 1.2,
    status: 1,
  ),

  ProductEntity(
    id: 'eg6',
    name: 'Pasture Eggs in Nest',
    filterLabel: 'Rustic',
    tag: 'pasture_eggs_in_nest',
    unit: 'set',
    price: 5.99,
    originalPrice: null,
    discount: null,
    discountType: null,
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1mjezWsA88mKVUa1wAbizVpHEDX8NfZOC',
    images: [
      'https://drive.google.com/uc?export=view&id=1mjezWsA88mKVUa1wAbizVpHEDX8NfZOC'
    ],
    rating: 4.6,
    reviewCount: 44,
    currentStock: 40,
    shortDescription:
        'Pasture-style presentation — eggs nestled in straw (gift-ready).',
    categoryIds: [4],
    brand: 'PastureGold',
    minOrderQty: 1,
    shippingCost: 1.8,
    status: 1,
  ),

  ProductEntity(
    id: 'eg7',
    name: 'Organic Egg - Cracked Yolk (Single)',
    filterLabel: 'Visual',
    tag: 'organic_eggs_cracked_yolk',
    unit: 'pcs',
    price: 0.85,
    originalPrice: null,
    discount: null,
    discountType: null,
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1CZ0fnwbuFVikSsJ6oK5kK5GGvgUnEj60',
    images: [
      'https://drive.google.com/uc?export=view&id=1CZ0fnwbuFVikSsJ6oK5kK5GGvgUnEj60'
    ],
    rating: 4.8,
    reviewCount: 28,
    currentStock: 140,
    shortDescription:
        'Single cracked egg showing vivid golden yolk — high visual quality.',
    categoryIds: [4],
    brand: 'YolkBright',
    minOrderQty: 1,
    shippingCost: 0.5,
    status: 1,
  ),

  ProductEntity(
    id: 'eg8',
    name: 'Eco Packaging Organic Eggs',
    filterLabel: 'Eco',
    tag: 'organic_eggs_packaging_eco',
    unit: 'carton',
    price: 3.99,
    originalPrice: 4.49,
    discount: 0.50,
    discountType: 'amount',
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1WTWA5qLm0gmnhzryBlOHGxrTDI3xux70',
    images: [
      'https://drive.google.com/uc?export=view&id=1WTWA5qLm0gmnhzryBlOHGxrTDI3xux70'
    ],
    rating: 4.5,
    reviewCount: 61,
    currentStock: 110,
    shortDescription:
        'Eco-friendly cardboard packaging for organic eggs — recyclable and minimal.',
    categoryIds: [4],
    brand: 'EcoCarton',
    minOrderQty: 1,
    shippingCost: 1.0,
    status: 1,
  ),

  ProductEntity(
    id: 'eg9',
    name: 'Organic Quail Eggs (Pack)',
    filterLabel: 'Specialty',
    tag: 'organic_quail_eggs',
    unit: 'pack',
    price: 4.59,
    originalPrice: null,
    discount: null,
    discountType: null,
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1Dw_Fura9zxg4STGoF7vouWSA4AVi7y4v',
    images: [
      'https://drive.google.com/uc?export=view&id=1Dw_Fura9zxg4STGoF7vouWSA4AVi7y4v'
    ],
    rating: 4.2,
    reviewCount: 18,
    currentStock: 60,
    shortDescription:
        'Small quail eggs — delicate speckled shells, gourmet choice.',
    categoryIds: [4],
    brand: 'QuailFarm',
    minOrderQty: 1,
    shippingCost: 1.5,
    status: 1,
  ),

  ProductEntity(
    id: 'eg10',
    name: 'Organic Eggs - Basket Bundle',
    filterLabel: 'Bundle',
    tag: 'organic_eggs_basket_bundle',
    unit: 'bundle',
    price: 8.99,
    originalPrice: 10.99,
    discount: 2.00,
    discountType: 'amount',
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1D40JymZehcW6u6U5H2OkMVPdoa-OFCPa',
    images: [
      'https://drive.google.com/uc?export=view&id=1D40JymZehcW6u6U5H2OkMVPdoa-OFCPa'
    ],
    rating: 4.7,
    reviewCount: 74,
    currentStock: 34,
    shortDescription:
        'Gift-style basket bundle of mixed organic eggs — brown & white, with linen.',
    categoryIds: [4],
    brand: 'BundleFarm',
    minOrderQty: 1,
    shippingCost: 2.5,
    status: 1,
  ),

  ProductEntity(
    id: 'eg11',
    name: 'Organic Eggs - Label Closeup',
    filterLabel: 'Info',
    tag: 'organic_eggs_label_closeup',
    unit: 'carton',
    price: 3.29,
    originalPrice: null,
    discount: null,
    discountType: null,
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1R_uzbP_nU7rsFfRNA4lyYWf0cKeOz_vC',
    images: [
      'https://drive.google.com/uc?export=view&id=1R_uzbP_nU7rsFfRNA4lyYWf0cKeOz_vC'
    ],
    rating: 4.3,
    reviewCount: 22,
    currentStock: 88,
    shortDescription:
        'Closeup on packaging label area (organic tag concept) — tidy product shot.',
    categoryIds: [4],
    brand: 'LabelFarm',
    minOrderQty: 1,
    shippingCost: 1.0,
    status: 1,
  ),
   ProductEntity(
    id: 'eg12',
    name: 'Organic Duck Eggs (Pack of 6)',
    filterLabel: 'Specialty',
    tag: 'organic_duck_eggs',
    unit: 'pack',
    price: 5.49,
    originalPrice: 6.49,
    discount: 1.00,
    discountType: 'amount',
    
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1bdWIDR7IHk78cNJF4nS3lrusaY3oYXNZ',
    images: [
      'https://drive.google.com/uc?export=view&id=1bdWIDR7IHk78cNJF4nS3lrusaY3oYXNZ'
    ],
    rating: 4.6,
    reviewCount: 24,
    currentStock: 48,
    shortDescription:
        'Large organic duck eggs with rich golden yolks — ideal for baking, pastries and gourmet dishes.',
    categoryIds: [4],
    brand: 'DuckValley',
    minOrderQty: 1,
    shippingCost: 2.0,
    status: 1,
  ),

  // Meats (categoryIds: [3])
  ProductEntity(
    id: 'm1',
    name: 'Beef Steak (Ribeye)',
    filterLabel: 'Premium',
    tag: 'meat_beef_steak',
    unit: 'kg',
    price: 14.99,
    originalPrice: 17.99,
    discount: 3.00,
    discountType: 'amount',
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1DjR6jG1ILq-aHpqn6xJZ0TExa3bNr9UC',
    images: [
      'https://drive.google.com/uc?export=view&id=1DjR6jG1ILq-aHpqn6xJZ0TExa3bNr9UC'
    ],
    rating: 4.8,
    reviewCount: 220,
    currentStock: 36,
    shortDescription:
        'Ribeye beef steak — well-marbled and ideal for grilling.',
    categoryIds: [3],
    brand: 'PrimeCuts',
    minOrderQty: 1,
    shippingCost: 6.0,
    status: 1,
  ),

  ProductEntity(
    id: 'm2',
    name: 'Lamb Chop',
    filterLabel: 'Halal',
    tag: 'meat_lamb_chop',
    unit: 'kg',
    price: 16.50,
    originalPrice: 18.00,
    discount: 1.50,
    discountType: 'amount',
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1ZWC4budYa5xxotrG1MJ7cmYCnQfcq_Zu',
    images: [
      'https://drive.google.com/uc?export=view&id=1ZWC4budYa5xxotrG1MJ7cmYCnQfcq_Zu'
    ],
    rating: 4.6,
    reviewCount: 110,
    currentStock: 28,
    shortDescription:
        'Lamb chops — tender and flavorful, perfect for roasting or grilling.',
    categoryIds: [3],
    brand: 'ShepherdChoice',
    minOrderQty: 1,
    shippingCost: 6.0,
    status: 1,
  ),

  ProductEntity(
    id: 'm3',
    name: 'Chicken Breast',
    filterLabel: 'Fresh',
    tag: 'meat_chicken_breast',
    unit: 'kg',
    price: 6.99,
    originalPrice: 7.99,
    discount: 1.00,
    discountType: 'amount',
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1m06oTDVroez7aPre_XNZzWjMbtdGl4Lh',
    images: [
      'https://drive.google.com/uc?export=view&id=1m06oTDVroez7aPre_XNZzWjMbtdGl4Lh'
    ],
    rating: 4.4,
    reviewCount: 300,
    currentStock: 200,
    shortDescription:
        'Skinless chicken breast — lean and versatile for many recipes.',
    categoryIds: [3],
    brand: 'PoultryFarm',
    minOrderQty: 1,
    shippingCost: 4.0,
    status: 1,
  ),

  ProductEntity(
    id: 'm4',
    name: 'Turkey Slice',
    filterLabel: 'Deli',
    tag: 'meat_turkey_slice',
    unit: 'pack',
    price: 5.49,
    originalPrice: 6.49,
    discount: 1.00,
    discountType: 'amount',
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1kh-BwalzZF6gGtW_a3e8wl-sRosGBjDT',
    images: [
      'https://drive.google.com/uc?export=view&id=1kh-BwalzZF6gGtW_a3e8wl-sRosGBjDT'
    ],
    rating: 4.2,
    reviewCount: 85,
    currentStock: 120,
    shortDescription: 'Sliced turkey — great for sandwiches and quick meals.',
    categoryIds: [3],
    brand: 'DeliSelect',
    minOrderQty: 1,
    shippingCost: 3.0,
    status: 1,
  ),

  ProductEntity(
    id: 'm5',
    name: 'Pork Chop',
    filterLabel: 'Fresh',
    tag: 'meat_pork_chop',
    unit: 'kg',
    price: 9.99,
    originalPrice: 11.50,
    discount: 1.51,
    discountType: 'amount',
    thumbnail:
        'https://drive.google.com/uc?export=view&id=16pDmgWPKdZhKxgjwzYt11L0D9oz1OuS-',
    images: [
      'https://drive.google.com/uc?export=view&id=16pDmgWPKdZhKxgjwzYt11L0D9oz1OuS-'
    ],
    rating: 4.1,
    reviewCount: 48,
    currentStock: 70,
    shortDescription:
        'Fresh pork chops — tender cuts suitable for pan-frying or baking.',
    categoryIds: [3],
    brand: 'FarmBarn',
    minOrderQty: 1,
    shippingCost: 5.0,
    status: 1,
  ),

  ProductEntity(
    id: 'm6',
    name: 'Minced Beef',
    filterLabel: 'Ground',
    tag: 'meat_minced_beef',
    unit: 'kg',
    price: 7.49,
    originalPrice: 8.49,
    discount: 1.00,
    discountType: 'amount',
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1TWM1dWE6exICFEImZ8sDQCzwoJutmD0S',
    images: [
      'https://drive.google.com/uc?export=view&id=1TWM1dWE6exICFEImZ8sDQCzwoJutmD0S'
    ],
    rating: 4.3,
    reviewCount: 140,
    currentStock: 85,
    shortDescription:
        'Lean minced beef — great for burgers, sauces, and casseroles.',
    categoryIds: [3],
    brand: 'GrindMaster',
    minOrderQty: 1,
    shippingCost: 4.5,
    status: 1,
  ),

  ProductEntity(
    id: 'm7',
    name: 'Sausages (Raw)',
    filterLabel: 'Bundle',
    tag: 'meat_sausages',
    unit: 'pack',
    price: 5.99,
    originalPrice: 6.99,
    discount: 1.00,
    discountType: 'amount',
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1wq3hfLZsHTnAtwCHgreDUKMeszDpoMB1',
    images: [
      'https://drive.google.com/uc?export=view&id=1wq3hfLZsHTnAtwCHgreDUKMeszDpoMB1'
    ],
    rating: 4.2,
    reviewCount: 72,
    currentStock: 95,
    shortDescription: 'Raw sausages — great for grilling and family meals.',
    categoryIds: [3],
    brand: 'SausageWorks',
    minOrderQty: 1,
    shippingCost: 3.5,
    status: 1,
  ),

  ProductEntity(
    id: 'm8',
    name: 'Kebab Skewer (Raw)',
    filterLabel: 'Seasonal',
    tag: 'meat_kebab_skewer',
    unit: 'pack',
    price: 8.49,
    originalPrice: 9.99,
    discount: 1.50,
    discountType: 'amount',
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1w-RDQrgbysSEezjzYSPAz_Ar1CM0EVjD',
    images: [
      'https://drive.google.com/uc?export=view&id=1w-RDQrgbysSEezjzYSPAz_Ar1CM0EVjD'
    ],
    rating: 4.5,
    reviewCount: 64,
    currentStock: 50,
    shortDescription:
        'Raw kebab skewers — seasoned and ready to grill at home.',
    categoryIds: [3],
    brand: 'GrillHouse',
    minOrderQty: 1,
    shippingCost: 5.0,
    status: 1,
  ),

  ProductEntity(
    id: 'm9',
    name: 'Halal Pack (Mixed Cuts)',
    filterLabel: 'Halal',
    tag: 'meat_halal_pack',
    unit: 'pack',
    price: 24.99,
    originalPrice: 29.99,
    discount: 5.00,
    discountType: 'amount',
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1UYotx5_YPAubwgSNB-8H1P7daJEfXHa9',
    images: [
      'https://drive.google.com/uc?export=view&id=1UYotx5_YPAubwgSNB-8H1P7daJEfXHa9'
    ],
    rating: 4.6,
    reviewCount: 98,
    currentStock: 40,
    shortDescription: 'Halal mixed meat pack — assorted cuts for family meals.',
    categoryIds: [3],
    brand: 'HalalChoice',
    minOrderQty: 1,
    shippingCost: 8.0,
    status: 1,
  ),

  ProductEntity(
    id: 'm10',
    name: 'Smoked Ham (Sliced)',
    filterLabel: 'Deli',
    tag: 'meat_smoked_ham',
    unit: 'pack',
    price: 7.99,
    originalPrice: 9.49,
    discount: 1.50,
    discountType: 'amount',
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1D40JymZehcW6u6U5H2OkMVPdoa-OFCPa',
    images: [
      'https://drive.google.com/uc?export=view&id=1D40JymZehcW6u6U5H2OkMVPdoa-OFCPa'
    ],
    rating: 4.3,
    reviewCount: 58,
    currentStock: 72,
    shortDescription: 'Smoked ham — thinly sliced and ready for sandwiches.',
    categoryIds: [3],
    brand: 'SmokeHouse',
    minOrderQty: 1,
    shippingCost: 4.0,
    status: 1,
  ),

  // Fruits (categoryIds: [6])
  ProductEntity(
    id: 'fr1',
    name: 'Apple - Gala',
    filterLabel: 'Popular',
    tag: 'fruit_apple_gala',
    unit: 'kg',
    price: 2.99,
    originalPrice: 3.49,
    discount: 0.50,
    discountType: 'amount',
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1oWXlSQp-wqWoub_s07_5VyYy23xFon2i',
    images: [
      'https://drive.google.com/uc?export=view&id=1oWXlSQp-wqWoub_s07_5VyYy23xFon2i'
    ],
    rating: 4.5,
    reviewCount: 64,
    currentStock: 180,
    shortDescription: 'Crisp Gala apples — sweet, juicy, and great for snacks.',
    categoryIds: [6],
    brand: 'OrchardFresh',
    minOrderQty: 1,
    shippingCost: 1.0,
    status: 1,
  ),

  ProductEntity(
    id: 'fr2',
    name: 'Apple - Granny Smith',
    filterLabel: 'Sour',
    tag: 'fruit_granny_smith',
    unit: 'kg',
    price: 3.19,
    originalPrice: null,
    discount: null,
    discountType: null,
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1X-keqFoHL5E5p_QzSATHrLF-e_iol4Km',
    images: [
      'https://drive.google.com/uc?export=view&id=1X-keqFoHL5E5p_QzSATHrLF-e_iol4Km'
    ],
    rating: 4.4,
    reviewCount: 42,
    currentStock: 140,
    shortDescription:
        'Tart and firm Granny Smith apples — perfect for baking and salads.',
    categoryIds: [6],
    brand: 'GreenOrchard',
    minOrderQty: 1,
    shippingCost: 1.0,
    status: 1,
  ),

  ProductEntity(
    id: 'fr3',
    name: 'Mango (Ripe)',
    filterLabel: 'Seasonal',
    tag: 'fruit_mango',
    unit: 'pcs',
    price: 1.99,
    originalPrice: 2.49,
    discount: 0.50,
    discountType: 'amount',
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1KAkzO571FUQF2zc5YSYZvWLDAFJcd_cF',
    images: [
      'https://drive.google.com/uc?export=view&id=1KAkzO571FUQF2zc5YSYZvWLDAFJcd_cF'
    ],
    rating: 4.7,
    reviewCount: 95,
    currentStock: 90,
    shortDescription:
        'Sweet ripe mango — fragrant and perfect for smoothies or eating raw.',
    categoryIds: [6],
    brand: 'TropicalSelect',
    minOrderQty: 1,
    shippingCost: 1.5,
    status: 1,
  ),

  ProductEntity(
    id: 'fr4',
    name: 'Strawberry (Box)',
    filterLabel: 'Fresh',
    tag: 'fruit_strawberry',
    unit: 'box',
    price: 3.49,
    originalPrice: 3.99,
    discount: 0.50,
    discountType: 'amount',
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1XIYTo-o-ZsDWWAtnFeopWqoFXgoRnY4s',
    images: [
      'https://drive.google.com/uc?export=view&id=1XIYTo-o-ZsDWWAtnFeopWqoFXgoRnY4s'
    ],
    rating: 4.8,
    reviewCount: 160,
    currentStock: 75,
    shortDescription:
        'Bright red strawberries — juicy and aromatic, ideal for desserts.',
    categoryIds: [6],
    brand: 'BerryFarm',
    minOrderQty: 1,
    shippingCost: 1.5,
    status: 1,
  ),

  ProductEntity(
    id: 'fr5',
    name: 'Orange (Navel)',
    filterLabel: 'Citrus',
    tag: 'fruit_orange',
    unit: 'kg',
    price: 1.59,
    originalPrice: 1.99,
    discount: 20,
    discountType: 'percent',
    thumbnail:
        'https://drive.google.com/uc?export=view&id=16O6On5nw-0O2wcqj7JSsLZA0hEsD9HSn',
    images: [
      'https://drive.google.com/uc?export=view&id=16O6On5nw-0O2wcqj7JSsLZA0hEsD9HSn'
    ],
    rating: 4.3,
    reviewCount: 70,
    currentStock: 210,
    shortDescription:
        'Juicy navel oranges — perfect for fresh juice and snacks.',
    categoryIds: [6],
    brand: 'CitrusGold',
    minOrderQty: 1,
    shippingCost: 1.0,
    status: 1,
  ),

  ProductEntity(
    id: 'fr6',
    name: 'Lemon',
    filterLabel: 'Fresh',
    tag: 'fruit_lemon',
    unit: 'kg',
    price: 1.29,
    originalPrice: null,
    discount: null,
    discountType: null,
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1d9-bPvNZBDwsbVAJOplkXsTzfNfDF6W2',
    images: [
      'https://drive.google.com/uc?export=view&id=1d9-bPvNZBDwsbVAJOplkXsTzfNfDF6W2'
    ],
    rating: 4.2,
    reviewCount: 50,
    currentStock: 160,
    shortDescription: 'Fresh lemons — bright flavor for cooking and beverages.',
    categoryIds: [6],
    brand: 'ZestFarm',
    minOrderQty: 1,
    shippingCost: 0.8,
    status: 1,
  ),

  ProductEntity(
    id: 'fr7',
    name: 'Banana (Bunch)',
    filterLabel: 'Low Price',
    tag: 'fruit_banana',
    unit: 'bunch',
    price: 1.49,
    originalPrice: 1.79,
    discount: 0.30,
    discountType: 'amount',
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1YfYRWGpVas4nqMTmBU_u4_IN72ImFHzt',
    images: [
      'https://drive.google.com/uc?export=view&id=1YfYRWGpVas4nqMTmBU_u4_IN72ImFHzt'
    ],
    rating: 4.4,
    reviewCount: 125,
    currentStock: 240,
    shortDescription:
        'Ripe bananas — sweet and convenient snack for the whole family.',
    categoryIds: [6],
    brand: 'TropicHarvest',
    minOrderQty: 1,
    shippingCost: 0.9,
    status: 1,
  ),

  ProductEntity(
    id: 'fr8',
    name: 'Grapes (Red)',
    filterLabel: 'Fresh',
    tag: 'fruit_grapes',
    unit: 'kg',
    price: 2.79,
    originalPrice: null,
    discount: null,
    discountType: null,
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1dFtAFqqw9gmIP9JDnioRMT_zuCvZEc2c',
    images: [
      'https://drive.google.com/uc?export=view&id=1dFtAFqqw9gmIP9JDnioRMT_zuCvZEc2c'
    ],
    rating: 4.5,
    reviewCount: 88,
    currentStock: 130,
    shortDescription: 'Sweet red grapes — perfect for snacking and desserts.',
    categoryIds: [6],
    brand: 'VineyardSelect',
    minOrderQty: 1,
    shippingCost: 1.4,
    status: 1,
  ),

  ProductEntity(
    id: 'fr9',
    name: 'Pomegranate',
    filterLabel: 'Premium',
    tag: 'fruit_pomegranate',
    unit: 'pcs',
    price: 3.99,
    originalPrice: 4.50,
    discount: 0.51,
    discountType: 'amount',
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1AKR1SARMWSVSr4QFr2tnIoRUYwHnLEW8',
    images: [
      'https://drive.google.com/uc?export=view&id=1AKR1SARMWSVSr4QFr2tnIoRUYwHnLEW8'
    ],
    rating: 4.6,
    reviewCount: 52,
    currentStock: 95,
    shortDescription:
        'Fresh pomegranates — sweet-tart seeds perfect for salads and juices.',
    categoryIds: [6],
    brand: 'RubyOrchard',
    minOrderQty: 1,
    shippingCost: 1.8,
    status: 1,
  ),

  ProductEntity(
    id: 'fr10',
    name: 'Pineapple (Whole)',
    filterLabel: 'Tropical',
    tag: 'fruit_pineapple',
    unit: 'pcs',
    price: 4.49,
    originalPrice: 4.99,
    discount: 0.50,
    discountType: 'amount',
    thumbnail:
        'https://drive.google.com/uc?export=view&id=1pIfG9XoDCNvFaA3yHaKWftvxjCoVunSw',
    images: [
      'https://drive.google.com/uc?export=view&id=1pIfG9XoDCNvFaA3yHaKWftvxjCoVunSw'
    ],
    rating: 4.5,
    reviewCount: 77,
    currentStock: 60,
    shortDescription:
        'Juicy pineapples — great for grilling, juicing, and desserts.',
    categoryIds: [6],
    brand: 'IslandTaste',
    minOrderQty: 1,
    shippingCost: 2.5,
    status: 1,
  ),

  ProductEntity(
    id: 'fr11',
    name: 'Mixed Fruits Pack',
    filterLabel: 'Bundle',
    tag: 'fruit_mixed',
    unit: 'pack',
    price: 9.99,
    originalPrice: 12.99,
    discount: 3.00,
    discountType: 'amount',
    thumbnail:
        'https://drive.google.com/uc?export=view&id=12Ia3hxcNbHS1FW1RaWUt2lAGZFiBn2sb',
    images: [
      'https://drive.google.com/uc?export=view&id=12Ia3hxcNbHS1FW1RaWUt2lAGZFiBn2sb'
    ],
    rating: 4.7,
    reviewCount: 150,
    currentStock: 45,
    shortDescription:
        'Carefully selected mixed fruits — apples, bananas, grapes and more.',
    categoryIds: [6],
    brand: 'FreshBundle',
    minOrderQty: 1,
    shippingCost: 3.0,
    status: 1,
  ),
];
