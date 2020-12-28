import 'package:clime/WeatherBloc.dart';
import 'package:clime/WeatherModel.dart';
import 'package:clime/WeatherRepo.dart';
import 'package:clime/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(icon: Icon(Icons.cloud), onPressed: () {}),
            title: Text("Clime"),
            actions: <Widget>[
       /*       IconButton(
                 icon: Icon(Icons.settings),
                  onPressed: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => Settings()));
                  }),*/
            ],
          ),
          body: BlocProvider(
            builder: (context) => WeatherBloc(WeatherRepo()),
            child: SearchPage(),
          ),
          bottomNavigationBar : BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: [
                new BottomNavigationBarItem(icon: new Icon(Icons.cloud), title: new Text("Rainy")),
                new BottomNavigationBarItem(icon: new Icon(Icons.location_on), title: new Text("Location")),
                new BottomNavigationBarItem(icon: new Icon(Icons.wb_sunny), title: new Text("Sunny")),
                new BottomNavigationBarItem(icon: new Icon(Icons.notifications), title: new Text("Notify"))
              ]),

        ));
  }
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    var cityController = TextEditingController();
    return Container(
      //   height: double.infinity,
      //   width: 100.0,
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://i.pinimg.com/originals/29/cb/d5/29cbd5c73bac071fb7ade09bcac4feb8.gif"),
              fit: BoxFit.cover)),
      child: Column(children: <Widget>[
        BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherIsNotSearched)
              return Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      child: Container(
                        margin: EdgeInsets.all(20),
                        child: TextFormField(
                          controller: cityController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 0.0),
                            ),
                            labelText: 'Search Location Here',
                            suffixIcon: Icon(Icons.search),
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 50,
                      child: FlatButton(
                        shape: new RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        onPressed: () {
                          weatherBloc.add(FetchWeather(cityController.text));
                        },
                        color: Colors.lightBlue,
                        child: Text(
                          "Search",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(height: 270,),
                    Container(
                     // padding: EdgeInsets.only(bottom: 50.0),
                      child: Text(
                        "To Check The Weather using location above",
                        style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 20,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            else if (state is WeatherIsLoading)
              return Center(child: CircularProgressIndicator());
            else if (state is WeatherIsLoaded) {
              return ShowWeather(state.getWeather,cityController.text);
            } else
              return Text(
                "Error",
                style: TextStyle(color: Colors.white),
              );
          },
        )
      ],
      ),);
  }
}


class ShowWeather extends StatelessWidget {
  WeatherModel weather;
  final city;

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();  //"6:00 AM"
    return format.format(dt);
  }

  ShowWeather(this.weather, this.city);

  @override
  Widget build(BuildContext context) {
   return  Column(
       mainAxisAlignment:MainAxisAlignment.center,
       crossAxisAlignment:CrossAxisAlignment.center,
       children: <Widget>[
   Padding(
   padding: const EdgeInsets.all(8.0),
    child : Text(
                  city,
                  style: TextStyle(
                      color:Colors.white
                      ,fontSize:28.0,
                      fontWeight:FontWeight.w600
                  ),
                ),
   ),
         SizedBox(height: 12,),
         Padding(
                   padding:EdgeInsets.only(top:0.0),
               child :    Text(
                weather.getTemp.toStringAsFixed(1)+"\u00B0",
                style: TextStyle(
                    color:Colors.white
                    ,fontSize:24.0,
                    fontWeight:FontWeight.w600
                ),
              ),
         ),
              SizedBox(height: 12,), Padding(
                padding:EdgeInsets.only(top:10.0),
                child:Text(

    new DateFormat.jm().format(new DateTime.now()),
    style: TextStyle(
                      color:Colors.white
                      ,fontSize:24.0,
                      fontWeight:FontWeight.w600
                  ),
                ),
              ),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Container(
             child: ListTile(
               leading: FaIcon(FontAwesomeIcons.thermometerHalf,color: Colors.white,),
               title: Text('Minimum',textScaleFactor: 1.5,style: TextStyle(color: Colors.white)),
               subtitle: Text('Temperature',style: TextStyle(color: Colors.white)),
               trailing: Text(weather.getMinTemp.toStringAsFixed(1)+"\u00B0",style: TextStyle(color: Colors.white)),
             ),

           ),

         ),

         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Container(
             child: ListTile(
               leading: FaIcon(FontAwesomeIcons.thermometerFull,color: Colors.white,),
               title: Text('Maximum',textScaleFactor: 1.5,style: TextStyle(color: Colors.white)),
               subtitle: Text('Temperature',style: TextStyle(color: Colors.white)),
               trailing: Text(weather.getMaxTemp.toStringAsFixed(1)+"\u00B0",style: TextStyle(color: Colors.white)),
             ),

           ),

         ),

         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Container(
             child: ListTile(
               leading: FaIcon(FontAwesomeIcons.tachometerAlt,color: Colors.white,),
               title: Text('Pressure',textScaleFactor: 1.5,style: TextStyle(color: Colors.white)),
               subtitle: Text('Temperature',style: TextStyle(color: Colors.white)),
               trailing: Text(weather.getPressure.toStringAsFixed(1)+"\u00B0",style: TextStyle(color: Colors.white)),
             ),

           ),

         ),

         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Container(
             child: ListTile(
               leading: FaIcon(FontAwesomeIcons.thermometerThreeQuarters,color: Colors.white,),
               title: Text('Humidity',textScaleFactor: 1.5,style: TextStyle(color: Colors.white)),
               subtitle: Text('Temperature',style: TextStyle(color: Colors.white)),
               trailing: Text(weather.getHumidity.toStringAsFixed(1)+"\u00B0",style: TextStyle(color: Colors.white)),
             ),

           ),

         ),

        Padding(padding: EdgeInsets.only(bottom: 10,),
          child : Container(
            height: 50,
            child: FlatButton(
              shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
              onPressed: (){
                /*      Navigator.push(
                  context, MaterialPageRoute(builder: (context)=>WeatherApp()),
                );
            */
                BlocProvider.of<WeatherBloc>(context).add(ResetWeather());
              },
              color: Colors.pink,
              child: Text("Back", style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),),
            ),
        ),
        ),
       ],
   );

  }
}