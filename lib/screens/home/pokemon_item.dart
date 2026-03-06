import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pokemon_app/widgets/pokemon_type.dart';
import 'package:pokemon_app/model/pokemon.dart';
import 'package:pokemon_app/screens/home/pokemon_list.dart';
import 'package:pokemon_app/screens/pokemon_detail/pokemon_detail.dart';

class PokemonItem extends StatelessWidget {
  const PokemonItem({Key? key, required this.pokemon}) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = (screenWidth -
            ((PokemonList.crossAxisCount - 1) * PokemonList.crossAxisSpacing)) /
        PokemonList.crossAxisCount;
    double itemHeight = itemWidth / PokemonList.childAspectRatio;
    double imageSize = itemHeight / 2;

    return Padding(
      padding: EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: PokemonDetail(pokemon: pokemon),
            ),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 3.0,
          shadowColor: Colors.black26,
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        pokemon.name,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headlineSmall,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '#${pokemon.num}',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: pokemon.type
                            .map(
                              (type) =>
                                  PokemonType(type: type, size: TypeSize.small),
                            )
                            .toList(),
                      ),
                      Hero(
                        tag: pokemon.img,
                        child: CachedNetworkImage(
                          imageUrl: pokemon.img,
                          imageBuilder: (context, imageProvider) => Container(
                            height: imageSize,
                            width: imageSize,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Container(
                            height: imageSize,
                            width: imageSize,
                            child: Padding(
                              padding: EdgeInsets.all(32.0),
                              child: CircularProgressIndicator(
                                color: Theme.of(context).indicatorColor,
                                strokeWidth: 2.4,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            height: imageSize,
                            width: imageSize,
                            decoration: BoxDecoration(
                              color: Theme.of(context).disabledColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.image_not_supported,
                                color: Theme.of(context).primaryColor,
                                size: 32,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
