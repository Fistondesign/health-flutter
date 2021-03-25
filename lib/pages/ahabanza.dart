

import 'package:flutter/material.dart';
import '../api.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Ahabanza extends StatefulWidget{
  _Ahabanza createState()=>_Ahabanza();
}

class _Ahabanza extends State<Ahabanza>
{
    var data=[];
    var search="";
    var searchdataAvailable=false;
    var searchResult=[];

  @override
  void initState(){
    super.initState();
    _loaddata();
  }

  _loaddata()async{
 
    var sendrequest= await Callback().getData('articletumenye');
    var response=json.decode(sendrequest.body);
    var datas=response['data'];
    if(datas.length>0)
    {
      setState(() {
        data=datas;
      });
    }
}
void _searchfunction()async{
      Map<String,String> dataval={

      'content':search,
  
    };
      var sendrequest= await Callback().postData(dataval,'search');
    var response=json.decode(sendrequest.body);
    var datas=response['data'];
    print(datas);
    if(datas.length>0)
    {
    setState(() {
    searchResult=datas;
    searchdataAvailable=true;
     });
      
    }

 
}

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        body:SingleChildScrollView(
          scrollDirection:Axis.vertical,
          child:Column(
             children: [
               Container(
                 child:_searchholder(context),
                 width:double.infinity,
                 height:300.0,
                 decoration:BoxDecoration(
                  
                    image:DecorationImage(
                   image:new AssetImage('assets/search1.jpg'),
                   fit:BoxFit.cover
              ),
              ),
               ),
               //condition to show search result
               searchdataAvailable?
                Container(
                 height:120,
                 width:double.infinity,
                 decoration:BoxDecoration(
                  color:Colors.white,
              ),
              child:Center(
                  child: ListView.builder(
                   scrollDirection:Axis.horizontal,
              itemCount:searchResult.length,
              itemBuilder:(BuildContext context,index){

                return _card(context,data[index]['article_image'], data[index]['article_title'],data[index]['article_id']);
            }
            ),
            ),
            )
            :
            SizedBox(height:0),
            
            //close of condition to show search result
               
               Container(
                 padding:EdgeInsets.all(10),
                 width:double.infinity,
                 height:80.0,
                 child:_headerHolder(),
                 decoration:BoxDecoration(
                   color:Colors.white
                 )
               ),
               Container(
                 padding:EdgeInsets.all(10),
                 margin:EdgeInsets.only(bottom:20),
                 child:data.length>0?
                Center(
                  child: ListView.builder(
                   scrollDirection:Axis.horizontal,
              itemCount:data.length,
              itemBuilder:(BuildContext context,index){

                return _card(context,data[index]['article_image'], data[index]['article_title'],data[index]['article_id']);
            }
            ),
                )
            :
            Center(
          child:SpinKitFadingCircle(
            color: Colors.black,
            size: 50.0,
            ),
          ),

                 width:double.infinity,
                 height:130.0,
                 decoration:BoxDecoration(
                   color:Colors.white
                 ),
               ),



              SizedBox(height:20)
             ],
            
          ),
        ),
    );
  }


Widget _searchholder(BuildContext context)
{
  return Center(
    child:Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        Text('ISHAKIRO',style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold,fontSize:16)),
        Container(
          padding:EdgeInsets.all(15),
          width:double.infinity,
          height:140,
          child:Column(
            mainAxisAlignment:MainAxisAlignment.spaceAround,
            children:[
               _searchcontainer(context),
            ]
          ),
        )
      ]
    ),
  );
    
}
Widget _searchcontainer(BuildContext context)

{
  return Container(
    padding:EdgeInsets.only(left:10),
     width:double.infinity,
     height:45,
     child:TextField(
       onChanged:(text){
         search=text;
       },
            
      autofocus:false,
      decoration:InputDecoration(
      hintText:" Andika hano..",
      focusColor:Colors.white,
      border:InputBorder.none,
      suffixIcon:GestureDetector(
        onTap:()=>_searchfunction(),
        child:Icon(Icons.search)
      )
     ),
     ),
    decoration:BoxDecoration(
      color:Colors.white,
      borderRadius:BorderRadius.circular(40)
    )
  );
}

Widget _card(BuildContext context,url,title,itemId)
{
  return Card(
      child:GestureDetector(
        onTap:(){
          Navigator.of(context).pushNamed('/detailpage',arguments:{'itemId':itemId});
        },
        child:Container(
        width:300,
        height:120,
        child:Row(
        
          children:[
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: ClipOval(
               child:Image.network(Callback().urltoimages+url,
                height:80,
                width:80,
                fit:BoxFit.cover
               ),
             ),
           ),
           Container(
             width:200,
             height:140.0,
             child:Center(child:Text(title)),
           )
        ]),
      
      ),
      ),
      elevation:4,
  );
}

Widget _headerHolder()
{
  return Row(
     mainAxisAlignment:MainAxisAlignment.spaceBetween,
      children: [
        Text('Tumenye Kwivura'),
        //IconButton(icon: Icon(Icons.arrow_forward), onPressed: (){}),
      ],
  );
}


}