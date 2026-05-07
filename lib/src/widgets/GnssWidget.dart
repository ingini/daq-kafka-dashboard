
import 'package:daq_dashboard/src/Controllers/GnssController.dart';
import 'package:daq_dashboard/src/meta/Defines.dart';
import 'package:daq_dashboard/src/meta/IProperty.dart';
import 'package:daq_dashboard/src/Models/GnssModel.dart';
import 'package:daq_dashboard/src/themes/theme.dart';
import 'package:daq_dashboard/src/widgets/TaggingWidget.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:daq_dashboard/src/ProcessingState/eProcessingState.dart';

class GnssWidget extends TaggingStatefulWidget {


  GnssWidget( eTags taggingTag ) : super( taggingTag:taggingTag);

  @override
  TaggingWidgetState<GnssWidget>  createState() => _GnssWidgetState(taggingMetaProperty);

}

class _GnssWidgetState extends TaggingWidgetState<GnssWidget> {
  _GnssWidgetState(metaProperty taggingMetaProperty) : super(taggingMetaProperty);

  final MapController mapController = MapController();

  LatLng currentPosition = LatLng(37.5665, 126.9780); // 서울 시청의 좌표로 초기값 설정

  bool isInit=false;

  void updatePosition(LatLng newPosition) {
    if(isInit==false) return;



    mapController.move(newPosition, 18.0);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {

      print("After Init");
      isInit = true;

    });
    // 스트림이 null이 아니면 사용, 아니면 현재 위치 사용
    // positionStream = widget.positionStream ?? Stream.value(currentPosition);
  }

  @override
  Widget build(BuildContext context) {

    final UIColors uiColors = Theme.of(context).extension<UIColors>()!;

    return GetBuilder<GnssController>(
        tag: tag,
      builder: (GnssController controller) {

        GnssModel? model = controller.PopModel() as GnssModel;
        if(model == null) {
          print("model Null");
        }
        //
        // print( "Gnss : " + model!.stateStack.toString() );
        //
        //
        // print("Gnss : ControlActive : " + model.IsStateSuccess(eProcessingState.ControlActive).toString());
        // print("Gnss : NetworkConnected : " + model.IsStateSuccess(eProcessingState.NetworkConnected).toString());
        // print("Gnss : SensorConnected : " + model.IsStateSuccess(eProcessingState.SensorConnected).toString());
        // print("Gnss : SensorHealthy : " + model.IsStateSuccess(eProcessingState.SensorHealthy).toString());
        // print("Gnss : Acquiring : " + model.IsStateSuccess(eProcessingState.Acquiring).toString());
        // print("Gnss : Snap : " + model.IsStateSuccess(eProcessingState.Snap).toString());
        //


        currentPosition = LatLng(model.latitude ?? 37.5665, model.longitude ?? 126.9780);
        updatePosition(currentPosition);


        return GestureDetector(
          onTap:() async {
            // 여기에 클릭 시 실행할 controller의 함수 호출
            controller.OnTapWidget(); // 여기서 yourFunction을 controller의 실제 함수로 변경
          },
          // onDoubleTap: () {
          //   // 더블 클릭 이벤트를 처리하거나 무시합니다.
          //   // print("Double tap detected, but doing nothing.");
          // },
          child: AbsorbPointer(
            absorbing: true,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    // decoration: BoxDecoration(
                    //   color: Colors.blueGrey[900], // 배경색 설정
                    //   border: Border.all(color: Colors.green, width: 2), // 녹색 테두리 추가
                    //   borderRadius: BorderRadius.circular(4), // 모서리를 둥글게 처리
                    // ),
                    child: Stack(
                      children: [


                        Container(
                          child: FlutterMap(
                            mapController: mapController,
                            options: MapOptions(
                              initialCenter: currentPosition,
                              initialZoom: 18.0,
                              // center: currentPosition,
                              // zoom: 18.0,
                            ),
                            children: [
                              TileLayer(
                                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                              ),
                              MarkerLayer(
                                markers: [
                                  Marker(
                                    width: 80.0,
                                    height: 80.0,
                                    point: currentPosition,
                                    child: Container(
                                      child: Icon(Icons.location_on, size: 40, color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        Positioned(
                          top: 5,
                          left: 10,
                          child: Container(
                              child: UIComponents.sensorConnectionStateIcon( model!.connection_state )
                          ),
                        ),

                        Positioned(
                          top: 5,
                          left: 50,
                          child: Container(
                              child: UIComponents.gnssSolnsvsIcon( model!.solnsvs_count )
                          ),
                        ),

                        Positioned(
                          top: 5,
                          left: 91,
                          child: Container(
                              child: UIComponents.gnssSolnsvsText( model!.solnsvs_count )
                          ),
                        ),

                        Positioned(
                          top: 5,
                          right: 10,
                          child: Container(
                              child: UIComponents.sensorAcquiringIcon( model!.acquisition_state )
                          ),
                        ),


                        Positioned(
                          bottom: 5,
                          right: 10,
                          child: Container(
                              child: UIComponents.gnssSolnsvsLatLonText( model?.latitude, model?.longitude)
                          ),
                        ),

                      ],
                    ),
                  ),
                ),




              ],
            ),
          ),
        );




      }
    );
  }


}