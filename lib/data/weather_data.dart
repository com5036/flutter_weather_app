class WeatherData {
  WeatherData(this.jsonData);
  dynamic jsonData;
  List<String>? date = [];
  List<String>? time = [];
  List<String>? lightning = [];
  List<String>? rainType = [];
  List<String>? rain = [];
  List<String>? sky = [];
  List<String>? temp = [];
  List<String>? humidity = [];
  List<String>? ewWind = [];
  List<String>? nsWind = [];
  List<String>? windDir = [];
  List<String>? windSpeed = [];

  void parseData() {
    /*
    * 0~5 낙뢰
    * 6~11 강수형태: 없음(0), 비(1), 비/눈(2), 눈(3), 빗방울(5), 빗방울눈날림(6), 눈날림(7)
    * 12~17 강수량: mm
    * 18~23 하늘상태: 맑음(1), 구름많음(3), 흐림(4)
    * 24~29 온도
    * 30~35 습도
    * 36~41 동서 바람 : 동(+), 서(-)
    * 42~47 남북 바람 : 북(+), 남(-)
    * 48~53 풍향
    * 54~59 풍속
    */

    for (int i = 0; i < 6; i++) {
      date?.add(jsonData['response']['body']['items']['item'][i]['fcstDate']);
      time?.add(jsonData['response']['body']['items']['item'][i]['fcstTime']);
      lightning
          ?.add(jsonData['response']['body']['items']['item'][i]['fcstValue']);
    }

    for (int i = 6; i < 12; i++) {
      rainType
          ?.add(jsonData['response']['body']['items']['item'][i]['fcstValue']);
    }

    for (int i = 12; i < 18; i++) {
      rain?.add(jsonData['response']['body']['items']['item'][i]['fcstValue']);
    }

    for (int i = 18; i < 24; i++) {
      int skyVal = int.parse(
          jsonData['response']['body']['items']['item'][i]['fcstValue']);

      switch (skyVal) {
        case 1: // 맑음
          sky?.add('assets/svg/Sun.svg');
          break;
        case 3: // 구름 많음
          if (rain?[(i % 6)] != '강수없음') {
            sky?.add('assets/svg/Cloud-Rain-Sun.svg');
          } else {
            sky?.add('assets/svg/Cloud-Sun.svg');
          }
          break;
        case 4: // 흐림
          if (rain?[(i % 6)] != '강수없음') {
            sky?.add('assets/svg/Cloud-Rain.svg');
          } else {
            sky?.add('assets/svg/Cloud.svg');
          }
          break;
        default:
          break;
      }
    }
    for (int i = 24; i < 30; i++) {
      temp?.add(jsonData['response']['body']['items']['item'][i]['fcstValue']);
    }

    for (int i = 30; i < 36; i++) {
      humidity
          ?.add(jsonData['response']['body']['items']['item'][i]['fcstValue']);
    }

    for (int i = 36; i < 42; i++) {
      ewWind
          ?.add(jsonData['response']['body']['items']['item'][i]['fcstValue']);
    }

    for (int i = 42; i < 48; i++) {
      nsWind
          ?.add(jsonData['response']['body']['items']['item'][i]['fcstValue']);
    }

    for (int i = 48; i < 54; i++) {
      windDir
          ?.add(jsonData['response']['body']['items']['item'][i]['fcstValue']);
    }

    for (int i = 54; i < 60; i++) {
      windSpeed
          ?.add(jsonData['response']['body']['items']['item'][i]['fcstValue']);
    }
  }
}
