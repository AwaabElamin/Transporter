import 'package:alnaqel_seller/config/Palette.dart';
import 'package:alnaqel_seller/constant/app_strings.dart';
import 'package:alnaqel_seller/localization/localization_constant.dart';
import 'package:alnaqel_seller/models/address.dart';
import 'package:alnaqel_seller/models/cart_item.dart';
import 'package:alnaqel_seller/retrofit/base_model.dart';
import 'package:alnaqel_seller/utilities/device_utils.dart';
import 'package:alnaqel_seller/widgets/send_order/pages/select_payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class SelectAddressPage extends StatefulWidget {
  static final String path = 'select_address';
  const SelectAddressPage({Key? key}) : super(key: key);

  @override
  State<SelectAddressPage> createState() => _SelectAddressPageState();
}

class _SelectAddressPageState extends State<SelectAddressPage>
    with TickerProviderStateMixin {
  Future<BaseModel<Address>>? addressFuture;
  GoogleMapController? mapController;

  late Position currentLocation;

  _getLocation() async {
    currentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    var newPosition = CameraPosition(
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 16);

    CameraUpdate update = CameraUpdate.newCameraPosition(newPosition);
    if (mapController != null) {
      mapController!.moveCamera(update);
    }
  }

  @override
  void initState() {
    super.initState();
    addressFuture = getAddress(
        Provider.of<OrderingCart>(context, listen: false).getUser()!.id!);
    _getLocation();
  }

  Future<void> _refreshProduct() async {
    setState(() {
      addressFuture = getAddress(
          Provider.of<OrderingCart>(context, listen: false).getUser()!.id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        var previousRoutesInfoList;
        return <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text(
              getTranslated(context, SelectAddressPage.path) ?? 'hi',
              style: TextStyle(fontFamily: proxima_nova_bold),
            ),
            automaticallyImplyTitle: true,
            previousPageTitle: getTranslated(context,
                    previousRoutesInfoList?.last?.settings.name ?? '') ??
                '',
            trailing:
                Provider.of<OrderingCart>(context, listen: true).getAddress() !=
                        null
                    ? TextButton.icon(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.cyan,
                        ),
                        label: Text(
                          getTranslated(context, 'next')!,
                          style: TextStyle(
                            fontFamily: proxima_nova_bold,
                            color: Colors.cyan,
                          ),
                        ),
                        onPressed: () async {

                        Navigator.of(context).pushNamed(SelectPayment.path);
                       
                        },
                      )
                    : null,
          )
        ];
      },
      body: FutureBuilder<BaseModel<Address>?>(
          future: addressFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return DeviceUtils.showProgress(true);
            } else {
              Widget emptyView = Center(
                child: Container(
                    child: Text(getTranslated(context, 'no_data_desc') ?? '')),
              );
              Address? data = snapshot.data?.data;

              bool isNulled = data?.data == null;
              if (isNulled) {
                return emptyView;
              } else {
                return Column(
                  children: [
                    Expanded(
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(0.0, 0.0),
                          zoom: 12.0,
                        ),
                        onMapCreated: (controller) {
                          setState(() {
                            mapController = controller;
                          });
                        },
                        liteModeEnabled: true,
                        markers: (data?.data ?? [])
                            .map((e) => Marker(
                                  markerId: MarkerId(e.id.toString()),
                                  position: LatLng(e.lat!, e.lang!),
                                  infoWindow: InfoWindow(
                                    title: e.address,
                                  ),
                                ))
                            .toSet(),
                      ),
                    ),
                    TextButton.icon(
                        onPressed: () async {
                          Data d = Data(
                              userId: Provider.of<OrderingCart>(context,
                                      listen: false)
                                  .getUser()
                                  ?.id);
                          LocationResult? result = await showLocationPicker(
                            context,
                            googleApiKey,
                            countries: ['sd'],
                          );

                          if (result != null) {
                            d.setLat = result.latLng!.latitude;
                            d.setLang = result.latLng!.longitude;
                            d.setAddress =
                                result.formattedAddress ?? result.locality!;

                            try {
                              await createAddress(
                                  UserId: d.userId!,
                                  lat: d.lat!,
                                  lang: d.lang!,
                                  address: d.address!);
                            } catch (e) {}

                            _refreshProduct();
                            // Navigator.pop(context);
                          }

                          // showDialog(
                          //   context: context,
                          //   builder: (context) => Padding(
                          //     padding: const EdgeInsets.all(18.0).copyWith(
                          //         bottom:
                          //             MediaQuery.of(context).viewInsets.bottom +
                          //                 18),
                          //     child: ClipRRect(
                          //       borderRadius: BorderRadius.circular(9),
                          //       child: PlacePicker(
                          //         initialPosition: LatLng(0, 0),
                          //         onSave: (latlng) {
                          //           d.setLang = latlng.longitude;
                          //           d.setLat = latlng.latitude;
                          //         },
                          //         builder: (isMoving) {
                          //           return Padding(
                          //             padding: const EdgeInsets.all(22.0),
                          //             child: Align(
                          //                 alignment: Alignment.bottomCenter,
                          //                 child: Card(
                          //                     child: Padding(
                          //                   padding: const EdgeInsets.all(8.0),
                          //                   child: Column(
                          //                     mainAxisSize: MainAxisSize.min,
                          //                     children: [
                          //                       CupertinoTextField(
                          //                         onChanged: (value) {
                          //                           d.setAddress = value;
                          //                         },
                          //                         placeholder:
                          //                             'اكتب اسم العنوان مثل : البيت او المكتب',
                          //                       ),
                          //                       Row(
                          //                         children: [
                          //                           CupertinoButton(
                          //                               child: Text('اغلاق'),
                          //                               onPressed: () =>
                          //                                   Navigator.pop(
                          //                                       context)),
                          //                           CupertinoButton(
                          //                             child: Text('اضافة'),
                          //                             onPressed: () async {
                          //                               if (d.address == null ||
                          //                                   d.address!
                          //                                       .isEmpty ||
                          //                                   d.address!.length <
                          //                                       3) {
                          //                                 DeviceUtils
                          //                                     .toastMessage(
                          //                                         'العنون قصير للغاية');
                          //                               } else {
                          //                                 try {
                          //                                   await createAddress(
                          //                                       UserId:
                          //                                           d.userId!,
                          //                                       lat: d.lat!,
                          //                                       lang: d.lang!,
                          //                                       address:
                          //                                           d.address!);
                          //                                 } catch (e) {}

                          //                                 _refreshProduct();
                          //                                 Navigator.pop(
                          //                                     context);
                          //                               }
                          //                             },
                          //                           ),
                          //                         ],
                          //                       )
                          //                     ],
                          //                   ),
                          //                 ))),
                          //           );
                          //         },
                          //       ),
                          //     ),
                          //   ),
                          // );
                        },
                        icon: Icon(Icons.add_location_alt_rounded),
                        label: Text(
                            getTranslated(context, 'add_client_address') ??
                                '')),
                    Expanded(
                      child: RefreshIndicator(
                        color: Palette.green,
                        onRefresh: _refreshProduct,
                        child: ListView.builder(
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(data?.data?[index].address ?? ''),
                                trailing: context
                                            .watch<OrderingCart>()
                                            .getAddress()
                                            ?.id ==
                                        data?.data?[index].id
                                    ? Icon(
                                        Icons.radio_button_checked,
                                        color: Palette.green,
                                      )
                                    : Icon(
                                        Icons.radio_button_unchecked,
                                        color: Colors.grey,
                                      ),
                                onTap: () {
                                  context
                                      .read<OrderingCart>()
                                      .setAddress(data?.data?[index]);
                                  LatLng newlatlang = LatLng(
                                      data?.data?[index].lat ?? 0,
                                      data?.data?[index].lang ?? 0);
                                  mapController?.animateCamera(
                                      CameraUpdate.newCameraPosition(
                                          CameraPosition(
                                              target: newlatlang, zoom: 17)
                                          //17 is new zoom level
                                          ));
                                },
                              );
                            },
                            itemCount: data!.data!.length),
                      ),
                    ),
                  ],
                );
              }
            }
          }),
    ));
  }
}
