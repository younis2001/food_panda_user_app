import 'package:url_launcher/url_launcher.dart';

class MapsUtils
{
  MapsUtils._();
  static Future<void> openMapWithPosition(double latitude ,double longitude)
  async {
    String googleMapUrl = "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
if(await canLaunchUrl(Uri.parse(googleMapUrl)))
  {
    await launchUrl(Uri.parse(googleMapUrl),mode: LaunchMode.externalApplication);
  }
else
  {
    throw 'could not open the map.';
  }
  }

  static Future<void> openMapWithAddress(String fullAddress)async
  {
    String query =Uri.encodeComponent(fullAddress);
    String googleMapUrl = "https://www.google.com/maps/search/?api=1&query=$query";
    if(await canLaunch(googleMapUrl))
    {
      await launch(googleMapUrl);
    }
    else
    {
      throw 'could not open the map.';
    }
  }
}