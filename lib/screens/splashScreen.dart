import 'package:flutter_covid_dashboard_ui/screens/signIn.dart';
import 'package:flutter_covid_dashboard_ui/screens/signUp.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:package_info/package_info.dart';

final List<String> imgList = [
  'assets/images/1.png',
  'assets/images/2.png',
  'assets/images/3.png',
  // 'https://i.ibb.co/cXgZfV6/Pink-and-Purple-Beauty-and-Fashion-Flyer-5.png',

  // 'https://i.ibb.co/59CdrDd/Pink-and-Purple-Beauty-and-Fashion-Flyer-8.png',
  // 'https://i.ibb.co/X32TjSK/Pink-and-Purple-Beauty-and-Fashion-Flyer-4.png',
  // 'https://i.ibb.co/jDmMLr1/Purple-and-Violet-Work-from-Home-COVID-Flyer.png',
  //   'https://placeit-assets1.s3-accelerate.amazonaws.com/custom-pages/flyer-maker/dj-party-dance-flyer-768x1187-663x1024.png',
  //   'https://awesomeflyer.com/wp-content/uploads/2020/02/Electro-Club-Session-Vol-4-Free-Flyer-Template-Awesomeflyer-com-300x441.jpg',
  // 'https://st4.depositphotos.com/24883724/27285/v/1600/depositphotos_272857886-stock-illustration-modern-first-place-bowling-certificate.jpg',
  // 'https://proshare.ir/images/jdownloads/screenshots/landing-page-templates-dark-theme-3.jpg',
  // 'https://proshare.ir/images/jdownloads/screenshots/landing-page-templates-dark-theme-4.jpg',

  // 'https://cms-assets.tutsplus.com/uploads/users/1631/posts/32261/image/event%20flyer%20design%20template.jpg',
  // 'https://st2.depositphotos.com/11783760/43042/v/950/depositphotos_430422580-stock-illustration-prize-retro-90s-style-on.jpg',
  // 'https://media.istockphoto.com/vectors/get-bonus-now-isolated-vector-icon-90s-retro-style-design-web-gift-vector-id1209818484?s=612x612',
  // 'https://image.freepik.com/free-vector/vector-illustration-man-winning-race_52569-1020.jpg',
];

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _current = 0;
  var W;
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
       Size screenSize = MediaQuery.of(context).size;
    W = screenSize.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 232,
              child: CarouselSlider(
                items: imageSliders,
                //  [
                // Container(
                //   // margin: EdgeInsets.all(10),
                //   decoration: BoxDecoration(
                //     image: DecorationImage(
                //       image: NetworkImage( 'https://i.pinimg.com/originals/fc/3f/0c/fc3f0c229e1f15a0de6f0217e9fd1e7f.jpg',),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),

                // //2nd Image of Slider
                // Container(
                //   margin: EdgeInsets.all(10),
                //   decoration: BoxDecoration(
                //     image: DecorationImage(
                //       image: NetworkImage( 'https://i.pinimg.com/originals/fc/3f/0c/fc3f0c229e1f15a0de6f0217e9fd1e7f.jpg',),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),

                // //3rd Image of Slider
                // Container(
                //   margin: EdgeInsets.all(10),
                //   decoration: BoxDecoration(
                //     image: DecorationImage(
                //       image: NetworkImage( 'https://i.pinimg.com/originals/fc/3f/0c/fc3f0c229e1f15a0de6f0217e9fd1e7f.jpg',),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),

                // //4th Image of Slider
                // Container(
                //   margin: EdgeInsets.all(10),
                //   decoration: BoxDecoration(
                //     image: DecorationImage(
                //       image: NetworkImage( 'https://i.pinimg.com/originals/fc/3f/0c/fc3f0c229e1f15a0de6f0217e9fd1e7f.jpg',),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),

                // //5th Image of Slider
                // Container(
                //   margin: EdgeInsets.all(10),
                //   decoration: BoxDecoration(
                //     image: DecorationImage(
                //       image: NetworkImage( 'https://i.pinimg.com/originals/fc/3f/0c/fc3f0c229e1f15a0de6f0217e9fd1e7f.jpg',),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),

                // ],

                options: CarouselOptions(
                    height: W/0.8,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.map((url) {
                int index = imgList.indexOf(url);
                print('==> url ${imgList.indexOf(url)} ${url}');
                return Container(
                  width: 18.0,
                  height: 6.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1),
                    shape: BoxShape.rectangle,
                    color: _current == index ? Color(0xff00DBFF) : Colors.grey,
                  ),
                );
              }).toList(),
            ),
            Container(
              height: W/2.34,
              decoration: BoxDecoration(
                color: Color(0xff252526),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: W/25.6,
                  ),
                  Text(
                    'By continuing, you agree to our',
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: Colors.white60,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    'Terms & Condition & Privacy Policy',
                    style: GoogleFonts.lato(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9)),
                  ),
                  SizedBox(
                    height: W/38.4,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
                            },
                            child: Container(
                                height: W/8,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        width: 1, color: Colors.white70),
                                    color: Colors.transparent),
                                child: Center(
                                  child: Text('Sign In'.toUpperCase(),
                                      style: GoogleFonts.lato(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 13,
                                          color: Colors.white,
                                          letterSpacing: 1)),
                                )),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, right: 10, left: 5),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Signup()));
                            },
                            child: Container(
                                height: W/8,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  //border: Border.all(width:1, color:Colors.white24),
                                  gradient: LinearGradient(colors: [Colors.greenAccent[200],
                    Colors.blueAccent[200]], tileMode: TileMode.clamp,)
                                ),
                                child: Center(
                                  child: Text('Create Account'.toUpperCase(),
                                      style: GoogleFonts.lato(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 13,
                                          color: Colors.black87,
                                          letterSpacing: 1)),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'v${_packageInfo.version}',
                    style: GoogleFonts.lato(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        color: Colors.white.withOpacity(0.6)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            // child:  // Container(
            //             //   // margin: EdgeInsets.all(10),
            //             //   decoration: BoxDecoration(
            //             //     image: DecorationImage(
            //             //       image: NetworkImage( 'https://i.pinimg.com/originals/fc/3f/0c/fc3f0c229e1f15a0de6f0217e9fd1e7f.jpg',),
            //             //       fit: BoxFit.cover,
            //             //     ),
            //             //   ),
            //             // ),
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('$item'),
                            // image: NetworkImage(
                            //   '$item',
                            // ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            '',
                            style: TextStyle(
                              color: Color(0xff00DBFF),
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ))
      .toList();
}
