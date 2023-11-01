import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/news_view_screen.dart';


Widget newsUnit(article,context){
  return InkWell(
    onTap: (){
      navigateTo(context, NewsViewScreen('${article['url']}'));
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage('${article['urlToImage']}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            "${article['title']}",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyText1
          ),
          const SizedBox(height: 10,),
          Text('${article['publishedAt']}',
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    ),
  );
}

Widget articleBuilder (list, context , {isSearch = false}){
  return ConditionalBuilder(
    condition: list.length > 0,
    builder:(context)=> ListView.separated(
      physics:  const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) => newsUnit(list[index], context),
      separatorBuilder: (BuildContext context, int index) =>Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey[300],
        ),
      ),
      itemCount: list.length,
    ) ,
    fallback: (context) => isSearch?  Container() : const Center(child: CircularProgressIndicator())
    ,
  );
}

void navigateTo (context , widget){
   Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => widget
    ),
  );
}


// Widget defaultTextField ({
//   required TextEditingController controller,
//   required TextInputType inputType,
//   required var validate,
//   required String lableText,
//   required String hintText,
//   required IconData prefexIcon,
//   var onTap,
//   var onChange,
//   IconData? suffixIcon,
//   bool isEmpty =false,
// }
//     )=> TextFormField(
//   controller: controller,
//   keyboardType: inputType,
//   obscureText: isEmpty,
//   onTap: onTap,
//   onChanged: onChange,
//   validator: validate,
//   decoration: InputDecoration(
//     hintText: hintText,
//     labelText: lableText,
//     //border: OutlineInputBorder(),
//     prefixIcon: Icon(prefexIcon),
//     suffixIcon: Icon(suffixIcon),
//
//
//   ),
// );