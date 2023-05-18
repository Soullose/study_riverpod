import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class Film {
  final String id;
  final String title;
  final String description;
  final bool isFavorite;

  const Film({
    required this.id,
    required this.title,
    required this.description,
    required this.isFavorite,
  });

  Film copy({
    required bool isFavorite,
  }) =>
      Film(
        id: id,
        title: title,
        description: description,
        isFavorite: isFavorite,
      );

  @override
  String toString() => 'Film(id: $id,'
      ' title: $title, '
      'description: $description, '
      'isFavorite: $isFavorite)';

  @override
  bool operator ==(covariant Film other) =>
      id == other.id && isFavorite == other.isFavorite;

  @override
  int get hashCode => Object.hashAll(
        [
          id,
          isFavorite,
        ],
      );
}

const allFilms = [
  Film(
    id: '1',
    title: 'The Shawshank 1',
    description: 'description .............',
    isFavorite: false,
  ),
  Film(
    id: '2',
    title: 'The Shawshank 2',
    description: 'description .............',
    isFavorite: false,
  ),
  Film(
    id: '3',
    title: 'The Shawshank 3',
    description: 'description .............',
    isFavorite: false,
  ),
  Film(
    id: '4',
    title: 'The Shawshank 4',
    description: 'description .............',
    isFavorite: false,
  ),
  Film(
    id: '5',
    title: 'The Shawshank 5',
    description: 'description .............',
    isFavorite: false,
  ),
  Film(
    id: '6',
    title: 'The Shawshank 6',
    description: 'description .............',
    isFavorite: false,
  ),
];

class FilmNotifier extends StateNotifier<List<Film>> {
  FilmNotifier() : super(allFilms);

  void update(Film film, bool isFavorite) {
    state = state
        .map((thisFilm) => thisFilm.id == film.id
            ? thisFilm.copy(isFavorite: isFavorite)
            : thisFilm)
        .toList();
  }
}

enum FavoriteStatus {
  all,
  favorite,
  notFavorite,
}

final favoriteStatusProvider = StateProvider((_) => FavoriteStatus.all);

final allFilmProvider =
    StateNotifierProvider<FilmNotifier, List<Film>>((_) => FilmNotifier());

final favoriteFilmProvider = Provider<Iterable<Film>>(
    (ref) => ref.watch(allFilmProvider).where((film) => film.isFavorite));

final notFavoriteFilmProvider = Provider<Iterable<Film>>(
    (ref) => ref.watch(allFilmProvider).where((film) => !film.isFavorite));

class Example6 extends ConsumerWidget {
  const Example6({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example_6'),
      ),
      body: Column(
        children: [
          const FilterWidget(),
          Consumer(
            builder: (context, ref, child) {
              final filter = ref.watch(favoriteStatusProvider);
              switch (filter) {
                case FavoriteStatus.all:
                  return FilmWidget(provider: allFilmProvider);
                case FavoriteStatus.favorite:
                  return FilmWidget(provider: favoriteFilmProvider);
                case FavoriteStatus.notFavorite:
                  return FilmWidget(provider: notFavoriteFilmProvider);
              }
            },
          )
        ],
      ),
    );
  }
}

class FilmWidget extends ConsumerWidget {
  final AlwaysAliveProviderBase<Iterable<Film>> provider;

  const FilmWidget({required this.provider, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final films = ref.watch(provider);

    return Expanded(
        child: ListView.builder(
      itemCount: films.length,
      itemBuilder: (context, index) {
        final film = films.elementAt(index);
        final favoriteIcon = film.isFavorite
            ? const Icon(Icons.favorite)
            : const Icon(Icons.favorite_border);
        return ListTile(
          title: Text(film.title),
          subtitle: Text(film.description),
          trailing: IconButton(
              onPressed: () {
                final isFavorite = !film.isFavorite;
                ref.read(allFilmProvider.notifier).update(
                      film,
                      isFavorite,
                    );
              },
              icon: favoriteIcon),
        );
      },
    ));
  }
}

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return DropdownButton(
          value: ref.watch(favoriteStatusProvider),
          items: FavoriteStatus.values
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e.toString().split('.').last),
                  ))
              .toList(),
          onChanged: (FavoriteStatus? fs) {
            ref.read(favoriteStatusProvider.notifier).state = fs!;
          },
        );
      },
    );
  }
}
