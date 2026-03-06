import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_app/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokemon_app/bloc/theme/theme_cubit.dart';
import 'package:pokemon_app/widgets/no_results.dart';
import 'package:pokemon_app/widgets/error_view.dart';
import 'package:pokemon_app/widgets/loading_view.dart';
import 'package:pokemon_app/widgets/app_search_bar.dart';
import 'package:pokemon_app/screens/home/pokemon_list.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String filterText = '';
  int? selectedGeneration; // null = All Pokemon

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PokemonBloc>(context).add(GetPokemons());
  }

  Widget _buildGenerationChips() {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildGenerationChip('All', null),
          _buildGenerationChip('Gen 1', 1),
          _buildGenerationChip('Gen 2', 2),
          _buildGenerationChip('Gen 3', 3),
          _buildGenerationChip('Gen 4', 4),
          _buildGenerationChip('Gen 5', 5),
          _buildGenerationChip('Gen 6', 6),
          _buildGenerationChip('Gen 7', 7),
          _buildGenerationChip('Gen 8', 8),
          _buildGenerationChip('Gen 9', 9),
          // To enable more generations, change limit in pokemon_repository.dart
        ],
      ),
    );
  }

  Widget _buildGenerationChip(String label, int? generation) {
    final bool isSelected = selectedGeneration == generation;
    return Padding(
      padding: EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (bool selected) {
          setState(() {
            selectedGeneration = generation;
          });
          BlocProvider.of<PokemonBloc>(context)
              .add(FilterByGeneration(generation));
        },
        backgroundColor: Theme.of(context).cardColor,
        selectedColor: Theme.of(context).primaryColor,
        labelStyle: TextStyle(
          color: isSelected
              ? Colors.white
              : Colors.cyan[600], // Màu xanh nước biển
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double toolbarHeight =
        kToolbarHeight + 160; // Increased for generation chips
    final ThemeCubit themeCubit = context.read<ThemeCubit>();

    return AnnotatedRegion(
      value: themeCubit.isDarkMode()
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: NestedScrollView(
          clipBehavior: Clip.none,
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  backgroundColor: Colors.transparent,
                  collapsedHeight: toolbarHeight,
                  expandedHeight: toolbarHeight,
                  flexibleSpace: AppSearchBar(
                      preferredSize: Size.fromHeight(toolbarHeight),
                      onQueryChange: (String text) {
                        BlocProvider.of<PokemonBloc>(context)
                            .add(FilterPokemons(text));
                      }),
                  floating: true,
                  pinned: false,
                  snap: true,
                  elevation: 0,
                ),
              ),
            ];
          },
          body: BlocBuilder(
            builder: (context, state) {
              if (state is PokemonLoaded) {
                if (state.pokemonList.isEmpty) {
                  return NoResults(
                      description: 'No pokémon found matching your search.');
                }
                return Column(
                  children: [
                    _buildGenerationChips(),
                    Expanded(
                        child: PokemonList(pokemonList: state.pokemonList)),
                  ],
                );
              } else if (state is PokemonLoading) {
                return LoadingView(
                  message: 'Loading Pokémon data from API...',
                );
              } else if (state is PokemonError) {
                return ErrorView(
                  message: state.message,
                  onRetry: () {
                    BlocProvider.of<PokemonBloc>(context).add(GetPokemons());
                  },
                );
              } else {
                return LoadingView(
                  message: 'Initializing...',
                );
              }
            },
            bloc: BlocProvider.of<PokemonBloc>(context),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          splashColor: Theme.of(context).colorScheme.primary,
          onPressed: () {
            BlocProvider.of<PokemonBloc>(context).add(GetPokemons());
          },
          child: Icon(Icons.refresh,
              color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
    );
  }
}
