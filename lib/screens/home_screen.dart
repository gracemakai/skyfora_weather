import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_location_search/flutter_location_search.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:skyfora_weather/cubit/weather_cubit.dart';
import 'package:skyfora_weather/cubit/weather_state.dart';
import 'package:skyfora_weather/models/weather_model.dart';
import 'package:skyfora_weather/util/converters.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoaded) {
              String city = state.weatherResponse.city.name.isNotEmpty
                  ? state.weatherResponse.city.name
                  : 'Unknown location';
              return Text(city);
            } else if (state is WeatherLoading) {
              return const CircularProgressIndicator();
            }
            return const Text('Unknown location');
          },
        ),
        leading: const Icon(Icons.location_on_outlined),
        actions: [
          InkWell(
            onTap: () async {
              LocationData? locationData = await LocationSearch.show(
                context: context,
                lightAddress: true,
                mode: Mode.overlay,
              );

              if (locationData != null && context.mounted) {
                context.read<WeatherCubit>().fetchWeather(
                    locationData.latitude, locationData.longitude);
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.search),
            ),
          )
        ],
        centerTitle: false,
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(builder: (context, state) {
        if (state is WeatherLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is WeatherLoaded) {
          final WeatherResponse weather = state.weatherResponse;
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
               FutureBuilder<DateTime?>(
              future: context.read<WeatherCubit>().getLastUpdated(),
              builder: (context, snapshot) {
                final lastUpdated = snapshot.data;
                return lastUpdated != null ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('No internet connection', style: TextStyle(fontSize: 14.sp),),
                      Text('Last updated: ${DateFormat('dd MMM, HH:mm').format(lastUpdated)}',
                          style: const TextStyle(color: Colors.black45)),
                  ],
                ): Container();
              },
            ),
                  SizedBox(
                    height: 0.25.sh,
                    width: 1.sw,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          fahrenheitToCelsiusConverter(
                              weather.list.first.main.temp),
                          style: TextStyle(
                              fontSize: 50.sp,
                              color: Colors.white70,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          weather.list.first.weather[0].description,
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.white70,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.air,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 0.01.sw,
                                  ),
                                  Text(
                                    '${weather.list.first.wind.speed} km/h',
                                    style: const TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.water_drop_outlined,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 0.01.sw,
                                  ),
                                  Text(
                                    '${weather.list.first.main.humidity}%',
                                    style: const TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.compress_rounded,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 0.01.sw,
                                  ),
                                  Text(
                                    '${weather.list.first.main.pressure}',
                                    style: const TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 0.01.sh,
                  ),
                  SizedBox(
                    height: 0.17.sh,
                    child: ListView.builder(
                        itemCount: 6,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          WeatherForecast weatherForecast =
                              weather.list.elementAt(index);
                          return SizedBox(
                            width: 0.17.sw,
                            child: Column(
                              children: [
                                Text(
                                  formatDateToTime(weatherForecast.dt),
                                  style: TextStyle(
                                      color: Colors.black26, fontSize: 14.sp),
                                ),
                                WeatherIcon(
                                    icon: weatherForecast.weather.first.icon),
                                Text(
                                  fahrenheitToCelsiusConverter(
                                      weatherForecast.main.temp),
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14.sp),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 0.02.sh,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '5 day forecast',
                        style: TextStyle(color: Colors.black, fontSize: 14.sp),
                      ),
                      SizedBox(
                        height: 0.5.sh,
                        child: ListView.builder(
                            itemCount: 5,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              Map<String, dynamic> forecast = state
                                  .weatherResponse
                                  .getFiveDayForecast()
                                  .elementAt(index);
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 0.25.sw,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            getDayOfWeek(forecast['date']),
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 14.sp),
                                          ),
                                          Text(
                                            formatToDayAndMonth(
                                                forecast['date']),
                                            style: TextStyle(
                                                color: Colors.black26,
                                                fontSize: 14.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      fahrenheitToCelsiusConverter(
                                          forecast['temp']),
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14.sp),
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(
                                      width: 0.29.sw,
                                      child: Text(
                                        forecast['description'],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.sp),
                                      ),
                                    ),
                                    SizedBox(
                                        height: 0.05.sh,
                                        child: WeatherIcon(
                                            icon: forecast['icon'])),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
        return const Center(
          child: Text('There was a problem loading the weather. Please try again later'),
        );
      }),
    );
  }
}

class WeatherIcon extends StatelessWidget {
  const WeatherIcon({
    super.key,
    required this.icon,
  });

  final String icon;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://openweathermap.org/img/wn/$icon@2x.png',
      errorBuilder: (context, error, stackTrace) {
        return SizedBox(
          height: 0.03.sh,
          width: 0.sw,
        );
      },
    );
  }
}
