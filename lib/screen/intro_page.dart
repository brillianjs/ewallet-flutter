import 'package:animate_do/animate_do.dart';
import 'package:crypto_wallet_app/screen/home_page.dart';
import 'package:crypto_wallet_app/screen/login_page.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:slide_to_act/slide_to_act.dart';

////////////////////////////////////////
///   @faiz.rhm on Instagram
///
///   https://github.com/Faiz-rhm
///////////////////////////////////////

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 64, right: 16),
            child: Column(children: [
              FadeInDown(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/NFT_4.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              FadeInLeft(
                  child: Text(
                'Buat Aplikasi Dompet Mata Uang Kripto Anda',
                style: TextStyle(
                    color: Colors.yellowAccent[700],
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    fontFamily: ''),
              )),
              const SizedBox(
                height: 20,
              ),
              FadeInLeft(
                  child: const Text(
                'Kembangkan portofolio Anda dengan menerima hadiah hingga 15,5% pada aset kripto Anda',
                style: TextStyle(color: Colors.grey, fontSize: 20),
              )),
              const SizedBox(
                height: 100,
              ),
            ]),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Builder(
              builder: (context) {
                final GlobalKey<SlideActionState> key = GlobalKey();
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SlideAction(
                    sliderRotate: false,
                    outerColor: Colors.grey[900],
                    innerColor: Colors.yellowAccent[700],
                    key: key,
                    sliderButtonIcon: const Icon(IconlyBroken.arrow_right),
                    onSubmit: () {
                      Future.delayed(
                        const Duration(seconds: 1),
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                      );
                    },
                    child: FadeInRight(
                        child: const Text(
                      'Geser untuk memulai',
                      style: TextStyle(color: Colors.grey, fontSize: 17),
                    )),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
