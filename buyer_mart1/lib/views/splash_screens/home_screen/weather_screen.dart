import 'package:buyer_mart1/consts/consts.dart';
import 'package:buyer_mart1/widgets_common/bgwidget.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
//import 'package:geolocator/geolocator.dart';


class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});
  

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherFactory _wf = WeatherFactory(OPEN_WEATHER_API_KEY);
  Weather? _weather;
  //String? _areaName;
  String location = 'Null, Press Button';
  String address = 'search';
  

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  }

  Future<String> getAddressFromLatLong(Position position) async {
  try {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      //String cityName = place.locality ?? place.subAdministrativeArea ?? place.administrativeArea ?? '';

      String cityName = place.subAdministrativeArea ?? '';//locality ?? '';
      // ignore: avoid_print
      print(cityName);
      return cityName; //cityName
    } else {
      // Handle the case where no placemark is availables
      return "City name not found";
    }
  } catch (e) {
    // Handle any errors that might occur during geocoding
    // ignore: avoid_print
    print("Error getting city name: $e");
    return "Error getting city name";
  }
}
  
  @override
void initState() {
  super.initState();
  _initializeWeather();
}

Future<void> _initializeWeather() async {
  try {
    Position position = await _getGeoLocationPosition();
    String address = await getAddressFromLatLong(position); //
    //print("City name: $address");
    // ignore: unnecessary_string_interpolations
    var weather = await _wf.currentWeatherByCityName('$address'); //'$address'
    setState(() {
      _weather = weather;
    });
  } catch (e) {
    // Handle any errors
    // ignore: avoid_print
    print("Error initializing weather: $e");
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(),
    );
  }
  
  Widget _buildUI() {
    
    if (_weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return bgwidget(
      child:  SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _locationHeader(),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.08,
            ),
            _dateTimeInfo(),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.05,
            ),
            _weatherIcon(),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.02,
            ),
            _currentTemp(),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.02,
            ),
            _extraInfo(),
          ],
        ),
      ),
    );
  }

  
  /*Future<Scaffold> _fetchLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      // You can use the position data to fetch the location name
      // For demonstration, let's just use latitude and longitude
      setState(() {
        _areaName = 'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
      });
    } catch (e) {
      print("Error getting location: $e");
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _areaName ?? 'Fetching location...',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Container(),
    );
  }*/

  Widget _locationHeader() {
    return Text(
      _weather?.areaName ?? "",
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _dateTimeInfo () {
    DateTime now = _weather!.date!;
    return Column(
      children: [
        Text(
          DateFormat("h:mm a").format(now),
          style: const TextStyle(
            fontSize: 35,
          ),
        ),
        const SizedBox(
          height: 70,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE").format(now),
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "  ${DateFormat("d :m :y").format(now)}",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _weatherIcon() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.20,
          width: MediaQuery.sizeOf(context).width * 0.70,
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage("https://openweathermap.org/img/img/wn/${_weather?.weatherIcon}@3x.png"))
            ),
        ),
        Text(
          _weather?.weatherDescription ?? "",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
  Widget _currentTemp() {
    return Text(
      "${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
      style: const TextStyle(
        color: Colors.black,
        fontSize: 90,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _extraInfo() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.15,
      width: MediaQuery.sizeOf(context).width * 0.70,
      decoration: BoxDecoration(color: Colors.lightGreen, borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}° C",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              Text(
                "   Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}° C",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Wind: ${_weather?.windSpeed?.toStringAsFixed(0)} m/s",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              Text(
                "   Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
                )
            ],
          )
        ],
      ),
    );
  }
}