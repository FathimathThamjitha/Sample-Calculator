import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calclator22 extends StatefulWidget {
  const Calclator22({super.key});

  @override
  State<Calclator22> createState() => _Calclator22State();
}

class _Calclator22State extends State<Calclator22> {
  String userInput ="";
  String result ="0";
  List<String> buttonList =[
    "AC",
    "(",
    ")",
    "/",
    "7",
    "8",
    "9",
    "*",
    "4",
    "5",
    "6",
    "+",
    "1",
    "2",
    "3",
    "-",
    "C",
    "0",
    ".",
    "=",

  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      
      body:
      Column(
        children: [SizedBox(
          height: MediaQuery.of(context).size.height/3,
          child: Column(mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(padding: EdgeInsets.all(20),
                alignment: Alignment.centerRight,
                child: Text(userInput,style: TextStyle(fontSize: 30,color: Colors.white),),),
              Container(padding: EdgeInsets.all(10),
                alignment: Alignment.centerRight,
                child: Text(result,style: TextStyle(fontSize: 48,color: Colors.white,fontWeight: FontWeight.bold),),),
            ],
          ),
        ),
          Divider(color: Colors.white,),
          Expanded(child: Container(
            padding: EdgeInsets.all(10),
            child: GridView.builder(itemCount: buttonList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                    crossAxisCount: 4,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12), itemBuilder: (BuildContext context,int index){

                  return CustomButton(buttonList[index]);
                }
            ),
          )
          )
        ],
      ),
    );
  }
  Widget CustomButton(String text){
    return InkWell(
      splashColor: Colors.pink,
      onTap: (){
        setState(() {
          handleButtons(text);
        });
      },child: Ink(
      decoration: BoxDecoration(color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.white.withOpacity(0.1),
                blurRadius: 4,
                offset: Offset(-3, -3),
                spreadRadius: 0.5)
          ]),
      child: Center(
        child: Text(text,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
      ),
    ),
    );
  }
  handleButtons(String text){
    if(text=="AC"){
      userInput ="";
      result="0";
      return;
    }
    if(text =="C"){
      if(userInput.isNotEmpty){
        userInput=userInput.substring(0,userInput.length-1);
      }
      else{
        return null;

      }
    }
    if(text =="="){
      result =calculate();
      if(result.endsWith(".0")){
        result =result.replaceAll(".0", "");
      }
    }
    userInput =userInput + text;
  }
  String calculate(){
    try{
      var exp =Parser().parse(userInput);
      var evaluation =exp.evaluate(EvaluationType.REAL,ContextModel());
      return evaluation.toString();
    }catch(e){
      return "ERROR";
    }
  }
}
