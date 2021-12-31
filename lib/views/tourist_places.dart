import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:smart_city_flutter/views/tags_screen.dart';
import 'package:url_launcher/url_launcher.dart';

const GET_PLACE = """
query TouristPlace(\$id: String) {
  touristPlace(id: \$id) {
    id
    tourismName
    phone
    email
    website
    city
    state
    country
    continent
    currency
    language
    timezone
    image
    tourismDescription
    rating
    price
    open
    close
    lat
    lng
    tourismType
    tourismSubType
    tourismTags
    reviewsCount
    photos
    photosCount
  }
}
""";

class TouristPlaces extends StatefulWidget {
  final String name;
  final String category;
  final String id;
  final String image;
  const TouristPlaces({ Key? key, required this.name,required this.id, required this.category, required this.image }) : super(key: key);

  @override
  _TouristPlacesState createState() => _TouristPlacesState();
}

void _launchURL(_url) async =>
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

class _TouristPlacesState extends State<TouristPlaces> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              snap: false,
              floating: false,
              expandedHeight: 180.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(widget.name),
                background: Image.network(
                  widget.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Query(
                options: QueryOptions(
                  document: gql(GET_PLACE),
                  variables: {
                    'id': widget.id,
                  },
                ),
                builder: (QueryResult result, {VoidCallback? refetch, FetchMore? fetchMore}) {
                  if (result.hasException) {
                    return Text(result.exception.toString());
                  }
                  if (result.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final places = result.data['touristPlace'];
                  return Container(
                    padding: const EdgeInsets.all(8.0),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Wrap(
                          alignment: WrapAlignment.start,
                          children: [
                            for(var place in places['tourismTags']) Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ActionChip(
                                label: Text("$place"), 
                                elevation: 3,
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                                backgroundColor: const Color(0xFFB5838D),
                                shadowColor: Colors.black38,
                                onPressed: () { 
                                  Navigator.push( context, MaterialPageRoute(builder: (context) => TagsScreen(tags: place, category: 'TouristPlaces')));
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
                                Text("Info", style: const TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.w600)),
                                const SizedBox(height: 8.0),
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    const Icon(Icons.location_on_rounded, color: Color(0xFFB5838D)),
                                    const SizedBox(width: 10.0),
                                    Text("${places['city']}, ${places['state']}, ${places['country']}", style: const TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w500)),
                                  ],
                                ),
                                const SizedBox(height: 10.0),
                                places['website'] != null ? GestureDetector(
                                  onTap: () {
                                    _launchURL(places['website']);
                                  },
                                  child: Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: [
                                      const Icon(Icons.web, color: Color(0xFFB5838D)),
                                      const SizedBox(width: 10.0),
                                      Text(places['website'], style: const TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ) : Container(),
                                const SizedBox(height: 10.0),
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    const Icon(Icons.phone, color: Color(0xFFB5838D)),
                                    const SizedBox(width: 10.0),
                                    Text(places['phone'], style: const TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w500)),
                                  ],
                                ),
                                const SizedBox(height: 10.0),
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    const Icon(Icons.email, color: Color(0xFFB5838D)),
                                    const SizedBox(width: 10.0),
                                    Text(places['email'], style: const TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              ],
                            ),
                          ),
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
                                Text("About", style: const TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.w600)),
                                SizedBox(height: 5.0),
                                for (var desc in places['tourismDescription'])
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 8.0),
                                    child: Text(desc, style: const TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w500))
                                  ),
                              ],
                            ),
                          )
                        ),
                        Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 12.0,
                          shadowColor: Colors.black38,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                places['tourismType'] != null ? Text(places['tourismType'], style: const TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w500)): Container(),
                                const SizedBox(height: 10.0),
                                places['tourismSubTypeType'] != null ? Text(places['tourismSubType'], style: const TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w500)): Container(),
                                const SizedBox(height: 10.0),
                                places['rating'] != null ? Text("Rating: ${places['rating'].toString()}", style: const TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w500)): Container(),
                              ],
                            ),
                          )
                        ),
                        Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 12.0,
                          shadowColor: Colors.black38,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(16.0),
                            child: places['photos'] != null && places['photos'] != [] && places['photos'] != '' ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Photos", style: const TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.w600)),
                                SizedBox(height: 5.0),
                                for (var photo in places['photos'])
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 8.0),
                                    child: Image.network(
                                      photo,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                              ],
                            ) : Container(
                              child: Text("No photos available", style: const TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w500)),
                            ),
                          )
                        ),
                      ],
                    ),
                  );
                }
              ),
            )
          ],
        )
      ),
    );
  }
}