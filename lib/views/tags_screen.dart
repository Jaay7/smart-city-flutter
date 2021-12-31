import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const restaurantTags = """
query Query(\$tags: [String]) {
  getRestaurantsByTags(tags: \$tags) {
    id
    name
    website
    rating
    image
  }
}
""";

const restaurantMenuTags = """
query Query(\$tags: [String]) {
  getMenuTags(tags: \$tags) {
    id
    itemName
    itemImage
    itemPrice
    itemCategory
    itemRestaurantId
  }
}
""";

const touristPlaceTags = """
query Query(\$tags: [String]) {
  getTouristPlacesByTags(tags: \$tags) {
    id
    tourismName
    city
    state
    country
    image
    rating
  }
}
""";

class TagsScreen extends StatefulWidget {
  final String tags;
  final String category;
  const TagsScreen({ Key? key, required this.tags, required this.category }) : super(key: key);

  @override
  _TagsScreenState createState() => _TagsScreenState();
}

class _TagsScreenState extends State<TagsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 150,
              pinned: true,
              floating: false,
              snap: false,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(widget.tags),
              ),
            ),
            Query(
              options: QueryOptions(
                document: widget.category == 'Restaurants' ? gql(restaurantTags) : widget.category == 'RestaurantMenu' ? gql(restaurantMenuTags) : gql(touristPlaceTags),
                variables: {
                  'tags': [widget.tags],
                },
              ),
              builder: (QueryResult result, {VoidCallback? refetch, FetchMore? fetchMore}) {
                if (result.hasException) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Text('Error: ${result.exception.toString()}'),
                    ),
                  );
                }
                if (result.loading) {
                  return const SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                final data = result.data;
                if (data == null) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Text('No data'),
                    ),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final response = widget.category == 'Restaurants' ? data['getRestaurantsByTags'][index] : widget.category == 'RestaurantMenu' ? data['getMenuTags'][index] : data['getTouristPlacesByTags'][index];
                      return ListTile(
                        title: widget.category == 'Restaurants' ? Text(response['name']) : widget.category == 'RestaurantMenu' ? Text(response['itemName']) : Text(response['tourismName']),
                        subtitle: widget.category == 'Restaurants' ? Text(response['website']) : widget.category == 'RestaurantMenu' ? Text(response['itemPrice']) : Text(response['city'] + ', ' + response['state'] + ', ' + response['country']),
                        leading: widget.category == 'Restaurants' ? Image.network(response['image']) : widget.category == 'RestaurantMenu' ? Image.network(response['itemImage']) : Image.network(response['image']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, color: Colors.yellow[700], size: 20),
                            SizedBox(width: 5),
                            widget.category == 'Restaurants' ? Text(response['rating'].toString()) : widget.category == 'RestaurantMenu' ? Text(response['itemCategory']) : Text(response['rating'].toString())
                          ],
                        ),
                      );
                    },
                    childCount: widget.category == 'Restaurants' ? data['getRestaurantsByTags'].length : widget.category == 'RestaurantMenu' ? data['getMenuTags'].length : data['getTouristPlacesByTags'].length,
                  ),
                );
              },
            )
          ],
        ),
      )
    );
  }
}