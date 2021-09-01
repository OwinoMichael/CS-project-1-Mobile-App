import 'package:flutter/material.dart';
import 'package:prdip/screens/cl%20user%20screens/Maps/plumberMap.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  static const String idScreen = "search";

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Screen'),
      ),
      body: ListView(
        //itemCount: serviceList.lenght,

        // child:  ListTile(
        //   title: Text("Plumbing"),
        //   subtitle: Text("Motley Crew"),
        //   leading: Image.network(''),
        //   trailing: Icon(Icons.arrow_forward_ios_rounded),
        // ),
        children: <Widget>[
          GestureDetector(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
                  context, MapView.idScreen, (route) => false);
          },
          child: Card(
            child: ListTile(
              title: Text("Plumbing", style: TextStyle(fontFamily: "Brand-Bold", fontWeight: FontWeight.bold, fontSize: 19   )),
              subtitle: Text("Blocked drainage, Water leakeges, Pipe burst,"),
              leading: Image.network(
                  'https://th.bing.com/th/id/R.25a36c7a2cef247f9482fcbdd18686fc?rik=DHKIHQKnayapeA&pid=ImgRaw&r=0', height: 170, width: 80),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
          ),
          ),


          GestureDetector(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, MapView.idScreen, (route) => false);
            },
          child:  Card(
            child: ListTile(
              title: Text("Electrical", style: TextStyle(fontFamily: "Brand-Bold", fontWeight: FontWeight.bold,
                        fontSize: 19)),
              subtitle: Text("Overloaded circuits, Frequent Surges, Sag and Dips"),
              leading: Image.network(
                  'https://th.bing.com/th/id/OIP.C_8ug22KnBFQmWpp9IurqAHaE2?pid=ImgDet&rs=1', height: 170,
                    width: 80),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
          ),
          ),


          GestureDetector(
          onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, MapView.idScreen, (route) => false);
            },
          child: Card(
            child: ListTile(
              title: Text("Appliance", style: TextStyle(fontFamily: "Brand-Bold", fontWeight: FontWeight.bold,
                        fontSize: 19)),
              subtitle: Text("Disfunctional home electrical equipments"),
              leading: Image.network(
                  'https://media.istockphoto.com/photos/professional-young-worker-in-eyeglasses-and-protective-workwear-picture-id912621618?k=6&m=912621618&s=612x612&w=0&h=dHE2tqtAV2yot3_VHVuj5ufGOBwWLDIkvsf71uNjkE4=', height: 170,
                    width: 80),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
          ),
          ),


          GestureDetector(
          onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, MapView.idScreen, (route) => false);
            },
          child: Card(
            child: ListTile(
              title: Text("Paint", style: TextStyle(fontFamily: "Brand-Bold", fontWeight: FontWeight.bold,
                        fontSize: 19)),
              subtitle: Text("Cracking, Flaking, and Clumping"),
              leading: Image.network(
                  'https://th.bing.com/th?id=OIF.ewM92dKjuP8QLFYOVjuz%2fQ&pid=ImgDet&rs=1', height: 170, width: 80, ),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
          ),
          ),


          GestureDetector(
          onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, MapView.idScreen, (route) => false);
            },
          child: Card(
            child: ListTile(
              title: Text("Woodwork", style: TextStyle(fontFamily: "Brand-Bold", fontWeight: FontWeight.bold,
                        fontSize: 19)),
              subtitle: Text("Loose Legs, Broken furniture, Worn out cabinets"),
              leading: Image.network(
                  'https://images.unsplash.com/photo-1611021061218-761c355ed331?ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8Y2FycGVudGVyfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60', height: 170, width: 80,),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
          ),
          ),


          GestureDetector(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, MapView.idScreen, (route) => false);
            },
          child: Card(
            child: ListTile(
              title: Text("Tiling", style: TextStyle(fontFamily: "Brand-Bold", fontWeight: FontWeight.bold,
                        fontSize: 19)),
              subtitle: Text("Loose Tile, Cracked Tile, Improper Adhesive"),
              leading: Image.network(
                  'https://th.bing.com/th/id/R.5a5cf8289844cc9605fbe12c2e1beb8b?rik=3UUg8mMKYuP%2bfQ&riu=http%3a%2f%2fresidencestyle.com%2fwp-content%2fuploads%2f2019%2f01%2fVinyl-Flooring.jpg&ehk=5bBL24UJwnCouSOTDnSsVNIvQLL9ED2eFIHYLr1Ixm8%3d&risl=&pid=ImgRaw&r=0', height: 170, width: 80,),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
          ),
          ),


          GestureDetector(
          onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, MapView.idScreen, (route) => false);
            },
          child: Card(
            child: ListTile(
              title: Text("Glasswork", style: TextStyle(fontFamily: "Brand-Bold", fontWeight: FontWeight.bold,
                        fontSize: 19)),
              subtitle: Text("Damaged Window Screen, Broken or Foggy Glass"),
              leading: Image.network(
                  'https://th.bing.com/th/id/OIP.l7SSRgz1XcltiWpO4XpZmQHaEo?pid=ImgDet&w=1000&h=625&rs=1', height: 170, width: 80,),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
          ),
          ),


          GestureDetector(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, MapView.idScreen, (route) => false);
            },
          child: Card(
            child: ListTile(
              title: Text("Metal", style: TextStyle(fontFamily: "Brand-Bold", fontWeight: FontWeight.bold,
                        fontSize: 19)),
              subtitle: Text("Broken window grills, Pet Cages"),
              leading: Image.network(
                  'https://th.bing.com/th/id/R.e28a0d736d36c209aad413167e866471?rik=0aolEZ17XVOKUQ&pid=ImgRaw&r=0', height: 170, width: 80),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
          ),
          ),
        ],
      ),
    );
  }
}
