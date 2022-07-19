# 초단기 날씨 예보 App


## Description
초단기 날씨 예보 어플리케이션을 학습 목적으로 제작하였다.  
현재 시간으로부터 6시간 동안의 정확도 높은 날씨 예보를 보여준다.

## Environment
Flutter 3.0.3  
Android API 33, iOS

## Files
* lib/main.dart               어플리케이션을 실행한다.  
* lib/screens/loading.dart    위치와 날씨 데이터를 로딩하는 화면  
* lib/screens/weather.dart    날씨를 보여주는 화면  
* lib/data/my_location.dart   현재 위치 관련 클래스  
* lib/data/network.dart       http 통신 관련 클래스  