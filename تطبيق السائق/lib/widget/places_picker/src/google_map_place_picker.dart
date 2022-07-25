import 'package:alnaqel_driver/model/orderlistdata.dart';
import 'package:alnaqel_driver/widget/order_card.dart';
import 'package:alnaqel_driver/widget/places_picker/providers/home_provider.dart';
import 'package:alnaqel_driver/widget/storage_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../providers/place_provider.dart';
import 'components/animated_pin.dart';
import 'place_picker.dart';

class GoogleMapPlacePicker extends StatefulWidget {
  const GoogleMapPlacePicker({
    Key? key,
    required this.initialTarget,
    required this.onMoveStart,
    required this.onMapCreated,
    required this.orders,
    required this.storage,
    required this.enableMyLocationButton,
  }) : super(key: key);

  final LatLng initialTarget;
  final List<OrderData> orders;
  
  final List<OrderData> storage;
  final VoidCallback onMoveStart;
  final MapCreatedCallback onMapCreated;
  // final VoidCallback onMyLocation;
  final bool enableMyLocationButton;

  @override
  _GoogleMapPlacePickerState createState() => _GoogleMapPlacePickerState();
}

class _GoogleMapPlacePickerState extends State<GoogleMapPlacePicker> {
  bool showPickBtn = true;
  bool isCardShowing = false;
  bool canChoose = false;
  late PlaceProvider provider;
  @override
  void initState() {
    super.initState();
    provider = PlaceProvider.of(context, listen: false);

    provider.addListener(() {
      setState(() {
        showPickBtn = provider.pinState != PinState.dragging;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    provider.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
              labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              tabs: [
                  Tab(
                  text: 'الى المخزن',
                ),
                Tab(
                  text: 'الى العملاء',
                ),
              
              ]),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                _buildGoogleMap(context),
                _buildPin(),
                TabBarView(children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CarouselSlider.builder(
                      itemCount: widget.orders.length + 1,
                      carouselController: CarouselController(),
                      options: CarouselOptions(
                        height: 250,
                        enableInfiniteScroll: false,
                        reverse: true,
                        autoPlayCurve: Curves.easeInOut,
                        onPageChanged: (index, reason) async {
                          if (index == 0) return;
                          final GoogleMapController controller =
                              provider.mapController;
                          final item = widget.orders[index - 1];
                          controller.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                zoom: 15,
                                target: LatLng(
                                  double.parse(
                                      item.userAddress?.lat?.toString() ?? '0'),
                                  double.parse(
                                    item.userAddress?.lang?.toString() ?? '0',
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      itemBuilder: (context, index, pageViewIndex) {
                        if (index == 0) {
                          return Card(
                            child: GestureDetector(
                                onTap: () {
                                  Provider.of<HomeProvider>(context,
                                          listen: false)
                                      .callApiForGetOrderList();
                                },
                                child: const Center(
                                    child: Text(
                                        'اسحب لليمين لاختيار الطلبات او اضغط هنا لتحديث القائمة'))),
                          );
                        }

                        return OrderCard(
                          index: index - 1,
                          orderdatalist: widget.orders,
                        );
                      },
                    ),
                  ),
                  //Storage
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CarouselSlider.builder(
                      itemCount: widget.storage.length + 1,
                      carouselController: CarouselController(),
                      options: CarouselOptions(
                        height: 250,
                        enableInfiniteScroll: false,
                        reverse: true,
                        autoPlayCurve: Curves.easeInOut,
                        onPageChanged: (index, reason) async {
                          if (index == 0) return;
                          final GoogleMapController controller =
                              provider.mapController;
                          final item = widget.storage[index - 1];
                          controller.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                zoom: 15,
                                target: LatLng(
                                  double.parse(
                                      item.userAddress?.lat?.toString() ?? '0'),
                                  double.parse(
                                    item.userAddress?.lang?.toString() ?? '0',
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      itemBuilder: (context, index, pageViewIndex) {
                        if (index == 0) {
                          return Card(
                            child: GestureDetector(
                                onTap: () {
                                  Provider.of<HomeProvider>(context,
                                          listen: false)
                                      .callApiForGetOrderList();
                                },
                                child: const Center(
                                    child: Text(
                                        'اسحب لليمين لاختيار الطلبات او اضغط هنا لتحديث القائمة'))),
                          );
                        }

                        return StorageCard(
                          index: index - 1,
                          orderdatalist: widget.storage,
                        );
                      },
                    ),
                  ),
                ])
                

                // if (isCardShowing)
                //   Parent(
                //       gesture: Gestures()
                //         ..onTap(() {
                //           // weSlideController..hide();
                //         }),
                //       style: ParentStyle()
                //         ..background.blur(5)
                //         ..borderRadius(all: 0))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    // final PlaceProvider provider = PlaceProvider.of(context, listen: false);

    final CameraPosition initialCameraPosition =
        CameraPosition(target: widget.initialTarget, zoom: 15);

    return GoogleMap(
      initialCameraPosition: initialCameraPosition,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      markers: widget.orders
          .map(
            (e) => Marker(
              markerId: MarkerId(
                e.id.toString(),
              ),
              position: LatLng(
                double.parse(e.userAddress?.lat?.toString() ?? '0'),
                double.parse(e.userAddress?.lang?.toString() ?? '0'),
              ),
            ),
          )
          .toSet(),
      onTap: (value) {},
      onMapCreated: (GoogleMapController controller) {
        provider.mapController = controller;
        provider.pinState = PinState.idle;
      },
      onCameraIdle: () {
        provider.pinState = PinState.idle;
      },
      onCameraMoveStarted: () {
        if (provider.cameraPosition != null) {
          provider.setPrevCameraPosition(provider.cameraPosition!);
        }

        provider.pinState = PinState.dragging;
      },
      onCameraMove: (CameraPosition position) {
        provider.setCameraPosition(position);

        provider.currentPosition = Position.fromMap({
          'latitude': position.target.latitude,
          'longitude': position.target.longitude,
        });

        /* 24.733721, 46.706886 */
      },
    );
  }

  Widget _buildPin() {
    return Center(
      child: Selector<PlaceProvider, PinState>(
        selector: (_, provider) => provider.pinState,
        builder: (context, state, __) => _defaultPinBuilder(context, state),
      ),
    );
  }

  Widget _defaultPinBuilder(BuildContext context, PinState state) {
    if (state == PinState.preparing) {
      return Container();
    } else if (state == PinState.idle) {
      return Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(
                  CupertinoIcons.map_pin_ellipse,
                  size: 36,
                  color: Colors.black,
                ),
                SizedBox(height: 42),
              ],
            ),
          ),
          // Center(
          //   child: Container(
          //     width: 5,
          //     height: 5,
          //     decoration: const BoxDecoration(
          //       color: Colors.blue,
          //       shape: BoxShape.circle,
          //     ),
          //   ),
          // ),
        ],
      );
    } else {
      return Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                AnimatedPin(
                  child: Icon(
                    CupertinoIcons.map_pin,
                    size: 36,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 42),
              ],
            ),
          ),
          // Center(
          //   child: Container(
          //     width: 5,
          //     height: 5,
          //     decoration: const BoxDecoration(
          //       color: Colors.blue,
          //       shape: BoxShape.circle,
          //     ),
          //   ),
          // ),
        ],
      );
    }
  }
}
