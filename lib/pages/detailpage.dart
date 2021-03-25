import 'package:flutter/material.dart';
import '../api.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Detailpage extends StatefulWidget{
  _Detailpage createState()=>_Detailpage();
}

class _Detailpage extends State<Detailpage>
{
   var title="Title of content";
   var content="content";
   var image="image";
   bool available=false;


  Map _arguments={};

  @override
  void initState(){
    super.initState();

       Future.delayed(Duration.zero,(){
       setState(() {
          _arguments=ModalRoute.of(context).settings.arguments;
       });
       _loaddata(_arguments['itemId']);
    });
    
  }

  _loaddata(articleId)async{
    print(articleId);
    var sendrequest= await Callback().getData('articledetail/$articleId');
    var response=json.decode(sendrequest.body.toString());
    var data=response['data'];
    print(data);  
    if(data.length>0)
    {
       setState(() {
         title=data[0]["article_title"];
         image=data[0]["article_image"];
         content=data[0]["article_content"];
         print(data);
          available=true;
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
        body:available?
        SingleChildScrollView(
          scrollDirection:Axis.vertical,
          child:Column(
             children: [
               Container(
                 child:Text(''),
                 width:double.infinity,
                 height:300.0,
                 decoration:BoxDecoration(
                  image:new DecorationImage(
                    image:new NetworkImage(Callback().urltoimages+image),
                    fit:BoxFit.cover
                  ),
                   color:Colors.amber
                 ),
               ),
               Container(
                 padding:EdgeInsets.all(5),
                 child:Column(
                   children:[
                    Container(
                      padding:EdgeInsets.only(left:30,top:10),
                      width:double.infinity,
                      child:Text('$title',style:TextStyle(fontWeight:FontWeight.bold,fontSize:20,letterSpacing:1.2),),
                      height:50,
              
                    ),
                    //this is end of title container

                    Container(
                      padding:EdgeInsets.all(10),
                      width:double.infinity,
                      child:Text("$content",style:TextStyle(height:1.4))
                    ),

                    //this is the end of content container

                   ]
                 ),
                 width:double.infinity,
                 decoration:BoxDecoration(
                   color:Colors.white
                 ),
               ),

             ]
        ),
        )
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