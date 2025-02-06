// ignore_for_file: deprecated_member_use, unnecessary_null_comparison, sized_box_for_whitespace, file_names, use_build_context_synchronously

import 'dart:convert';

import 'package:ebook/Pages/detail_audio_page.dart';
import 'package:ebook/my_tabs.dart';
import 'package:flutter/material.dart';
import 'package:ebook/styles/appColors.dart' as appcolors;

class Myhomepage extends StatefulWidget {
  const Myhomepage({super.key});

  @override
  State<Myhomepage> createState() => _MyhomepageState();
}

class _MyhomepageState extends State<Myhomepage> with SingleTickerProviderStateMixin{
  
  List popularBooks = [];
  List books = [];
  late ScrollController _scrollController;
  late TabController _tabController;

  Future<void> readData() async {
    await DefaultAssetBundle.of(context).loadString("json/popularBooks.json").then((s){
      setState(() {
        popularBooks = jsonDecode(s);
      });
    });

    await DefaultAssetBundle.of(context).loadString("json/books.json").then((s){
      setState(() {
        books = jsonDecode(s);
      });
    });
  }

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appcolors.background,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              appbar(),
              SizedBox(height: 20,),
              textPopular(),
              SizedBox(height: 20,),
              popularSection(context),
              SizedBox(height: 20,),
              Expanded(child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (BuildContext context, bool isScroll){
                  return [
                    SliverAppBar(
                      pinned: true,
                      backgroundColor: appcolors.sliverBackground,
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(50), 
                        child: Container(
                          margin: EdgeInsets.only(bottom: 30,left: 20),
                          child: TabBar(
                            indicatorPadding: EdgeInsets.all(0),
                            indicatorSize: TabBarIndicatorSize.label,
                            labelPadding: EdgeInsets.only(right: 10),
                            controller: _tabController,
                            
                            indicator: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 7,
                                  offset: Offset(0, 0)
                                  
                                )
                              ]
                            ),
                            tabs: [
                              AppTabs(color: appcolors.menu1Color, text: "New"),
                              AppTabs(color: appcolors.menu2Color, text: "Popular"),
                              AppTabs(color: appcolors.menu3Color, text: "trending")
                            ],
                          ),
                        )
                        ),
                    )
                  ];
                },
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    ListView.builder(
                      itemCount: books == null ? 0 : books.length,
                      itemBuilder: (_,i){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=>DetailAudioPage(booksData:books, index:i))
                          );
                        },
                        child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: appcolors.tabVarViewColor,
                            boxShadow:[ BoxShadow(
                              blurRadius: 2,
                              offset: Offset(0, 0),
                              color: Colors.grey.withOpacity(0.2)
                            )]
                          ),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Container(
                                  width: 90,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: AssetImage(books[i]["img"])
                                    )
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.star, size: 24, color: appcolors.starColor,),
                                        SizedBox(width: 5,),
                                        Text(books[i]["rating"], style: TextStyle(
                                          color: appcolors.menu2Color
                                        ),)
                                      ],
                                    ),
                                    Text(books[i]["title"], style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Avenir",
                                      fontWeight: FontWeight.bold
                                    ),),
                                    Text(books[i]["text"], style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Avenir",
                                      color: appcolors.subTitleText
                                    ),),
                                    Container(
                                      width: 60,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: appcolors.loveColor
                                      ),
                                    alignment: Alignment.center,
                                      child: Text("Love", style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Avenir",
                                      color: Colors.white
                                    ),),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      );

                      
                    }),
                    Material(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                        title: Text("Content"),
                      ),
                    ),
                    Material(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                        title: Text("Content"),
                      ),
                    )
                  ]
                )
                ))
            ],
          ),
        )
      ),
    );
  }

  Container popularSection(BuildContext context) {
    return Container(
              height: 180,
              child : Stack(
                children: [

                  Positioned(
                    top: 0,
                    right: 0,
                    left: -20,
                    child: Container(
                    height: 180,
                    child: PageView.builder(
                    controller: PageController(viewportFraction: 0.8),
                    itemCount: popularBooks == null ? 0 : popularBooks.length,
                    itemBuilder: (_, i){
                      return Container(
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(15),
                        image: DecorationImage(
                          image: AssetImage(popularBooks[i]["img"]),
                          fit: BoxFit.fill
                         )
                        )
                      );
                    }),
                    ),
                  )
                ],
              )
              
            );
  }

  Row textPopular() {
    return Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Text("Popular Books", style: TextStyle(fontSize: 30),),
                )
              ],
            );
  }

  Container appbar() {
    return Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ImageIcon(AssetImage("img/menu.png"),size: 24, color: Colors.black,),
                  Row(
                    children: [
                      Icon(Icons.search),
                      SizedBox(width: 10,),
                      Icon(Icons.notifications)
                    ],
                  )
                ],
              ),
            );
  }
}