import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:http/http.dart' as http;
import 'package:interview_bigo_task/Models/home_model.dart';
import 'package:interview_bigo_task/Utils/constants.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  List<HouseData>? data;
  final String siteUrl =
      'https://development-q5nzhaa-sb26hc2y3xm26.uk-1.platformsh.site/';
  @override
  void initState() {
    super.initState();

    getData();
  }

  getData() async {
    setState(() {
      _isLoading = true;
    });

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjQwNDE3OTcyLCJleHAiOjE2NDMwMDk5NzJ9.isxKdVLc_sVJa51s4jOvBQuF22VxYk2P3jscz45-HvI'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://development-q5nzhaa-sb26hc2y3xm26.uk-1.platformsh.site/houses/'));

    request.headers.addAll(headers);
    request.maxRedirects = 10;
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      String res = await response.stream.bytesToString();
      List<HouseData>? dataTemp = houseDataFromJson(res);
      setState(() {
        _isLoading = false;
        data = dataTemp;
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: DotNavigationBar(
          currentIndex: 1,
          onTap: (p0) {},
          items: [
            DotNavigationBarItem(
              icon: const Icon(Icons.home_filled),
            ),
            DotNavigationBarItem(icon: const Icon(Icons.search)),
            DotNavigationBarItem(
                icon: const Icon(Icons.calendar_today_outlined)),
            DotNavigationBarItem(icon: const Icon(Icons.notifications))
          ],
        ),
        bottomSheet: Container(
          height: 60,
          width: double.maxFinite,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.white, Colors.white10],
                begin: Alignment.bottomCenter,
                // stops: [30, 30],
                end: Alignment.topCenter),
          ),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                shrinkWrap: true,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                              Color(0xFFE1ECFE),
                              Color(0xFFE1ECFE),
                              Colors.white
                            ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Location',
                                      style: TextStyle(
                                        color: Colors.black87,
                                        // fontSize: 24,
                                        // fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Warshaw',
                                          style: boldTextStyle(),
                                        ),
                                        const Icon(
                                          Icons.location_on,
                                          color: Color(0xFFCCCBD1),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                const CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cG9ydHJhaXR8ZW58MHx8MHx8&w=1000&q=80'),
                                )
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Text(
                                'What do you want?',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    wordSpacing: 1,
                                    color: Colors.black87,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GlassContainer.frostedGlass(
                                  height: 45,
                                  color: Colors.white30,
                                  elevation: 0,
                                  borderColor: Colors.white,
                                  padding: const EdgeInsets.all(6),
                                  borderRadius: BorderRadius.circular(12),
                                  width: MediaQuery.of(context).size.width * .7,
                                  child: Row(
                                    children: [
                                      const Icon(Icons.search,
                                          color: Color(0xFFCCCBD1)),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .6,
                                        child: const TextField(
                                            decoration: InputDecoration(
                                          border: InputBorder.none,
                                          isDense: true,
                                          hintStyle: TextStyle(
                                              color: Color(0xFFCCCBD1)),
                                          hintText:
                                              'Search adress, city or location',
                                        )),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(9),
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  child: const Icon(Icons.dashboard),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                CustomIconButton(
                                  icon: FontAwesomeIcons.shoppingBag,
                                  text: 'Buy',
                                ),
                                CustomIconButton(
                                  icon: FontAwesomeIcons.tags,
                                  text: 'Sell',
                                ),
                                CustomIconButton(
                                  icon: FontAwesomeIcons.sign,
                                  text: 'Rent',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        child: CustomPaint(
                          size: Size(
                              width,
                              (width * 0.5833333333333334)
                                  .toDouble()),
                          painter: RPSCustomPainter(),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Text(
                      'Home For Sale Near You',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 260,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                    child: Image.network(
                                      data![index].img != null
                                          ? '$siteUrl${data![index].img!.url!}'
                                          : 'https://media.istockphoto.com/photos/home-with-blue-siding-and-stone-faade-on-base-of-home-picture-id1272128530?b=1&k=20&m=1272128530&s=170667a&w=0&h=k9lT5-DEmkmehDb-EKRHoP1-op2DTgz4ibiWGXmj7h8=',
                                      height: 150,
                                      width: 200,
                                    ),
                                  ),
                                  Positioned(
                                    top: 20,
                                    right: 10,
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12)),
                                      ),
                                      child: const Icon(Icons.favorite_border),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    '\$${data![index].price!}  ',
                                    style: boldTextStyle(),
                                  ),
                                  Text(timeago.format(data![index].createdAt!))
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    size: 20,
                                  ),
                                  Text(
                                    data![index].location!,
                                    style: const TextStyle(fontSize: 16),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                              Divider(
                                color: Colors.grey.shade900,
                                thickness: 2,
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const IconWithTextSml(
                                    icon: Icons.attractions_outlined,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconWithTextSml(
                                        icon: Icons.bed,
                                        text: data![index].beds,
                                      ),
                                      IconWithTextSml(
                                        icon: Icons.bathtub,
                                        text: data![index].baths,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Text(
                      'Trending',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 260,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Card(
                          // margin: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12)),
                                child: Image.network(
                                  data![index].img != null
                                      ? '$siteUrl${data![index].img!.url!}'
                                      : 'https://media.istockphoto.com/photos/home-with-blue-siding-and-stone-faade-on-base-of-home-picture-id1272128530?b=1&k=20&m=1272128530&s=170667a&w=0&h=k9lT5-DEmkmehDb-EKRHoP1-op2DTgz4ibiWGXmj7h8=',
                                  height: 150,
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                  width: 150,
                                ),
                              ),
                              Text(
                                '\$${data![index].price!}  ',
                                style: boldTextStyle(),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    size: 20,
                                  ),
                                  Text(
                                    data![index].location!,
                                    style: const TextStyle(fontSize: 16),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                              Divider(
                                color: Colors.grey.shade900,
                                thickness: 2,
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const IconWithTextSml(
                                    icon: Icons.attractions_outlined,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconWithTextSml(
                                        icon: Icons.bed,
                                        text: data![index].beds,
                                      ),
                                      IconWithTextSml(
                                        icon: Icons.bathtub,
                                        text: data![index].baths,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({Key? key, this.icon, this.text}) : super(key: key);
  final IconData? icon;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          padding:
              const EdgeInsets.only(left: 22, right: 22, top: 12, bottom: 12),
          child: Row(
            children: [
              FaIcon(
                icon,
                color: darkThemeShade,
                size: 18,
              ),
              Text(
                text!,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class IconWithTextSml extends StatelessWidget {
  const IconWithTextSml({Key? key, this.icon, this.text}) : super(key: key);
  final IconData? icon;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 14,
          ),
          Text(
            text ?? '1,234 ft2',
            style: const TextStyle(fontSize: 14),
          )
        ],
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = slightlyLightShade
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(0, size.height * 0.4228571);
    path0.quadraticBezierTo(size.width * 0.0702083, size.height * 0.5653571,
        size.width * 0.0725000, size.height * 0.6242857);
    path0.quadraticBezierTo(size.width * 0.0666667, size.height * 0.6760714,
        size.width * 0.0025000, size.height * 0.7171429);

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
