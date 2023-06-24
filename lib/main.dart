import 'package:flutter/material.dart';

final Color mainYellow = Color(0xFFFFB02F);
final Color primaryGray = Color(0xFF313131);
final Color secondaryGray = Color(0xFF1C1C1C);
final Color lightGray = Color(0xFF3B3B3B);

final List<AttractionModel> attractions = [
  AttractionModel(
      imgPath:
          'https://images.pexels.com/photos/260590/pexels-photo-260590.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260',
      name: 'Golden Gate Bridge',
      location: 'San Francisco, CA',
      description:
          'The Golden Gate Bridge is a suspension bridge spanning the Golden Gate, the one-mile-wide strait connecting San Francisco Bay and the Pacific Ocean.'),
  AttractionModel(
      imgPath:
          'https://images.pexels.com/photos/5627275/pexels-photo-5627275.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260',
      name: 'Brooklyn Bridge',
      location: 'Brooklyn, NY',
      description:
          'The Golden Gate Bridge is a suspension bridge spanning the Golden Gate, the one-mile-wide strait connecting San Francisco Bay and the Pacific Ocean.'),
  AttractionModel(
      imgPath:
          'https://images.pexels.com/photos/5241381/pexels-photo-5241381.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260',
      name: 'London Bridge',
      location: 'London, UK',
      description:
          'The Golden Gate Bridge is a suspension bridge spanning the Golden Gate, the one-mile-wide strait connecting San Francisco Bay and the Pacific Ocean.'),
  AttractionModel(
      imgPath:
          'https://images.pexels.com/photos/1680247/pexels-photo-1680247.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
      name: 'Harbour Bridge',
      location: 'Sydney, AU',
      description:
          'The Golden Gate Bridge is a suspension bridge spanning the Golden Gate, the one-mile-wide strait connecting San Francisco Bay and the Pacific Ocean.')
];

final List<BottomBarModel> bottomBarListItems = [
  BottomBarModel(icon: Icons.explore_outlined, isSelected: true),
  BottomBarModel(icon: Icons.favorite_border, isSelected: false),
  BottomBarModel(icon: Icons.comment_outlined, isSelected: false),
  BottomBarModel(icon: Icons.account_circle_outlined, isSelected: false),
];

void main() {
  runApp(MaterialApp(home: SplashPage(), debugShowCheckedModeBanner: false));
}

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LandingPage()));
    });

    return Stack(
      children: [
        Container(
          color: mainYellow,
        ),
        Align(
          alignment: Alignment.center,
          child: Icon(Icons.airplanemode_on, color: Colors.black, size: 80),
        ),
        Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 160,
              height: 160,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black.withOpacity(0.2)),
                strokeWidth: 10,
              ),
            ))
      ],
    );
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: primaryGray,
            iconTheme: IconThemeData(color: mainYellow),
            title: Center(child: Icon(Icons.airplanemode_on, color: mainYellow)),
            actions: [
              Container(
                  margin: EdgeInsets.only(right: 10),
                  child: IconButton(
                      icon: Icon(Icons.notifications_on_outlined, color: Colors.grey),
                      onPressed: () {}))
            ]),
        drawer: Drawer(
            child: Container(
                color: mainYellow,
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.all(20),
                child: Icon(Icons.airplanemode_on, size: 80, color: Colors.black))),
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [primaryGray, secondaryGray],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [HeaderWidget(), AttractionListView(), BottomBarWidget()])));
  }
}

//-----WIDGETS-----

class HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: EdgeInsets.only(top: 30, left: 30, right: 30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Where do you',
              style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
          Text('want to go?',
              style: TextStyle(color: mainYellow, fontSize: 30, fontWeight: FontWeight.bold))
        ]),
      ),
      Padding(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: lightGray),
              margin: EdgeInsets.only(top: 20, bottom: 20),
              child: Row(children: [
                Icon(Icons.search, color: Colors.grey),
                SizedBox(width: 10),
                Text('Search', style: TextStyle(color: Colors.grey))
              ])))
    ]);
  }
}

class AttractionListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            padding: EdgeInsets.only(left: 10),
            itemCount: attractions.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              AttractionModel currentAttraction = attractions[index];
              return AttractionCard(attractionModel: currentAttraction);
            }));
  }
}

class AttractionCard extends StatelessWidget {
  AttractionModel? attractionModel;

  AttractionCard({this.attractionModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailsPage(
                    selectedModel: attractionModel,
                  )));
        },
        child: Container(
            width: 180,
            margin: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Stack(children: [
                Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(attractionModel!.imgPath!), fit: BoxFit.cover))),
                Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter))),
                Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(attractionModel!.name!,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                          Text(attractionModel!.location!, style: TextStyle(color: mainYellow))
                        ]))
              ]),
            )));
  }
}

class BottomBarWidget extends StatefulWidget {
  @override
  State<BottomBarWidget> createState() => BottomBarWidgetState();
}

class BottomBarWidgetState extends State<BottomBarWidget> {
  List<BottomBarModel> _bottomBarItems = bottomBarListItems;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20, bottom: 20),
        padding: EdgeInsets.all(20),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_bottomBarItems.length, (index) {
              var barItemWidget = _bottomBarItems[index];

              return IconButton(
                  icon: Icon(barItemWidget.icon,
                      color: barItemWidget.isSelected! ? mainYellow : Colors.grey),
                  onPressed: () {
                    setState(() {
                      _bottomBarItems.forEach((element) {
                        element.isSelected = element == barItemWidget;
                      });
                    });
                  });
            })));
  }
}

class DetailsPage extends StatelessWidget {
  AttractionModel? selectedModel;

  DetailsPage({this.selectedModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(selectedModel!.imgPath!), fit: BoxFit.cover))),
      Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter))),
      Padding(
          padding: EdgeInsets.all(30),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(selectedModel!.name!,
                    style:
                        TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
                Text(selectedModel!.location!, style: TextStyle(color: mainYellow)),
                SizedBox(height: 20),
                Text(selectedModel!.description!,
                    style: TextStyle(color: Colors.white.withOpacity(0.7))),
                SizedBox(height: 40),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  TextButton(
                      child: Text('View Comments', style: TextStyle(color: Colors.white)),
                      onPressed: () {}),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Material(
                        color: mainYellow,
                        child: InkWell(
                          onTap: () {},
                          splashColor: Colors.black.withOpacity(0.1),
                          highlightColor: Colors.black.withOpacity(0.2),
                          child: Container(
                              padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                              child: Text('Use Itinerary',
                                  style:
                                      TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
                        ),
                      ))
                ])
              ])),
      AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: mainYellow),
          title: Center(child: Icon(Icons.airplanemode_on, color: mainYellow)),
          actions: [
            Container(
                margin: EdgeInsets.only(right: 10),
                child: IconButton(icon: Icon(Icons.favorite, color: mainYellow), onPressed: () {}))
          ])
    ]));
  }
}

//-----MODELS-----

class AttractionModel {
  String? imgPath;
  String? name;
  String? location;
  String? description;

  AttractionModel({this.imgPath, this.name, this.location, this.description});
}

class BottomBarModel {
  IconData? icon;
  bool? isSelected;

  BottomBarModel({this.icon, this.isSelected});
}
