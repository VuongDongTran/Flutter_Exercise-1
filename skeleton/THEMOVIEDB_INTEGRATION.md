# TheMovieDB Integration Guide

## Overview

Complete integration of **TheMovieDB (TMDB)** API into the Flutter application with full BLoC pattern implementation, pagination support, error handling, and beautiful UI.

### API Credentials
- **Base URL**: `https://api.themoviedb.org/3`
- **API Key**: `xxxxxxxx`
- **Documentation**: https://developer.themoviedb.org/docs/getting-started

## Architecture Implementation

### Layer Structure

```
┌─────────────────────────────────┐
│   MoviesPage (Presentation)     │
│  - GridView with movie cards    │
│  - Category tabs                │
│  - Pagination (scroll to load)  │
└──────────────┬──────────────────┘
               │
┌──────────────▼──────────────────┐
│   MoviesCubit (Business Logic)  │
│  - loadMoviesByCategory()       │
│  - loadMoreMovies()             │
│  - State management             │
└──────────────┬──────────────────┘
               │
┌──────────────▼──────────────────┐
│   MoviesRepository (Data Layer) │
│  - Data abstraction             │
│  - Delegates to service         │
└──────────────┬──────────────────┘
               │
┌──────────────▼──────────────────┐
│  TheMovieDBService (API Layer)  │
│  - HTTP requests to TMDB API    │
│  - Response parsing             │
└─────────────────────────────────┘
```

## File Structure

### Models
```
lib/src/models/tmdb/
├── movie.dart              # Movie data model
├── movie.g.dart            # JSON serialization (generated)
├── movies_response.dart    # Paginated response
└── movies_response.g.dart  # JSON serialization (generated)
```

### Services
```
lib/src/services/themoviedb/
└── themoviedb_service.dart # API service implementation
```

### Repositories
```
lib/src/repositories/movies/
├── movies_repository.dart       # Interface
└── movies_repository_impl.dart  # Implementation
```

### BLoC
```
lib/src/bloc/movies/
├── movies_cubit.dart  # Business logic
└── movies_state.dart  # State definitions
```

### UI
```
lib/src/screen/movies/
└── movies_page.dart   # Movies list screen
```

### Constants
```
lib/src/common/
└── themoviedb_constants.dart # API config and enums
```

## Key Features

### 1. **Multiple Movie Categories**
- Now Playing
- Popular
- Top Rated
- Upcoming

```dart
enum MovieCategory {
  nowPlaying('Now Playing', '/movie/now_playing'),
  popular('Popular', '/movie/popular'),
  topRated('Top Rated', '/movie/top_rated'),
  upcoming('Upcoming', '/movie/upcoming'),
}
```

### 2. **State Management**
```dart
abstract class MoviesState {
  - MoviesInitial()           // Initial empty state
  - MoviesLoading()           // Loading first page
  - MoviesLoaded(...)         // Successfully loaded
  - MoviesPaginationLoading() // Loading next page
  - MoviesError(message)      // Error occurred
}
```

### 3. **Pagination**
- Infinite scroll implementation
- Detect scroll to bottom
- Load more movies automatically
- Combine with existing list

```dart
void _onScroll() {
  if (_scrollController.position.pixels ==
      _scrollController.position.maxScrollExtent) {
    context.read<MoviesCubit>().loadMoreMovies();
  }
}
```

### 4. **Image Caching**
Uses `CachedNetworkImage` for efficient image loading and caching.

```dart
CachedNetworkImage(
  imageUrl: movie.getPosterUrl(size: 'w342')!,
  fit: BoxFit.cover,
  placeholder: (context, url) => CircularProgressIndicator(),
  errorWidget: (context, url, error) => Icon(Icons.broken_image),
)
```

### 5. **Error Handling**
- Network errors
- Invalid responses
- Exception logging
- User-friendly messages

```dart
Future<void> loadMoviesByCategory(MovieCategory category) async {
  try {
    // Load data
  } catch (e, stackTrace) {
    developer.log('Error', error: e, stackTrace: stackTrace);
    emit(MoviesError(message: _getErrorMessage(e)));
  }
}
```

### 6. **Loading Animation**
Shimmer effect while loading movies:

```dart
Shimmer.fromColors(
  baseColor: AppColors.neutral10,
  highlightColor: AppColors.neutral10,
  child: Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
)
```

## Data Models

### Movie Model
```dart
Movie(
  id: int,                    // Unique identifier
  title: String?,             // Movie title
  overview: String?,          // Description
  posterPath: String?,        // Image path
  releaseDate: String?,       // Release date
  voteAverage: double,        // Rating (0-10)
  popularity: double,
  voteCount: int?,
  genreIds: List<int>?,
  // ... more fields
)
```

### Helper Methods
```dart
// Get poster image URL
String? posterUrl = movie.getPosterUrl(size: 'w342');

// Get backdrop image URL
String? backdropUrl = movie.getBackdropUrl(size: 'w1280');
```

## API Integration

### Request Format
```dart
GET /movie/now_playing?api_key=YOUR_API_KEY&page=1&language=en-US

Response:
{
  "page": 1,
  "results": [
    {
      "id": 123456,
      "title": "Movie Title",
      "poster_path": "/path/to/image.jpg",
      "vote_average": 7.5,
      ...
    },
    ...
  ],
  "total_pages": 50,
  "total_results": 1000
}
```

### Image URLs
```
Base: https://image.tmdb.org/t/p/

Sizes:
- w92      - Small poster
- w154     - Medium poster
- w342     - Large poster (used in app)
- w500     - Extra large poster
- w780     - Banner size
- w1280    - Backdrop size
```

## Dependency Injection

### Setup Order
1. **Services** registered first (depends on RestUtils)
2. **Repositories** registered (depends on Services)
3. **BLoCs** registered (depends on Repositories)

```dart
// services_dependencies.dart
injector.registerSingleton<TheMovieDBService>(
  TheMovieDBServiceImpl(
    injector.get<RestUtils>(instanceName: InstanceResflul.instanceApp),
  ),
);

// repositories_dependencies.dart
injector.registerSingleton<MoviesRepository>(
  MoviesRepositoryImpl(
    injector<TheMovieDBService>(),
  ),
);

// bloc_dependencies.dart
injector.registerFactory<MoviesCubit>(
  () => MoviesCubit(
    injector<MoviesRepository>(),
  ),
);
```

## Usage Examples

### Load Now Playing Movies
```dart
BlocBuilder<MoviesCubit, MoviesState>(
  builder: (context, state) {
    if (state is MoviesLoaded) {
      return GridView.builder(
        // Display movies
      );
    }
  },
)
```

### Switch Category
```dart
FilterChip(
  label: Text('Popular'),
  onSelected: (selected) {
    context.read<MoviesCubit>()
      .loadMoviesByCategory(MovieCategory.popular);
  },
)
```

### Handle Pagination
```dart
itemCount: movies.length,
itemBuilder: (context, index) {
  // Load more when near bottom
  if (index == movies.length - 1) {
    context.read<MoviesCubit>().loadMoreMovies();
  }
  return MovieCard(movies[index]);
},
```

## External Dependencies

### Added to pubspec.yaml
```yaml
dependencies:
  cached_network_image: ^3.3.0  # Image caching
  shimmer: ^3.0.0               # Loading animation
```

### Existing Dependencies Used
- `flutter_bloc: ^9.1.1`        # State management
- `json_annotation: ^4.11.0`    # JSON serialization
- `dio: ^5.3.1`                 # HTTP client
- `iconsax: ^0.0.8`             # Icon library
- `get_it: ^9.2.1`              # Dependency injection

## Testing

### Unit Test Example
```dart
test('loadMoviesByCategory should emit loaded state', () async {
  // Arrange
  final mockRepository = MockMoviesRepository();
  when(mockRepository.getMoviesByCategory(any))
    .thenAnswer((_) async => MoviesResponse(
      page: 1,
      results: [mockMovie],
      totalPages: 10,
      totalResults: 100,
    ));

  final cubit = MoviesCubit(mockRepository);

  // Act
  await cubit.loadMoviesByCategory(MovieCategory.nowPlaying);

  // Assert
  expect(
    cubit.state,
    isA<MoviesLoaded>().having((s) => s.movies.length, 'movies', 1),
  );
});
```

## Performance Optimization

1. **Image Caching**: `CachedNetworkImage` caches images locally
2. **Lazy Loading**: Movies loaded on demand via pagination
3. **State Preservation**: BLoC keeps loaded movies while adding new ones
4. **Error Recovery**: Retry button allows users to reload on error
5. **Pagination**: Only fetch needed data per page

## Future Enhancements

1. **Search Movies**: Add search functionality
2. **Filter**: By genre, rating, year
3. **Movie Details**: Tap movie card to show details
4. **Reviews & Ratings**: Show user reviews
5. **Watchlist**: Add to favorite/watchlist
6. **Local Cache**: Store movies locally
7. **Offline Support**: Show cached movies when offline
8. **Share**: Share movie info with others

## Troubleshooting

### Movies Not Loading
- Check API key in `themoviedb_constants.dart`
- Verify network connectivity
- Check BaseUrl configuration

### Images Not Loading
- Verify poster paths from API response
- Check image sizes in `getPosterUrl()`
- Check cached_network_image configuration

### Pagination Not Working
- Verify ScrollController is attached to GridView
- Check `hasMorePages` logic
- Ensure totalPages from API is accurate

## API Key Security

**⚠️ WARNING**: The current API key is exposed in code for demo purposes.

**Best Practices for Production**:
1. Store key in `.env` file (not in git)
2. Use Firebase Remote Config
3. Load from secure backend
4. Rotate key regularly
5. Monitor API usage

```dart
// Example: Load from environment
const String apiKey = String.fromEnvironment('TMDB_API_KEY');
```

## References

- [TheMovieDB API Docs](https://developer.themoviedb.org/)
- [BLoC Pattern](https://bloclibrary.dev/)
- [Flutter Image Caching](https://pub.dev/packages/cached_network_image)
- [Pagination Best Practices](https://flutter.dev/docs/development/data-and-backend/json)
