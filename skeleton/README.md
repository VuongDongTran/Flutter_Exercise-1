# Flutter Skeleton Project

A comprehensive Flutter skeleton project for training and rapid development, implementing clean architecture with BLoC pattern, multi-environment configuration, and best practices.

## 📋 Table of Contents

- [Purpose](#purpose)
- [Features](#features)
- [Architecture](#architecture)
- [Libraries Used](#libraries-used)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Environment Configuration](#environment-configuration)
- [How to Implement New Features](#how-to-implement-new-features)
- [Deployment](#deployment)
- [Code Conventions](#code-conventions)

---

## 🎯 Purpose

This skeleton project serves as:

- **Training Resource**: A complete reference implementation for Flutter developers learning clean architecture and BLoC pattern
- **Project Template**: Ready-to-use foundation for new Flutter applications
- **Best Practices Demo**: Showcases industry-standard patterns and configurations
- **Multi-Environment Setup**: Pre-configured for dev/uat/prod environments

---

## ✨ Features

### Current Implementation

- ✅ **Multi-Environment Configuration** (dev/uat/prod)
- ✅ **Clean Architecture** with separation of concerns
- ✅ **Authentication Flow** (Login)
- ✅ **TheMovieDB Integration** (API demonstration)
  - Now Playing, Popular, Top Rated, Upcoming movies
  - Pagination support
  - Image caching
  - Shimmer loading effects
- ✅ **Localization Support** (English/Vietnamese)
- ✅ **Dependency Injection** with GetIt
- ✅ **State Management** with BLoC
- ✅ **Network Error Handling**
- ✅ **Custom Theming**

---

## 🏗️ Architecture

### Clean Architecture Layers

```
┌─────────────────────────────────────────┐
│            Presentation Layer            │
│  (UI, BLoC, State Management)           │
└─────────────────────────────────────────┘
                  ↓↑
┌─────────────────────────────────────────┐
│            Domain Layer                  │
│  (Business Logic, Use Cases)            │
└─────────────────────────────────────────┘
                  ↓↑
┌─────────────────────────────────────────┐
│            Data Layer                    │
│  (Repository, Service, Models)          │
└─────────────────────────────────────────┘
```

### Data Flow

```
UI → BLoC → Repository → Service → API
                ↓
         Mapper (Service Model → View Model)
                ↓
UI ← BLoC ← View Model
```

### Design Patterns Applied

1. **BLoC Pattern**: State management and business logic separation
2. **Repository Pattern**: Abstract data sources from business logic
3. **Dependency Injection**: Loose coupling with GetIt
4. **Mapper Pattern**: Transform service models to view models
5. **Factory Pattern**: JSON serialization and object creation
6. **Singleton Pattern**: Shared instances (DI container, services)

---

## 📚 Libraries Used

### Core Dependencies

| Library | Version | Purpose |
|---------|---------|---------|
| `flutter_bloc` | ^8.1.3 | State management with BLoC pattern |
| `dio` | ^5.4.0 | HTTP client for API requests |
| `get_it` | ^7.6.4 | Dependency injection container |
| `cached_network_image` | ^3.3.0 | Image caching and loading |
| `shimmer` | ^3.0.0 | Loading skeleton animations |
| `connectivity_plus` | ^5.0.1 | Network connectivity checking |
| `basic_utils` | ^5.6.1 | Utility functions |
| `json_annotation` | ^4.8.1 | JSON serialization annotations |
| `iconsax` | ^0.0.8 | Modern icon set |

### Dev Dependencies

| Library | Version | Purpose |
|---------|---------|---------|
| `build_runner` | ^2.4.6 | Code generation |
| `json_serializable` | ^6.7.1 | JSON serialization code gen |
| `flutter_launcher_icons` | ^0.13.1 | App icon generation |

---

## 📁 Project Structure

```
lib/
├── main.dart                          # App entry point
└── src/
    ├── base/                          # Base classes and utilities
    │   ├── restful/                   # REST API utilities
    │   │   ├── base_response.dart     # Generic API response wrapper
    │   │   ├── data_result.dart       # Result wrapper (success/failure)
    │   │   ├── error_handler.dart     # Error handling utilities
    │   │   └── rest_utility.dart      # HTTP client wrapper
    │   ├── services/                  # Base service classes
    │   └── widget/                    # Base widgets
    │
    ├── bloc/                          # BLoC state management
    │   ├── auth/                      # Authentication BLoC
    │   │   ├── login_cubit.dart
    │   │   └── login_state.dart
    │   └── movies/                    # Movies BLoC
    │       ├── movies_cubit.dart
    │       └── movies_state.dart
    │
    ├── common/                        # Common utilities and constants
    │   ├── api_path.dart              # API endpoint constants
    │   ├── app_config.dart            # App configuration
    │   ├── app_localizations.dart     # Localization utilities
    │   ├── env_config.dart            # Environment configuration
    │   └── themoviedb_constants.dart  # TheMovieDB constants
    │
    ├── data/                          # Data layer
    │   └── repository/                # Repositories
    │       ├── auth_repository.dart
    │       └── movies_repository.dart
    │
    ├── models/                        # Data models
    │   ├── service/                   # Service models (from API)
    │   │   ├── auth/                  # Auth models
    │   │   ├── movie/                 # Movie models
    │   │   └── base_model_service.dart
    │   └── view/                      # View models (for UI)
    │       ├── menu/                  # Menu models
    │       └── movie/                 # Movie view models
    │           ├── movie_view_model.dart
    │           └── movie_mapper.dart
    │
    ├── screen/                        # UI screens
    │   ├── auth/                      # Authentication screens
    │   │   └── login_page.dart
    │   ├── movies/                    # Movies screens
    │   │   ├── movies_page.dart
    │   │   └── movies_tab_page.dart
    │   ├── tv_shows/                  # TV Shows screens
    │   ├── home_page.dart             # Main home screen
    │   └── loading_page.dart          # Loading screen
    │
    ├── services/                      # API services
    │   ├── auth/                      # Auth service
    │   │   └── auth_service.dart
    │   ├── themoviedb/                # TheMovieDB service
    │   │   └── themoviedb_service.dart
    │   └── general/                   # General services
    │
    ├── theme/                         # App theming
    │   ├── colors_theme.dart          # Color definitions
    │   └── theme.dart                 # Theme configuration
    │
    └── widgets/                       # Reusable widgets
        ├── bottom_appbar.dart         # Bottom navigation
        ├── custom_button.dart         # Custom buttons
        └── input_text_field.dart      # Custom text fields

assets/
├── config/                           # Environment configs
│   └── server_dev.json
├── fonts/                            # Custom fonts
├── images/                           # Static images
└── translations/                     # Localization files
    ├── en.json                       # English translations
    └── vi.json                       # Vietnamese translations
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK: `>=3.4.0`
- Dart SDK: `>=3.0.0`
- iOS Development: Xcode 13.0+, macOS
- Android Development: Android Studio, JDK 11+

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd skeleton
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code** (for JSON serialization)
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app** (default dev environment)
   ```bash
   # Android
   flutter run --flavor dev
   
   # iOS
   flutter run --flavor dev -d "iPhone Simulator"
   ```

---

## ⚙️ Environment Configuration

### Available Environments

- **dev**: Development environment
- **uat**: User Acceptance Testing environment
- **prod**: Production environment

### Configuration Files

Environment-specific configs are stored in `assets/config/`:
- `server_dev.json`
- `server_uat.json` (to be created)
- `server_prod.json` (to be created)

### Environment Setup

#### 1. Create Environment Config Files

**Example: `assets/config/server_dev.json`**
```json
{
  "baseUrl": "https://api.dev.example.com",
  "apiKey": "dev-api-key",
  "timeout": 30000
}
```

#### 2. Load Configuration

The app automatically loads the correct config based on the `ENVIRONMENT` parameter:

```dart
// lib/src/common/env_config.dart
class EnvConfig {
  static Future<void> loadEnvironment(String environment) async {
    final config = await rootBundle.loadString(
      'assets/config/server_${environment.toLowerCase()}.json'
    );
    // Parse and use config
  }
}
```

#### 3. Run with Specific Environment

```bash
# Using --dart-define
flutter run --dart-define=ENVIRONMENT=dev

# Using VS Code tasks (see .vscode/tasks.json)
# Press Cmd+Shift+P → Run Task → Flutter: Run (dev)
```

### Android Flavors Configuration

**File: `android/app/build.gradle.kts`**

```kotlin
flavorDimensions += "environment"
productFlavors {
    create("dev") {
        dimension = "environment"
        applicationIdSuffix = ".dev"
        versionNameSuffix = "-dev"
    }
    create("uat") {
        dimension = "environment"
        applicationIdSuffix = ".uat"
        versionNameSuffix = "-uat"
    }
    create("prod") {
        dimension = "environment"
    }
}
```

### iOS Schemes Configuration

iOS schemes are configured in Xcode:
- `Runner-Dev`
- `Runner-UAT`
- `Runner-Prod`

---

## 🛠️ How to Implement New Features

### Step-by-Step Guide

#### 1. Define Service Model (Data from API)

**Location:** `lib/src/models/service/<feature_name>/`

```dart
// lib/src/models/service/product/product_model.dart
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class Product {
  final int id;
  final String name;
  final double price;
  final String? description;
  
  Product({
    required this.id,
    required this.name,
    required this.price,
    this.description,
  });
  
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
```

**Run code generation:**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

#### 2. Define View Model (Data for UI)

**Location:** `lib/src/models/view/<feature_name>/`

```dart
// lib/src/models/view/product/product_view_model.dart
class ProductViewModel {
  final int id;
  final String name;
  final String displayPrice;
  final bool isAvailable;
  
  ProductViewModel({
    required this.id,
    required this.name,
    required this.displayPrice,
    required this.isAvailable,
  });
}
```

#### 3. Create Mapper

**Location:** `lib/src/models/view/<feature_name>/`

```dart
// lib/src/models/view/product/product_mapper.dart
import '../../service/product/product_model.dart';
import '../../../base/mapping/base_mapping.dart';
import 'product_view_model.dart';

class ProductMapper extends Mapper<Product, ProductViewModel> {
  @override
  ProductViewModel map(Product input) {
    return ProductViewModel(
      id: input.id,
      name: input.name,
      displayPrice: '\$${input.price.toStringAsFixed(2)}',
      isAvailable: input.price > 0,
    );
  }
}
```

#### 4. Create API Service

**Location:** `lib/src/services/<feature_name>/`

```dart
// lib/src/services/product/product_service.dart
import 'dart:convert';
import '../../base/services/base_service.dart';

abstract class ProductService extends BaseService {
  ProductService(super.restUtils);
  
  Future<List<Product>> getProducts();
  Future<Product> getProductById(int id);
}

class ProductServiceImpl extends ProductService {
  ProductServiceImpl(super.restUtils);
  
  @override
  Future<List<Product>> getProducts() async {
    try {
      final response = await rest.dio.get<String>('/products');
      
      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> jsonData = json.decode(response.data!);
        return jsonData.map((json) => Product.fromJson(json)).toList();
      }
      throw Exception('Failed to load products');
    } catch (e) {
      rethrow;
    }
  }
  
  @override
  Future<Product> getProductById(int id) async {
    try {
      final response = await rest.dio.get<String>('/products/$id');
      
      if (response.statusCode == 200 && response.data != null) {
        final Map<String, dynamic> jsonData = json.decode(response.data!);
        return Product.fromJson(jsonData);
      }
      throw Exception('Failed to load product');
    } catch (e) {
      rethrow;
    }
  }
}
```

#### 5. Create Repository

**Location:** `lib/src/data/repository/`

```dart
// lib/src/data/repository/product_repository.dart
import '../../models/service/product/product_model.dart';
import '../../services/product/product_service.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<Product> getProductById(int id);
}

class ProductRepositoryImpl implements ProductRepository {
  final ProductService _productService;
  
  ProductRepositoryImpl(this._productService);
  
  @override
  Future<List<Product>> getProducts() {
    return _productService.getProducts();
  }
  
  @override
  Future<Product> getProductById(int id) {
    return _productService.getProductById(id);
  }
}
```

#### 6. Define BLoC States

**Location:** `lib/src/bloc/<feature_name>/`

```dart
// lib/src/bloc/product/product_state.dart
import '../../models/view/product/product_view_model.dart';

abstract class ProductState {
  const ProductState();
  
  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(List<ProductViewModel> products) loaded,
    required T Function(String message) error,
  });
  
  T? maybeWhen<T>({
    T Function()? initial,
    T Function()? loading,
    T Function(List<ProductViewModel> products)? loaded,
    T Function(String message)? error,
    required T Function() orElse,
  });
}

class ProductInitial extends ProductState {
  const ProductInitial();
  
  @override
  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(List<ProductViewModel> products) loaded,
    required T Function(String message) error,
  }) => initial();
  
  @override
  T? maybeWhen<T>({
    T Function()? initial,
    T Function()? loading,
    T Function(List<ProductViewModel> products)? loaded,
    T Function(String message)? error,
    required T Function() orElse,
  }) => initial != null ? initial() : orElse();
}

class ProductLoading extends ProductState {
  const ProductLoading();
  
  @override
  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(List<ProductViewModel> products) loaded,
    required T Function(String message) error,
  }) => loading();
  
  @override
  T? maybeWhen<T>({
    T Function()? initial,
    T Function()? loading,
    T Function(List<ProductViewModel> products)? loaded,
    T Function(String message)? error,
    required T Function() orElse,
  }) => loading != null ? loading() : orElse();
}

class ProductLoaded extends ProductState {
  final List<ProductViewModel> products;
  
  const ProductLoaded(this.products);
  
  @override
  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(List<ProductViewModel> products) loaded,
    required T Function(String message) error,
  }) => loaded(products);
  
  @override
  T? maybeWhen<T>({
    T Function()? initial,
    T Function()? loading,
    T Function(List<ProductViewModel> products)? loaded,
    T Function(String message)? error,
    required T Function() orElse,
  }) => loaded != null ? loaded(products) : orElse();
}

class ProductError extends ProductState {
  final String message;
  
  const ProductError(this.message);
  
  @override
  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(List<ProductViewModel> products) loaded,
    required T Function(String message) error,
  }) => error(message);
  
  @override
  T? maybeWhen<T>({
    T Function()? initial,
    T Function()? loading,
    T Function(List<ProductViewModel> products)? loaded,
    T Function(String message)? error,
    required T Function() orElse,
  }) => error != null ? error(message) : orElse();
}
```

#### 7. Create BLoC/Cubit

**Location:** `lib/src/bloc/<feature_name>/`

```dart
// lib/src/bloc/product/product_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/product_repository.dart';
import '../../models/view/product/product_mapper.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository _repository;
  final ProductMapper _mapper;
  
  ProductCubit(this._repository, this._mapper) 
      : super(const ProductInitial());
  
  Future<void> loadProducts() async {
    try {
      emit(const ProductLoading());
      
      final products = await _repository.getProducts();
      final viewModels = products.map((p) => _mapper.map(p)).toList();
      
      emit(ProductLoaded(viewModels));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
  
  Future<void> loadProductById(int id) async {
    try {
      emit(const ProductLoading());
      
      final product = await _repository.getProductById(id);
      final viewModel = _mapper.map(product);
      
      emit(ProductLoaded([viewModel]));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
```

#### 8. Register Dependencies

**Location:** `lib/src/common/app_config.dart` or specific dependency file

```dart
// Register services
injector.registerLazySingleton<ProductService>(
  () => ProductServiceImpl(injector.get<RestUtils>())
);

// Register repositories
injector.registerLazySingleton<ProductRepository>(
  () => ProductRepositoryImpl(injector.get<ProductService>())
);

// Register mappers
injector.registerSingleton<ProductMapper>(ProductMapper());
```

#### 9. Create UI Screen

**Location:** `lib/src/screen/<feature_name>/`

```dart
// lib/src/screen/product/product_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/product/product_cubit.dart';
import '../../bloc/product/product_state.dart';
import '../../common/app_localizations.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});
  
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
    // Load products on init
    context.read<ProductCubit>().loadProducts();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('product.title')),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          return state.maybeWhen(
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loaded: (products) => ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text(product.displayPrice),
                  trailing: product.isAvailable
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : const Icon(Icons.cancel, color: Colors.red),
                );
              },
            ),
            error: (message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(tr('product.error_loading')),
                  const SizedBox(height: 16),
                  Text(message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ProductCubit>().loadProducts();
                    },
                    child: Text(tr('common.retry')),
                  ),
                ],
              ),
            ),
            orElse: () => const SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
```

#### 10. Create Tab Page with BLoC Provider

**Location:** `lib/src/screen/<feature_name>/`

```dart
// lib/src/screen/product/product_tab_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../bloc/product/product_cubit.dart';
import '../../data/repository/product_repository.dart';
import '../../models/view/product/product_mapper.dart';
import 'product_page.dart';

class ProductTabPage extends StatelessWidget {
  const ProductTabPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(
        GetIt.I.get<ProductRepository>(),
        GetIt.I.get<ProductMapper>(),
      ),
      child: const ProductPage(),
    );
  }
}
```

#### 11. Add Translations

**File: `assets/translations/en.json`**
```json
{
  "product": {
    "title": "Products",
    "error_loading": "Error loading products",
    "no_products": "No products found"
  }
}
```

**File: `assets/translations/vi.json`**
```json
{
  "product": {
    "title": "Sản phẩm",
    "error_loading": "Lỗi tải sản phẩm",
    "no_products": "Không tìm thấy sản phẩm"
  }
}
```

#### 12. Add to Navigation

Update `home_page.dart` or navigation configuration:

```dart
final List<Widget> _tabPages = const [
  MoviesTabPage(),
  TVShowsTabPage(),
  ProductTabPage(), // Add new tab
];
```

---

## 📦 Deployment

### Android Deployment

#### Build APK

```bash
# Dev environment
flutter build apk --flavor dev --dart-define=ENVIRONMENT=dev

# UAT environment
flutter build apk --flavor uat --dart-define=ENVIRONMENT=uat

# Production environment
flutter build apk --flavor prod --dart-define=ENVIRONMENT=prod
```

#### Build App Bundle (for Play Store)

```bash
# Dev environment
flutter build appbundle --flavor dev --dart-define=ENVIRONMENT=dev

# Production environment
flutter build appbundle --flavor prod --dart-define=ENVIRONMENT=prod
```

#### Release Build Configuration

**File: `android/app/build.gradle.kts`**

```kotlin
signingConfigs {
    create("release") {
        storeFile = file("path/to/keystore.jks")
        storePassword = System.getenv("KEYSTORE_PASSWORD")
        keyAlias = System.getenv("KEY_ALIAS")
        keyPassword = System.getenv("KEY_PASSWORD")
    }
}

buildTypes {
    release {
        signingConfig = signingConfigs.getByName("release")
        isMinifyEnabled = true
        proguardFiles(
            getDefaultProguardFile("proguard-android-optimize.txt"),
            "proguard-rules.pro"
        )
    }
}
```

### iOS Deployment

#### Build for Device

```bash
# Dev environment
flutter build ios --flavor dev --dart-define=ENVIRONMENT=dev

# UAT environment
flutter build ios --flavor uat --dart-define=ENVIRONMENT=uat

# Production environment
flutter build ios --flavor prod --dart-define=ENVIRONMENT=prod
```

#### Build IPA (for TestFlight/App Store)

```bash
# Dev environment
flutter build ipa --flavor dev --dart-define=ENVIRONMENT=dev

# Production environment
flutter build ipa --flavor prod --dart-define=ENVIRONMENT=prod
```

#### Archive with Xcode

1. Open `ios/Runner.xcworkspace` in Xcode
2. Select the appropriate scheme (Runner-Dev, Runner-UAT, Runner-Prod)
3. Product → Archive
4. Upload to App Store Connect

### VS Code Tasks

Pre-configured tasks are available in `.vscode/tasks.json`:

- **Run Tasks** (Cmd+Shift+P → Run Task):
  - `Flutter: Run (dev)`
  - `Flutter: Run (uat)`
  - `Flutter: Run (prod)`
  - `Flutter: Build APK (dev)`
  - `Flutter: Build APK (prod)`
  - `Flutter: Build iOS (dev)`
  - `Flutter: Build iOS (prod)`

### CI/CD Integration

#### Example: GitHub Actions

```yaml
name: Build and Deploy

on:
  push:
    branches: [ main, develop ]

jobs:
  build-android:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.24.0'
      - run: flutter pub get
      - run: flutter build apk --flavor prod --dart-define=ENVIRONMENT=prod
      
  build-ios:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.24.0'
      - run: flutter pub get
      - run: flutter build ios --flavor prod --dart-define=ENVIRONMENT=prod --no-codesign
```

---

## 📝 Code Conventions

### File Naming

- **Dart files**: `snake_case.dart` (e.g., `product_service.dart`)
- **Classes**: `PascalCase` (e.g., `ProductService`)
- **Variables/Functions**: `camelCase` (e.g., `loadProducts`)
- **Constants**: `camelCase` or `SCREAMING_SNAKE_CASE` (e.g., `apiBaseUrl` or `API_BASE_URL`)

### Import Organization

```dart
// 1. Dart core libraries
import 'dart:convert';
import 'dart:async';

// 2. Flutter libraries
import 'package:flutter/material.dart';

// 3. Third-party packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

// 4. Project imports (relative)
import '../../models/product.dart';
import '../services/product_service.dart';
```

### State Management

- Use **Cubit** for simple state management
- Use **Bloc** for complex state with events
- Always emit loading state before async operations
- Handle errors gracefully with error states

### Model Separation

- **Service Models** (`lib/src/models/service/`): Raw data from API, use JSON serialization
- **View Models** (`lib/src/models/view/`): UI-specific data, no JSON serialization needed
- Use **Mappers** to transform Service Models → View Models

### Error Handling

```dart
try {
  emit(const Loading());
  final result = await repository.getData();
  emit(Loaded(result));
} catch (e) {
  emit(Error(e.toString()));
}
```

### Localization

- Add all user-facing strings to `assets/translations/`
- Use `tr('key.subkey')` function for translations
- Never hardcode strings in UI

---

## 🧪 Testing

### Run Tests

```bash
# All tests
flutter test

# Specific test file
flutter test test/widget_test.dart

# With coverage
flutter test --coverage
```

### Test Structure

```
test/
├── unit/                    # Unit tests
│   ├── services/
│   ├── repositories/
│   └── bloc/
├── widget/                  # Widget tests
│   └── screens/
└── integration/             # Integration tests
```

---

## 🐛 Troubleshooting

### Common Issues

#### 1. Build Runner Conflicts

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

#### 2. Pod Install Issues (iOS)

```bash
cd ios
pod deintegrate
pod install
cd ..
```

#### 3. Gradle Build Failed (Android)

```bash
cd android
./gradlew clean
./gradlew build
cd ..
```

#### 4. Environment Not Loading

- Verify `--dart-define=ENVIRONMENT=dev` is passed
- Check config files exist in `assets/config/`
- Ensure `pubspec.yaml` includes `assets/config/` in assets

---

## 📖 Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [BLoC Library](https://bloclibrary.dev/)
- [Dio HTTP Client](https://pub.dev/packages/dio)
- [GetIt Dependency Injection](https://pub.dev/packages/get_it)
- [TheMovieDB API](https://developers.themoviedb.org/3)

---

## 👥 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed for training purposes. Modify as needed for your projects.

---

## 🙏 Acknowledgments

- Flutter Team for the amazing framework
- BLoC Library maintainers
- TheMovieDB for the free API
- All open-source contributors

---

**Happy Coding! 🚀**
