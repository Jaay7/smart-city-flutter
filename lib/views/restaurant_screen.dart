import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smart_city_flutter/views/tags_screen.dart';
import 'package:url_launcher/url_launcher.dart';

const GET_RESTAURANT = """
query Restaurant(\$restaurantId: String) {
  restaurant(id: \$restaurantId) {
    id
    name
    address
    phone
    email
    website
    image
    description
    rating
    price
    open
    close
    lat
    lng
    type
    cuisine
    tags
    reviewsCount
    photos
    photosCount
    menuCount
  }
}
""";

const GET_MENU = """
query GetMenu(\$id: String) {
  getMenu(id: \$id) {
    id
    itemName
    itemDescription
    itemPrice
    itemImage
    itemCategory
    itemTags
    itemRestaurantId
  }
}
""";

class RestaurantScreen extends StatefulWidget {
  final String name;
  final String category;
  final String id;
  const RestaurantScreen({ Key? key, required this.name,required this.id, required this.category }) : super(key: key);

  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

void _launchURL(_url) async =>
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

class _RestaurantScreenState extends State<RestaurantScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Query(
          options: QueryOptions(
            document: gql(GET_RESTAURANT),
            pollInterval: const Duration(milliseconds: 500),
            variables: {
              'restaurantId': widget.id,
            },
          ),
          builder: (QueryResult result, {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }
            if (result.isLoading) {
              return const Center(heightFactor: 13.0, child: CircularProgressIndicator());
            }
            final restaurant = result.data?['restaurant'];
            return Row(
              children: <Widget>[
                NavigationRail(
                  minWidth: 60.0,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    }, icon: Icon(Icons.arrow_back_rounded, color: Colors.black87)),
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  unselectedIconTheme: const IconThemeData(color: Color(0xFFB5838D)),
                  unselectedLabelTextStyle: const TextStyle(color: Color(0xFFB5838D)),
                  labelType: NavigationRailLabelType.selected,
                  destinations: const <NavigationRailDestination>[
                    NavigationRailDestination(
                      icon: Icon(Icons.info_outline_rounded),
                      selectedIcon: Icon(Icons.info_rounded),
                      label: Text('Info'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.restaurant_menu_rounded),
                      selectedIcon: Icon(Icons.restaurant_menu_rounded),
                      label: Text('Menu'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.star_border),
                      selectedIcon: Icon(Icons.star),
                      label: Text('Review'),
                    ),
                  ],
                ),
                // const VerticalDivider(thickness: 1, width: 1),
                // This is the main content.
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.white,
                    child: _selectedIndex == 0 ? SingleChildScrollView(
                      child: Column(
                        children: [
                          // Image.network(restaurant['image'], fit: BoxFit.cover, height: 300),
                          Container(
                            height: 200,
                            // width: MediaQuery.of(context).size.width,
                            alignment: Alignment.bottomLeft,
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(restaurant['image']),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Text(
                              restaurant['name'], 
                              style: const TextStyle(
                                fontSize: 24, 
                                fontWeight: FontWeight.w600, 
                                color: Colors.white, 
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 6.0,
                                    color: Color(0xFF333333),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  children: [
                                    for(var res in restaurant['tags']) Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: ActionChip(
                                        label: Text("$res"), 
                                        elevation: 3,
                                        labelStyle: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        backgroundColor: const Color(0xFFB5838D),
                                        shadowColor: Colors.black38,
                                        onPressed: () { 
                                          Navigator.push( context, MaterialPageRoute(builder: (context) => TagsScreen(tags: res, category: 'Restaurants')));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Card(
                                  clipBehavior: Clip.antiAlias,
                                  elevation: 12.0,
                                  shadowColor: Colors.black38,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Wrap(
                                          crossAxisAlignment: WrapCrossAlignment.center,
                                          children: [
                                            const Icon(Icons.location_on_rounded, color: Color(0xFFB5838D)),
                                            const SizedBox(width: 10.0),
                                            Text(restaurant['address'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                                          ],
                                        ),
                                        const SizedBox(height: 10.0),
                                        GestureDetector(
                                          onTap: () {
                                            _launchURL(restaurant['website']);
                                          },
                                          child: Wrap(
                                            crossAxisAlignment: WrapCrossAlignment.center,
                                            children: [
                                              const Icon(Icons.web, color: Color(0xFFB5838D)),
                                              const SizedBox(width: 10.0),
                                              Text(restaurant['website'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10.0),
                                        Wrap(
                                          crossAxisAlignment: WrapCrossAlignment.center,
                                          children: [
                                            const Icon(Icons.phone, color: Color(0xFFB5838D)),
                                            const SizedBox(width: 10.0),
                                            Text(restaurant['phone'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                                          ],
                                        ),
                                        const SizedBox(height: 10.0),
                                        Wrap(
                                          crossAxisAlignment: WrapCrossAlignment.center,
                                          children: [
                                            const Icon(Icons.email, color: Color(0xFFB5838D)),
                                            const SizedBox(width: 10.0),
                                            Text(restaurant['email'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Card(
                                  clipBehavior: Clip.antiAlias,
                                  elevation: 12.0,
                                  shadowColor: Colors.black38,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Wrap(
                                          crossAxisAlignment: WrapCrossAlignment.center,
                                          children: [
                                            const Icon(Icons.star_half_rounded, color: Color(0xFFB5838D)),
                                            const SizedBox(width: 10.0),
                                            Text(restaurant['rating'].toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                                          ],
                                        ),
                                        const SizedBox(height: 10.0),
                                        Wrap(
                                          crossAxisAlignment: WrapCrossAlignment.center,
                                          children: [
                                            const Icon(Icons.star_border, color: Color(0xFFB5838D)),
                                            const SizedBox(width: 10.0),
                                            Text(
                                              restaurant['reviewsCount'] == null ? "No reviews" : restaurant['reviewsCount'].toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                                          ],
                                        ),
                                        const SizedBox(height: 10.0),
                                        Wrap(
                                          crossAxisAlignment: WrapCrossAlignment.center,
                                          children: [
                                           const Icon(Icons.money, color: Color(0xFFB5838D)),
                                            const SizedBox(width: 10.0),
                                            Text(restaurant['price'].toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Card(
                                  clipBehavior: Clip.antiAlias,
                                  elevation: 12.0,
                                  shadowColor: Colors.black38,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Wrap(
                                          crossAxisAlignment: WrapCrossAlignment.center,
                                          children: [
                                            const Icon(Icons.access_time, color: Color(0xFFB5838D)),
                                            const SizedBox(width: 10.0),
                                            Text(restaurant['open'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                                          ],
                                        ),
                                        const SizedBox(height: 10.0),
                                        Wrap(
                                          crossAxisAlignment: WrapCrossAlignment.center,
                                          children: [
                                            const Icon(Icons.time_to_leave, color: Color(0xFFB5838D)),
                                            const SizedBox(width: 10.0),
                                            Text(restaurant['close'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                                          ],
                                        ),
                                        const SizedBox(height: 10.0),
                                        restaurant['cuisine'] == null ? SizedBox() : Wrap(
                                          crossAxisAlignment: WrapCrossAlignment.center,
                                          children: [
                                            const Icon(Icons.restaurant_menu, color: Color(0xFFB5838D)),
                                            const SizedBox(width: 10.0),
                                            Text(restaurant['cuisine'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]
                            ),
                          )
                        ],
                      ),
                    ) : _selectedIndex == 1 ? Query(
                      options: QueryOptions(
                        document: gql(GET_MENU),
                        pollInterval: const Duration(milliseconds: 500),
                        variables: {
                          'id': widget.id,
                        },
                      ),
                      builder: (QueryResult result, {VoidCallback? refetch, FetchMore? fetchMore}) {
                        if (result.hasException) {
                          return Text(result.exception.toString());
                        }
                        if (result.isLoading) {
                          return const Center(heightFactor: 13.0, child: CircularProgressIndicator());
                        }
                        final menu = result.data?['getMenu'];
                        return Column(
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.all(16.0),
                              child: const Text(
                                "Menu",
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: menu.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onLongPress: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          // Using Wrap makes the bottom sheet height the height of the content.
                                          // Otherwise, the height will be half the height of the screen.
                                          return Wrap(
                                            children: [
                                              Container(
                                                height: 200,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(menu[index]['itemImage']),
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                              ),
                                              ListTile(
                                                leading: Icon(Icons.share),
                                                title: Text('Share'),
                                              ),
                                              ListTile(
                                                leading: Icon(Icons.delete),
                                                title: Text('Delete collection'),
                                              ),
                                            ],
                                          );
                                        }
                                      );
                                    },
                                    child: Card(
                                      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                                      clipBehavior: Clip.antiAlias,
                                      elevation: 12.0,
                                      shadowColor: Colors.black38,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 80.0,
                                              height: 80.0,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10.0),
                                                image: DecorationImage(
                                                  image: NetworkImage(menu[index]['itemImage']),
                                                  fit: BoxFit.cover
                                                )
                                              ),
                                            ),
                                            const SizedBox(width: 10.0),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(menu[index]['itemName'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black54)),
                                                const SizedBox(height: 10.0),
                                                Text("\u{20B9}${menu[index]['itemPrice'].toString()}", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }
                    )
                    : Column(
                      children: [
                        Text('selectedIndex: $_selectedIndex'),
                      ]
                    ),
                  ),
                )
              ],
            );
          }
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: const Color(0xFF6D6875),
          foregroundColor: Colors.white,
          onPressed: () {
            // Respond to button press
          },
          icon: const Icon(Icons.favorite_outline),
          label: const Text('Favourite'),
        ),
      ),
    );
  }
}