import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungfood/model/order_model.dart';
import 'package:ungfood/model/user_model.dart';
import 'package:ungfood/utility/my_api.dart';
import 'package:ungfood/utility/my_constant.dart';
import 'package:ungfood/utility/my_style.dart';

class P_coming extends StatefulWidget {
  final UserModel userModel;
  P_coming({Key key, this.userModel}) : super(key: key);

  @override
  _P_comingState createState() => _P_comingState();
}

class _P_comingState extends State<P_coming> {
  String idShop;
  List<OrderModel> orderModels = List();
  List<List<String>> listNameFoods = List();
  UserModel userModel;
  double lat1, lng1, lat2, lng2, distance;
  String distanceString;
  int transport;
  CameraPosition position;

  @override
  void initState() {
    super.initState();
    userModel = widget.userModel;
    findIdShopAndReadOrder();
    findLat1Lng1();
  }

  Future<Null> findIdShopAndReadOrder() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    idShop = preferences.getString(MyConstant().keyId);
    print('idShop = $idShop');

    String path =
        '${MyConstant().domain}/UngFood/getOrderWhereIdShop.php?isAdd=true&idShop=$idShop';
    await Dio().get(path).then((value) {
      print('value ==>> $value');
      var result = json.decode(value.data);
      // print('result ==>> $result');
      for (var item in result) {
        OrderModel model = OrderModel.fromJson(item);
        // print('orderDateTime = ${model.orderDateTime}');

        List<String> nameFoods = MyAPI().createStringArray(model.nameType);
       


        setState(() {
          orderModels.add(model);
          listNameFoods.add(nameFoods);
          
        });
      }
    });
  }

  Future<Null> findLat1Lng1() async {
    LocationData locationData = await findLocationData();
    setState(() {
      lat1 = locationData.latitude;
      lng1 = locationData.longitude;
      lat2 = double.parse(userModel.lat);
      lng2 = double.parse(userModel.lng);
      print('lat1 = $lng1, lng1 = $lng1, lat2 = $lat2, lng2 = $lng2');
      distance = MyAPI().calculateDistance(lat1, lng1, lat2, lng2);

      var myFormat = NumberFormat('#0.0#', 'en_US');
      distanceString = myFormat.format(distance);

      transport = MyAPI().calculateTransport(distance);

      print('distance = $distance');
      print('transport = $transport');
    });
  }

  Future<LocationData> findLocationData() async {
    Location location = Location();
    try {
      return await location.getLocation();
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(16.0),
                width: 150.0,
                height: 150.0,
              ),
            ],
          ),

          showMap(),
        ],
      ),
    );
  }

  Container showMap() {
    if (lat1 != null) {
      LatLng latLng1 = LatLng(lat1, lng2);
      position = CameraPosition(
        target: latLng1,
        zoom: 10.0,
      );
    }

    Marker userMarker() {
      return Marker(
        markerId: MarkerId('userMarker'),
        position: LatLng(lat1, lng1),
        icon: BitmapDescriptor.defaultMarkerWithHue(60.0),
        infoWindow: InfoWindow(title: 'คุณอยู่ที่นี่'),
      );
    }

    Marker shopMarker() {
      return Marker(
        markerId: MarkerId('shopMarker'),
        position: LatLng(lat2, lng2),
        icon: BitmapDescriptor.defaultMarkerWithHue(150.0),
        infoWindow: InfoWindow(title: userModel.nameShop),
      );
    }

    Set<Marker> mySet() {
      return <Marker>[userMarker(), shopMarker()].toSet();
    }

    return Container(
            child: GoogleMap(
              initialCameraPosition: position,
              mapType: MapType.normal,
              onMapCreated: (controller) {},
              markers: mySet(),
            ),
    );
  }
}

// margin: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 32),
//       // color: Colors.grey,
//       height: 200,
//       child: lat1 == null
//           ? MyStyle().showProgress()
//           : GoogleMap(
//               initialCameraPosition: position,
//               mapType: MapType.normal,
//               onMapCreated: (controller) {},
//               markers: mySet(),
//             ),
