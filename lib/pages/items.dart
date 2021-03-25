import 'package:flutter/material.dart';
import '../api.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Items extends StatefulWidget{
  _Items createState()=>_Items();
}

class _Items extends State<Items>
{

   var data= []; 
   Map params={};
   var test={};

  @override

  void initState()
  {
    super.initState();
    Future.delayed(Duration.zero,(){
       setState(() {
          params=ModalRoute.of(context).settings.arguments;
       });

       _loaddata(params['catId']);
    });
    
  }

 _loaddata(params)async{
   
    var sendrequest= await Callback().getData('article/$params');
    var response=json.decode(sendrequest.body);
    var datas=response['data'];
    if(datas.length>0)
    {
      setState(() {
        data=datas;
      });
      

    }
}

  @override
  Widget build(BuildContext context)
  {

   
    return Scaffold(
        appBar:AppBar(
          leading:IconButton(onPressed:(){
            Navigator.pop(context);
          },icon:Icon(Icons.arrow_back),color:Colors.black),
         title:Text('ITAKUBUZIMA',style:TextStyle(color:Colors.black)),
         backgroundColor: Colors.white,
         elevation:1,
         centerTitle: true,
       ),
        body:data.length>0?
        Container(  
            padding: EdgeInsets.all(12.0),  
            child: GridView.builder(  
              itemCount: data.length,  
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(  
                  crossAxisCount: 2,  
                  crossAxisSpacing: 4.0,  
                  mainAxisSpacing: 4.0  
              ),  
              itemBuilder: (BuildContext context, int index){  
                return _card(context,data[index]['article_image'], data[index]['article_title'],data[index]['article_id']);
              },  
            ))
            :
          Center(
          child:SpinKitFadingCircle(
            color: Colors.black,
            size: 50.0,
            ),
          ),
      );

  }
}

Widget _card(BuildContext context,url,title,itemId)
{
  return Card(
      child:GestureDetector(
        onTap:(){
          Navigator.of(context).pushNamed('/detailpage',arguments:{'itemId':itemId});
        },
        child:Container(
        padding:EdgeInsets.all(10),
        width:double.infinity,
        child:  Container(
             margin:EdgeInsets.only(top:90),
             width:80,
             height:40.0,
             child:Center(child:Text(title,style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold,),textAlign:TextAlign.left,)),
           ),
       decoration:BoxDecoration(
         image:new DecorationImage(
           image:new NetworkImage(Callback().urltoimages+url),
           fit:BoxFit.cover
         ),
         borderRadius:BorderRadiusDirectional.circular(5)
       ),
      ),
      ),
      elevation:4,
    
  );
}

