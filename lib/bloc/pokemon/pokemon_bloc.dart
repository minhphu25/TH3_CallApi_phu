import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pokemon_app/model/pokemon.dart';
import 'package:pokemon_app/repositories/pokemon_repository.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonRepository _pokemonRepository;
  List<Pokemon> _pokemonList = [];
  List<Pokemon> _filteredList = [];
  int? _currentGeneration;
  String _currentSearchText = '';

  PokemonBloc(this._pokemonRepository) : super(PokemonInitial());

  Pokemon? getPokemonByNumber(String number) {
    return _pokemonList.firstWhere((pokemon) => pokemon.num == number);
  }

  // Generation ranges (Pokémon ID ranges)
  Map<int, List<int>> _generationRanges = {
    1: [1, 151], // Gen 1: Kanto
    2: [152, 251], // Gen 2: Johto
    3: [252, 386], // Gen 3: Hoenn
    4: [387, 493], // Gen 4: Sinnoh
    5: [494, 649], // Gen 5: Unova
    6: [650, 721], // Gen 6: Kalos
    7: [722, 809], // Gen 7: Alola
    8: [810, 905], // Gen 8: Galar
    9: [906, 1025], // Gen 9: Paldea
  };

  List<Pokemon> _applyFilters() {
    List<Pokemon> result = List.from(_pokemonList);

    // Filter by generation
    if (_currentGeneration != null) {
      final range = _generationRanges[_currentGeneration]!;
      result = result
          .where((pokemon) => pokemon.id >= range[0] && pokemon.id <= range[1])
          .toList();
    }

    // Filter by search text
    if (_currentSearchText.isNotEmpty) {
      result = result
          .where((pokemon) => pokemon.name
              .toLowerCase()
              .contains(_currentSearchText.toLowerCase().trim()))
          .toList();
    }

    return result;
  }

  @override
  Stream<PokemonState> mapEventToState(PokemonEvent event) async* {
    if (event is GetPokemons) {
      try {
        yield PokemonLoading();
        await Future.delayed(Duration(milliseconds: 400));
        _pokemonList = await _pokemonRepository.getPokemons();
        _currentGeneration = null;
        _currentSearchText = '';
        _filteredList = _applyFilters();
        yield PokemonLoaded(_filteredList);
      } catch (e) {
        yield PokemonError('An error occured. Please try again later');
      }
    }

    if (event is FilterPokemons) {
      _currentSearchText = event.filterText;
      _filteredList = _applyFilters();
      yield PokemonLoaded(_filteredList);
    }

    if (event is FilterByGeneration) {
      _currentGeneration = event.generation;
      _filteredList = _applyFilters();
      yield PokemonLoaded(_filteredList);
    }
  }
}
