import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:prdip/model/orderData.dart';

class  OrderScreen extends StatefulWidget {
  static const String idScreen = "oderrr";
  const  OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {


final cloder = FirebaseDatabase(
          databaseURL:
              "https://prdip-2932d-default-rtdb.europe-west1.firebasedatabase.app/")
      .reference()
      .child("order-details");

void getOrderData(){
  cloder.once().then((DataSnapshot snap) async {
    var data = snap.value;
    odi.clear();
    data.forEach((key, value){

    OrderData sb32 = new OrderData(
      clientToken: value['client_token'],
      service: value['service'],
      handyName: value['handyman_name'],
      loco: value['repair_location'],
      timeCreated: value['created_at']
    );
    setState(() {
      odi.add(sb32);
      print(key);
    });  
    });

  });
} 

void initState(){
  super.initState();
  getOrderData();
}

List<OrderData> odi = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: odi.length == 0 ?  new Center(
        child: new CircularProgressIndicator(),
      ) : showMyUI() ,
      
    );
  }

 Widget showMyUI()   {
   return new ListView.builder(
     itemCount: odi.length,
     itemBuilder: (_, index){
       return new Container(
         margin: new EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0 ),
         child: new Card(
           elevation: 10.0,
           child: new Container(
             padding: new EdgeInsets.all(12.0),
             child: new Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                 new Padding(padding: new EdgeInsets.symmetric(vertical: 3.0)),
                 new Text('Service : ${odi[index].service}'),
                 new Padding(padding: new EdgeInsets.symmetric(vertical: 3.0)),
                 new Text('Handyman Name : ${odi[index].handyName}'),
                 new Padding(padding: new EdgeInsets.symmetric(vertical: 3.0)),
                 new Text('Repair Location: ${odi[index].loco}'),
                 new Padding(padding: new EdgeInsets.symmetric(vertical: 3.0)),
                 new Text('Time: ${odi[index].timeCreated}'),
                 new Padding(padding: new EdgeInsets.symmetric(vertical: 3.0)),

               ],
             ),
           ),
         ),
       );
     }
   );
  }
}
