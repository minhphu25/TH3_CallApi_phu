import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_app/model/pokemon.dart';
import 'package:pokemon_app/model/evolution.dart';

class PokemonRepository {
  // PokeAPI official endpoint
  static const String baseUrl = 'https://pokeapi.co/api/v2';

  // Test mode: Set to true to simulate network error for testing Error UI
  static const bool _testErrorMode = false;

  PokemonRepository();

  Future<List<Pokemon>> getPokemons() async {
    try {
      // Load from local JSON file (optimized with 50 Pokemon)
      final String jsonString = await rootBundle.loadString('db/data.json');
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);
      final List<dynamic> pokemonData = jsonData['pokemon'] as List;

      // Map JSON data to Pokemon objects
      List<Pokemon> pokemonList = pokemonData.map((data) {
        return _mapJsonToPokemon(data as Map<String, dynamic>);
      }).toList();

      print('Loaded ${pokemonList.length} Pokemon from local database');
      return pokemonList;
    } catch (e) {
      throw Exception('Error loading Pokemon data: $e');
    }
  }

  // Map local JSON data to our Pokemon model
  Pokemon _mapJsonToPokemon(Map<String, dynamic> data) {
    final id = data['id'] as int;
    final num = data['num'] as String;
    final name = data['name'] as String;
    final img = data['img'] as String;
    final type = List<String>.from(data['type'] as List);
    final height = data['height'] as String;
    final weight = data['weight'] as String;
    final weaknesses = List<String>.from(data['weaknesses'] as List? ?? []);

    return Pokemon(
      id: id,
      num: num,
      name: name,
      img: img,
      type: type,
      height: height,
      weight: weight,
      candy: data['candy'] as String? ?? '$name Candy',
      candyCount: data['candy_count'] as int? ?? 25,
      egg: data['egg'] as String? ?? 'Not in Eggs',
      spawnChance: data['spawn_chance']?.toString() ?? '0',
      avgSpawns: data['avg_spawns']?.toString() ?? '0',
      spawnTime: data['spawn_time'] as String? ?? 'N/A',
      multipliers: data['multipliers'] != null
          ? List<double>.from(data['multipliers'] as List)
          : null,
      weaknesses: weaknesses,
      nextEvolution: data['next_evolution'] != null
          ? List<Evolution>.from((data['next_evolution'] as List).map((e) =>
              Evolution(
                  num: e['num'] as String,
                  name: e['name'] as String,
                  requiredCandy: e['required_candy'] as int?)))
          : null,
      prevEvolution: data['prev_evolution'] != null
          ? List<Evolution>.from((data['prev_evolution'] as List).map((e) =>
              Evolution(
                  num: e['num'] as String,
                  name: e['name'] as String,
                  requiredCandy: e['required_candy'] as int?)))
          : null,
    );
  }
}
    List<Evolution>? nextEvolution;
    List<Evolution>? prevEvolution;

    // Evolution chains mapping (Gen 1-9)
    final evolutionMap = {
      // Gen 1 - Kanto
      1: {
        'next': [Evolution(num: '002', name: 'Ivysaur')]
      },
      2: {
        'next': [Evolution(num: '003', name: 'Venusaur')],
        'prev': [Evolution(num: '001', name: 'Bulbasaur')]
      },
      3: {
        'prev': [Evolution(num: '002', name: 'Ivysaur')]
      },

      4: {
        'next': [Evolution(num: '005', name: 'Charmeleon')]
      },
      5: {
        'next': [Evolution(num: '006', name: 'Charizard')],
        'prev': [Evolution(num: '004', name: 'Charmander')]
      },
      6: {
        'prev': [Evolution(num: '005', name: 'Charmeleon')]
      },

      7: {
        'next': [Evolution(num: '008', name: 'Wartortle')]
      },
      8: {
        'next': [Evolution(num: '009', name: 'Blastoise')],
        'prev': [Evolution(num: '007', name: 'Squirtle')]
      },
      9: {
        'prev': [Evolution(num: '008', name: 'Wartortle')]
      },

      10: {
        'next': [Evolution(num: '011', name: 'Metapod')]
      },
      11: {
        'next': [Evolution(num: '012', name: 'Butterfree')],
        'prev': [Evolution(num: '010', name: 'Caterpie')]
      },
      12: {
        'prev': [Evolution(num: '011', name: 'Metapod')]
      },

      13: {
        'next': [Evolution(num: '014', name: 'Kakuna')]
      },
      14: {
        'next': [Evolution(num: '015', name: 'Beedrill')],
        'prev': [Evolution(num: '013', name: 'Weedle')]
      },
      15: {
        'prev': [Evolution(num: '014', name: 'Kakuna')]
      },

      16: {
        'next': [Evolution(num: '017', name: 'Pidgeotto')]
      },
      17: {
        'next': [Evolution(num: '018', name: 'Pidgeot')],
        'prev': [Evolution(num: '016', name: 'Pidgey')]
      },
      18: {
        'prev': [Evolution(num: '017', name: 'Pidgeotto')]
      },

      19: {
        'next': [Evolution(num: '020', name: 'Raticate')]
      },
      20: {
        'prev': [Evolution(num: '019', name: 'Rattata')]
      },

      21: {
        'next': [Evolution(num: '022', name: 'Fearow')]
      },
      22: {
        'prev': [Evolution(num: '021', name: 'Spearow')]
      },

      23: {
        'next': [Evolution(num: '024', name: 'Arbok')]
      },
      24: {
        'prev': [Evolution(num: '023', name: 'Ekans')]
      },

      25: {
        'next': [Evolution(num: '026', name: 'Raichu')]
      },
      26: {
        'prev': [Evolution(num: '025', name: 'Pikachu')]
      },

      27: {
        'next': [Evolution(num: '028', name: 'Sandslash')]
      },
      28: {
        'prev': [Evolution(num: '027', name: 'Sandshrew')]
      },

      29: {
        'next': [Evolution(num: '030', name: 'Nidorina')]
      },
      30: {
        'next': [Evolution(num: '031', name: 'Nidoqueen')],
        'prev': [Evolution(num: '029', name: 'Nidoran♀')]
      },
      31: {
        'prev': [Evolution(num: '030', name: 'Nidorina')]
      },

      32: {
        'next': [Evolution(num: '033', name: 'Nidorino')]
      },
      33: {
        'next': [Evolution(num: '034', name: 'Nidoking')],
        'prev': [Evolution(num: '032', name: 'Nidoran♂')]
      },
      34: {
        'prev': [Evolution(num: '033', name: 'Nidorino')]
      },

      35: {
        'next': [Evolution(num: '036', name: 'Clefable')]
      },
      36: {
        'prev': [Evolution(num: '035', name: 'Clefairy')]
      },

      37: {
        'next': [Evolution(num: '038', name: 'Ninetales')]
      },
      38: {
        'prev': [Evolution(num: '037', name: 'Vulpix')]
      },

      39: {
        'next': [Evolution(num: '040', name: 'Wigglytuff')]
      },
      40: {
        'prev': [Evolution(num: '039', name: 'Jigglypuff')]
      },

      41: {
        'next': [Evolution(num: '042', name: 'Golbat')]
      },
      42: {
        'prev': [Evolution(num: '041', name: 'Zubat')]
      },

      43: {
        'next': [Evolution(num: '044', name: 'Gloom')]
      },
      44: {
        'next': [Evolution(num: '045', name: 'Vileplume')],
        'prev': [Evolution(num: '043', name: 'Oddish')]
      },
      45: {
        'prev': [Evolution(num: '044', name: 'Gloom')]
      },

      46: {
        'next': [Evolution(num: '047', name: 'Parasect')]
      },
      47: {
        'prev': [Evolution(num: '046', name: 'Paras')]
      },

      48: {
        'next': [Evolution(num: '049', name: 'Venomoth')]
      },
      49: {
        'prev': [Evolution(num: '048', name: 'Venonat')]
      },

      50: {
        'next': [Evolution(num: '051', name: 'Dugtrio')]
      },
      51: {
        'prev': [Evolution(num: '050', name: 'Diglett')]
      },

      52: {
        'next': [Evolution(num: '053', name: 'Persian')]
      },
      53: {
        'prev': [Evolution(num: '052', name: 'Meowth')]
      },

      54: {
        'next': [Evolution(num: '055', name: 'Golduck')]
      },
      55: {
        'prev': [Evolution(num: '054', name: 'Psyduck')]
      },

      56: {
        'next': [Evolution(num: '057', name: 'Primeape')]
      },
      57: {
        'prev': [Evolution(num: '056', name: 'Mankey')]
      },

      58: {
        'next': [Evolution(num: '059', name: 'Arcanine')]
      },
      59: {
        'prev': [Evolution(num: '058', name: 'Growlithe')]
      },

      60: {
        'next': [Evolution(num: '061', name: 'Poliwhirl')]
      },
      61: {
        'next': [Evolution(num: '062', name: 'Poliwrath')],
        'prev': [Evolution(num: '060', name: 'Poliwag')]
      },
      62: {
        'prev': [Evolution(num: '061', name: 'Poliwhirl')]
      },

      63: {
        'next': [Evolution(num: '064', name: 'Kadabra')]
      },
      64: {
        'next': [Evolution(num: '065', name: 'Alakazam')],
        'prev': [Evolution(num: '063', name: 'Abra')]
      },
      65: {
        'prev': [Evolution(num: '064', name: 'Kadabra')]
      },

      66: {
        'next': [Evolution(num: '067', name: 'Machoke')]
      },
      67: {
        'next': [Evolution(num: '068', name: 'Machamp')],
        'prev': [Evolution(num: '066', name: 'Machop')]
      },
      68: {
        'prev': [Evolution(num: '067', name: 'Machoke')]
      },

      69: {
        'next': [Evolution(num: '070', name: 'Weepinbell')]
      },
      70: {
        'next': [Evolution(num: '071', name: 'Victreebel')],
        'prev': [Evolution(num: '069', name: 'Bellsprout')]
      },
      71: {
        'prev': [Evolution(num: '070', name: 'Weepinbell')]
      },

      72: {
        'next': [Evolution(num: '073', name: 'Tentacruel')]
      },
      73: {
        'prev': [Evolution(num: '072', name: 'Tentacool')]
      },

      74: {
        'next': [Evolution(num: '075', name: 'Graveler')]
      },
      75: {
        'next': [Evolution(num: '076', name: 'Golem')],
        'prev': [Evolution(num: '074', name: 'Geodude')]
      },
      76: {
        'prev': [Evolution(num: '075', name: 'Graveler')]
      },

      77: {
        'next': [Evolution(num: '078', name: 'Rapidash')]
      },
      78: {
        'prev': [Evolution(num: '077', name: 'Ponyta')]
      },

      79: {
        'next': [Evolution(num: '080', name: 'Slowbro')]
      },
      80: {
        'prev': [Evolution(num: '079', name: 'Slowpoke')]
      },

      81: {
        'next': [Evolution(num: '082', name: 'Magneton')]
      },
      82: {
        'prev': [Evolution(num: '081', name: 'Magnemite')]
      },

      84: {
        'next': [Evolution(num: '085', name: 'Dodrio')]
      },
      85: {
        'prev': [Evolution(num: '084', name: 'Doduo')]
      },

      86: {
        'next': [Evolution(num: '087', name: 'Dewgong')]
      },
      87: {
        'prev': [Evolution(num: '086', name: 'Seel')]
      },

      88: {
        'next': [Evolution(num: '089', name: 'Muk')]
      },
      89: {
        'prev': [Evolution(num: '088', name: 'Grimer')]
      },

      90: {
        'next': [Evolution(num: '091', name: 'Cloyster')]
      },
      91: {
        'prev': [Evolution(num: '090', name: 'Shellder')]
      },

      92: {
        'next': [Evolution(num: '093', name: 'Haunter')]
      },
      93: {
        'next': [Evolution(num: '094', name: 'Gengar')],
        'prev': [Evolution(num: '092', name: 'Gastly')]
      },
      94: {
        'prev': [Evolution(num: '093', name: 'Haunter')]
      },

      95: {
        'next': [Evolution(num: '208', name: 'Steelix')]
      },

      96: {
        'next': [Evolution(num: '097', name: 'Hypno')]
      },
      97: {
        'prev': [Evolution(num: '096', name: 'Drowzee')]
      },

      98: {
        'next': [Evolution(num: '099', name: 'Kingler')]
      },
      99: {
        'prev': [Evolution(num: '098', name: 'Krabby')]
      },

      100: {
        'next': [Evolution(num: '101', name: 'Electrode')]
      },
      101: {
        'prev': [Evolution(num: '100', name: 'Voltorb')]
      },

      102: {
        'next': [Evolution(num: '103', name: 'Exeggutor')]
      },
      103: {
        'prev': [Evolution(num: '102', name: 'Exeggcute')]
      },

      104: {
        'next': [Evolution(num: '105', name: 'Marowak')]
      },
      105: {
        'prev': [Evolution(num: '104', name: 'Cubone')]
      },

      108: {
        'next': [Evolution(num: '463', name: 'Lickilicky')]
      },

      109: {
        'next': [Evolution(num: '110', name: 'Weezing')]
      },
      110: {
        'prev': [Evolution(num: '109', name: 'Koffing')]
      },

      111: {
        'next': [Evolution(num: '112', name: 'Rhydon')]
      },
      112: {
        'next': [Evolution(num: '464', name: 'Rhyperior')],
        'prev': [Evolution(num: '111', name: 'Rhyhorn')]
      },

      114: {
        'next': [Evolution(num: '465', name: 'Tangrowth')]
      },

      116: {
        'next': [Evolution(num: '117', name: 'Seadra')]
      },
      117: {
        'next': [Evolution(num: '230', name: 'Kingdra')],
        'prev': [Evolution(num: '116', name: 'Horsea')]
      },

      118: {
        'next': [Evolution(num: '119', name: 'Seaking')]
      },
      119: {
        'prev': [Evolution(num: '118', name: 'Goldeen')]
      },

      120: {
        'next': [Evolution(num: '121', name: 'Starmie')]
      },
      121: {
        'prev': [Evolution(num: '120', name: 'Staryu')]
      },

      123: {
        'next': [Evolution(num: '212', name: 'Scizor')]
      },

      125: {
        'next': [Evolution(num: '466', name: 'Electivire')]
      },

      126: {
        'next': [Evolution(num: '467', name: 'Magmortar')]
      },

      129: {
        'next': [Evolution(num: '130', name: 'Gyarados')]
      },
      130: {
        'prev': [Evolution(num: '129', name: 'Magikarp')]
      },

      133: {
        'next': [
          Evolution(num: '134', name: 'Vaporeon'),
          Evolution(num: '135', name: 'Jolteon'),
          Evolution(num: '136', name: 'Flareon'),
        ]
      },
      134: {
        'prev': [Evolution(num: '133', name: 'Eevee')]
      },
      135: {
        'prev': [Evolution(num: '133', name: 'Eevee')]
      },
      136: {
        'prev': [Evolution(num: '133', name: 'Eevee')]
      },

      137: {
        'next': [Evolution(num: '233', name: 'Porygon2')]
      },

      138: {
        'next': [Evolution(num: '139', name: 'Omastar')]
      },
      139: {
        'prev': [Evolution(num: '138', name: 'Omanyte')]
      },

      140: {
        'next': [Evolution(num: '141', name: 'Kabutops')]
      },
      141: {
        'prev': [Evolution(num: '140', name: 'Kabuto')]
      },

      147: {
        'next': [Evolution(num: '148', name: 'Dragonair')]
      },
      148: {
        'next': [Evolution(num: '149', name: 'Dragonite')],
        'prev': [Evolution(num: '147', name: 'Dratini')]
      },
      149: {
        'prev': [Evolution(num: '148', name: 'Dragonair')]
      },

      // Gen 2 - Johto (152-251)
      152: {
        'next': [Evolution(num: '153', name: 'Bayleef')]
      },
      153: {
        'next': [Evolution(num: '154', name: 'Meganium')],
        'prev': [Evolution(num: '152', name: 'Chikorita')]
      },
      154: {
        'prev': [Evolution(num: '153', name: 'Bayleef')]
      },

      155: {
        'next': [Evolution(num: '156', name: 'Quilava')]
      },
      156: {
        'next': [Evolution(num: '157', name: 'Typhlosion')],
        'prev': [Evolution(num: '155', name: 'Cyndaquil')]
      },
      157: {
        'prev': [Evolution(num: '156', name: 'Quilava')]
      },

      158: {
        'next': [Evolution(num: '159', name: 'Croconaw')]
      },
      159: {
        'next': [Evolution(num: '160', name: 'Feraligatr')],
        'prev': [Evolution(num: '158', name: 'Totodile')]
      },
      160: {
        'prev': [Evolution(num: '159', name: 'Croconaw')]
      },

      161: {
        'next': [Evolution(num: '162', name: 'Furret')]
      },
      162: {
        'prev': [Evolution(num: '161', name: 'Sentret')]
      },

      163: {
        'next': [Evolution(num: '164', name: 'Noctowl')]
      },
      164: {
        'prev': [Evolution(num: '163', name: 'Hoothoot')]
      },

      165: {
        'next': [Evolution(num: '166', name: 'Ledian')]
      },
      166: {
        'prev': [Evolution(num: '165', name: 'Ledyba')]
      },

      167: {
        'next': [Evolution(num: '168', name: 'Ariados')]
      },
      168: {
        'prev': [Evolution(num: '167', name: 'Spinarak')]
      },

      172: {
        'next': [Evolution(num: '025', name: 'Pikachu')]
      },

      173: {
        'next': [Evolution(num: '035', name: 'Clefairy')]
      },

      174: {
        'next': [Evolution(num: '039', name: 'Jigglypuff')]
      },

      175: {
        'next': [Evolution(num: '176', name: 'Togetic')]
      },
      176: {
        'next': [Evolution(num: '468', name: 'Togekiss')],
        'prev': [Evolution(num: '175', name: 'Togepi')]
      },

      179: {
        'next': [Evolution(num: '180', name: 'Flaaffy')]
      },
      180: {
        'next': [Evolution(num: '181', name: 'Ampharos')],
        'prev': [Evolution(num: '179', name: 'Mareep')]
      },
      181: {
        'prev': [Evolution(num: '180', name: 'Flaaffy')]
      },

      187: {
        'next': [Evolution(num: '188', name: 'Skiploom')]
      },
      188: {
        'next': [Evolution(num: '189', name: 'Jumpluff')],
        'prev': [Evolution(num: '187', name: 'Hoppip')]
      },
      189: {
        'prev': [Evolution(num: '188', name: 'Skiploom')]
      },

      196: {
        'prev': [Evolution(num: '133', name: 'Eevee')]
      },
      197: {
        'prev': [Evolution(num: '133', name: 'Eevee')]
      },

      // Gen 3 - Hoenn (252-386)
      252: {
        'next': [Evolution(num: '253', name: 'Grovyle')]
      },
      253: {
        'next': [Evolution(num: '254', name: 'Sceptile')],
        'prev': [Evolution(num: '252', name: 'Treecko')]
      },
      254: {
        'prev': [Evolution(num: '253', name: 'Grovyle')]
      },

      255: {
        'next': [Evolution(num: '256', name: 'Combusken')]
      },
      256: {
        'next': [Evolution(num: '257', name: 'Blaziken')],
        'prev': [Evolution(num: '255', name: 'Torchic')]
      },
      257: {
        'prev': [Evolution(num: '256', name: 'Combusken')]
      },

      258: {
        'next': [Evolution(num: '259', name: 'Marshtomp')]
      },
      259: {
        'next': [Evolution(num: '260', name: 'Swampert')],
        'prev': [Evolution(num: '258', name: 'Mudkip')]
      },
      260: {
        'prev': [Evolution(num: '259', name: 'Marshtomp')]
      },

      280: {
        'next': [Evolution(num: '281', name: 'Kirlia')]
      },
      281: {
        'next': [
          Evolution(num: '282', name: 'Gardevoir'),
          Evolution(num: '475', name: 'Gallade'),
        ],
        'prev': [Evolution(num: '280', name: 'Ralts')]
      },
      282: {
        'prev': [Evolution(num: '281', name: 'Kirlia')]
      },

      304: {
        'next': [Evolution(num: '305', name: 'Lairon')]
      },
      305: {
        'next': [Evolution(num: '306', name: 'Aggron')],
        'prev': [Evolution(num: '304', name: 'Aron')]
      },
      306: {
        'prev': [Evolution(num: '305', name: 'Lairon')]
      },

      // Gen 4 - Sinnoh (387-493)
      387: {
        'next': [Evolution(num: '388', name: 'Grotle')]
      },
      388: {
        'next': [Evolution(num: '389', name: 'Torterra')],
        'prev': [Evolution(num: '387', name: 'Turtwig')]
      },
      389: {
        'prev': [Evolution(num: '388', name: 'Grotle')]
      },

      390: {
        'next': [Evolution(num: '391', name: 'Monferno')]
      },
      391: {
        'next': [Evolution(num: '392', name: 'Infernape')],
        'prev': [Evolution(num: '390', name: 'Chimchar')]
      },
      392: {
        'prev': [Evolution(num: '391', name: 'Monferno')]
      },

      393: {
        'next': [Evolution(num: '394', name: 'Prinplup')]
      },
      394: {
        'next': [Evolution(num: '395', name: 'Empoleon')],
        'prev': [Evolution(num: '393', name: 'Piplup')]
      },
      395: {
        'prev': [Evolution(num: '394', name: 'Prinplup')]
      },

      470: {
        'prev': [Evolution(num: '133', name: 'Eevee')]
      },
      471: {
        'prev': [Evolution(num: '133', name: 'Eevee')]
      },

      // Gen 5 - Unova (494-649)
      495: {
        'next': [Evolution(num: '496', name: 'Servine')]
      },
      496: {
        'next': [Evolution(num: '497', name: 'Serperior')],
        'prev': [Evolution(num: '495', name: 'Snivy')]
      },
      497: {
        'prev': [Evolution(num: '496', name: 'Servine')]
      },

      498: {
        'next': [Evolution(num: '499', name: 'Pignite')]
      },
      499: {
        'next': [Evolution(num: '500', name: 'Emboar')],
        'prev': [Evolution(num: '498', name: 'Tepig')]
      },
      500: {
        'prev': [Evolution(num: '499', name: 'Pignite')]
      },

      501: {
        'next': [Evolution(num: '502', name: 'Dewott')]
      },
      502: {
        'next': [Evolution(num: '503', name: 'Samurott')],
        'prev': [Evolution(num: '501', name: 'Oshawott')]
      },
      503: {
        'prev': [Evolution(num: '502', name: 'Dewott')]
      },

      // Gen 6 - Kalos (650-721)
      650: {
        'next': [Evolution(num: '651', name: 'Quilladin')]
      },
      651: {
        'next': [Evolution(num: '652', name: 'Chesnaught')],
        'prev': [Evolution(num: '650', name: 'Chespin')]
      },
      652: {
        'prev': [Evolution(num: '651', name: 'Quilladin')]
      },

      653: {
        'next': [Evolution(num: '654', name: 'Braixen')]
      },
      654: {
        'next': [Evolution(num: '655', name: 'Delphox')],
        'prev': [Evolution(num: '653', name: 'Fennekin')]
      },
      655: {
        'prev': [Evolution(num: '654', name: 'Braixen')]
      },

      656: {
        'next': [Evolution(num: '657', name: 'Frogadier')]
      },
      657: {
        'next': [Evolution(num: '658', name: 'Greninja')],
        'prev': [Evolution(num: '656', name: 'Froakie')]
      },
      658: {
        'prev': [Evolution(num: '657', name: 'Frogadier')]
      },

      700: {
        'prev': [Evolution(num: '133', name: 'Eevee')]
      },

      // Gen 7 - Alola (722-809)
      722: {
        'next': [Evolution(num: '723', name: 'Dartrix')]
      },
      723: {
        'next': [Evolution(num: '724', name: 'Decidueye')],
        'prev': [Evolution(num: '722', name: 'Rowlet')]
      },
      724: {
        'prev': [Evolution(num: '723', name: 'Dartrix')]
      },

      725: {
        'next': [Evolution(num: '726', name: 'Torracat')]
      },
      726: {
        'next': [Evolution(num: '727', name: 'Incineroar')],
        'prev': [Evolution(num: '725', name: 'Litten')]
      },
      727: {
        'prev': [Evolution(num: '726', name: 'Torracat')]
      },

      728: {
        'next': [Evolution(num: '729', name: 'Brionne')]
      },
      729: {
        'next': [Evolution(num: '730', name: 'Primarina')],
        'prev': [Evolution(num: '728', name: 'Popplio')]
      },
      730: {
        'prev': [Evolution(num: '729', name: 'Brionne')]
      },

      // Gen 8 - Galar (810-905)
      810: {
        'next': [Evolution(num: '811', name: 'Thwackey')]
      },
      811: {
        'next': [Evolution(num: '812', name: 'Rillaboom')],
        'prev': [Evolution(num: '810', name: 'Grookey')]
      },
      812: {
        'prev': [Evolution(num: '811', name: 'Thwackey')]
      },

      813: {
        'next': [Evolution(num: '814', name: 'Raboot')]
      },
      814: {
        'next': [Evolution(num: '815', name: 'Cinderace')],
        'prev': [Evolution(num: '813', name: 'Scorbunny')]
      },
      815: {
        'prev': [Evolution(num: '814', name: 'Raboot')]
      },

      816: {
        'next': [Evolution(num: '817', name: 'Drizzile')]
      },
      817: {
        'next': [Evolution(num: '818', name: 'Inteleon')],
        'prev': [Evolution(num: '816', name: 'Sobble')]
      },
      818: {
        'prev': [Evolution(num: '817', name: 'Drizzile')]
      },

      // Gen 9 - Paldea (906-1025)
      906: {
        'next': [Evolution(num: '907', name: 'Floragato')]
      },
      907: {
        'next': [Evolution(num: '908', name: 'Meowscarada')],
        'prev': [Evolution(num: '906', name: 'Sprigatito')]
      },
      908: {
        'prev': [Evolution(num: '907', name: 'Floragato')]
      },

      909: {
        'next': [Evolution(num: '910', name: 'Crocalor')]
      },
      910: {
        'next': [Evolution(num: '911', name: 'Skeledirge')],
        'prev': [Evolution(num: '909', name: 'Fuecoco')]
      },
      911: {
        'prev': [Evolution(num: '910', name: 'Crocalor')]
      },

      912: {
        'next': [Evolution(num: '913', name: 'Quaxwell')]
      },
      913: {
        'next': [Evolution(num: '914', name: 'Quaquaval')],
        'prev': [Evolution(num: '912', name: 'Quaxly')]
      },
      914: {
        'prev': [Evolution(num: '913', name: 'Quaxwell')]
      },
    };

    final evolution = evolutionMap[id];
    if (evolution != null) {
      nextEvolution = evolution['next'];
      prevEvolution = evolution['prev'];
    }

    return {
      'next': nextEvolution,
      'prev': prevEvolution,
    };
  }

  // Get weaknesses based on types (simplified type chart)
  List<String> _getWeaknesses(List<String> types) {
    Set<String> weaknesses = {};

    for (var type in types) {
      switch (type.toLowerCase()) {
        case 'normal':
          weaknesses.addAll(['Fighting']);
          break;
        case 'fire':
          weaknesses.addAll(['Water', 'Ground', 'Rock']);
          break;
        case 'water':
          weaknesses.addAll(['Electric', 'Grass']);
          break;
        case 'electric':
          weaknesses.addAll(['Ground']);
          break;
        case 'grass':
          weaknesses.addAll(['Fire', 'Ice', 'Poison', 'Flying', 'Bug']);
          break;
        case 'ice':
          weaknesses.addAll(['Fire', 'Fighting', 'Rock', 'Steel']);
          break;
        case 'fighting':
          weaknesses.addAll(['Flying', 'Psychic', 'Fairy']);
          break;
        case 'poison':
          weaknesses.addAll(['Ground', 'Psychic']);
          break;
        case 'ground':
          weaknesses.addAll(['Water', 'Grass', 'Ice']);
          break;
        case 'flying':
          weaknesses.addAll(['Electric', 'Ice', 'Rock']);
          break;
        case 'psychic':
          weaknesses.addAll(['Bug', 'Ghost', 'Dark']);
          break;
        case 'bug':
          weaknesses.addAll(['Fire', 'Flying', 'Rock']);
          break;
        case 'rock':
          weaknesses.addAll(['Water', 'Grass', 'Fighting', 'Ground', 'Steel']);
          break;
        case 'ghost':
          weaknesses.addAll(['Ghost', 'Dark']);
          break;
        case 'dragon':
          weaknesses.addAll(['Ice', 'Dragon', 'Fairy']);
          break;
        case 'dark':
          weaknesses.addAll(['Fighting', 'Bug', 'Fairy']);
          break;
        case 'steel':
          weaknesses.addAll(['Fire', 'Fighting', 'Ground']);
          break;
        case 'fairy':
          weaknesses.addAll(['Poison', 'Steel']);
          break;
      }
    }

    return weaknesses.toList();
  }
}

extension StringExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${this.substring(1)}';
  }
}
