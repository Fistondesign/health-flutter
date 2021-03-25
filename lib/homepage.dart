
import 'package:flutter/material.dart';
import './pages/ahabanza.dart';
import './pages/menya.dart';
import './pages/ubutumwa.dart';

class HomePage extends StatefulWidget{
  _MyHomePage createState()=>_MyHomePage();
}

class _MyHomePage extends State<HomePage>{
  int _activeIndex=0;
  PageController pageController;

@override

void initState(){
   super.initState();
   pageController=PageController();
}
  @override
  Widget build(BuildContext context)
  {
     return Scaffold(
       appBar:AppBar(
         title:Text('ITAKUBUZIMA',style:TextStyle(color:Colors.black)),
         backgroundColor: Colors.white,
         elevation:1,
         centerTitle: true,
       ),
      body:PageView(
        controller:pageController,
        children:[
          Ahabanza(),
          Menya(),
          Ubutumwa(),
        ],
        onPageChanged:(page){
          setState(() {
            _activeIndex=page;
          });
        },
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex:_activeIndex,
        type:BottomNavigationBarType.fixed,
        showSelectedLabels:true,
        showUnselectedLabels:false,
        selectedItemColor:Colors.amber,
        unselectedItemColor:Colors.amber,
        onTap:(int index){
          setState(() {
         _activeIndex=index;
        });
          pageController.animateToPage(index, duration:Duration(
            milliseconds:200
          ),
          curve:Curves.easeIn
          );
        },
        items:[
                 BottomNavigationBarItem(icon:Icon(Icons.home),title:Text('AHABANZA')),
                 BottomNavigationBarItem(icon:Icon(Icons.book),title:Text('MENYA')),
                 BottomNavigationBarItem(icon:Icon(Icons.message),title:Text('UBUTUMWA'))

              ]
      ),
  );
  }
  
}