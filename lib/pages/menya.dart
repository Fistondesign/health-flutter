import 'package:flutter/material.dart';
import '../api.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Menya extends StatefulWidget{
  _Menya createState()=>_Menya();
}

class _Menya extends State<Menya>
{
  var data=[];

  @override
  void initState(){
    super.initState();
    _loaddata();
  }

  _loaddata()async{
 
    var sendrequest= await Callback().getData('categories');
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
        body:data.length>0?Container(
          padding:EdgeInsets.all(10),
          width:double.infinity,
     
            child:ListView.builder(
              itemCount:data.length,
              itemBuilder:(BuildContext context,index){

                return _card(context,data[index]['cat_thumb'], data[index]['cat_name'],data[index]['cat_id']);
            }
            ),
          decoration:BoxDecoration(
            
          )
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

Widget _card(BuildContext context,url,title,catId)
{
  return Card(
      child:GestureDetector(
        onTap:(){
          Navigator.of(context).pushNamed('/items',arguments:{'catId':catId});
        },
        child:Container(
        padding:EdgeInsets.all(10),
        width:double.infinity,
        height:220,
        child:Row(
        mainAxisAlignment:MainAxisAlignment.start,
          children:[
           Container(
             margin:EdgeInsets.only(top:140),
             width:150,
             height:40.0,
             child:Center(child:FlatButton(onPressed: (){}, child:Text(title))),
             decoration:BoxDecoration(
               color:Colors.white,
               borderRadius:BorderRadius.circular(10)
             )
           )
        ]),
       decoration:BoxDecoration(
         image:new DecorationImage(
           image:new NetworkImage(Callback().urltoimages+url),
           fit:BoxFit.cover
         )
         
       ),

      ),
      ),

      elevation:4,
  );
}

