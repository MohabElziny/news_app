import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:full_news_app/modules/web_view/web_view_screen.dart';

Widget buildNewsItem(article, context) => InkWell (
  onTap: () {
    navigateTo(context, WebViewScreen('${article['url']}'),);
  },
  child:   Padding(
  
    padding: const EdgeInsets.all(20.0),
  
    child: Row(
  
      children: [
  
        Container(
  
          width: 90,
  
          height: 90,
  
          decoration: BoxDecoration(
  
            borderRadius: BorderRadius.circular(10),
  
            image: DecorationImage(
  
              image: NetworkImage('${article['urlToImage']}'),
  
              fit: BoxFit.cover,
  
            ),
  
          ),
  
        ),
  
        SizedBox(
  
          width: 20,
  
        ),
  
        Directionality(
  
          textDirection: TextDirection.rtl,
  
          child: Expanded(
  
            child: Container(
  
              height: 90,
  
              child: Column(
  
                mainAxisSize: MainAxisSize.min,
  
                crossAxisAlignment: CrossAxisAlignment.start,
  
                mainAxisAlignment: MainAxisAlignment.start,
  
                children: [
  
                  Expanded(
  
                    child: Text(
  
                      '${article['title']}',
  
                      style: Theme.of(context).textTheme.bodyText1,
  
                      maxLines: 2,
  
                      overflow: TextOverflow.ellipsis,
  
                    ),
  
                  ),
  
                  Text(
  
                    '${article['publishedAt']}',
  
                    style: TextStyle(
  
                      color: Colors.grey,
  
                    ),
  
                  ),
  
                ],
  
              ),
  
            ),
  
          ),
  
        )
  
      ],
  
    ),
  
  ),
);

Widget newsBuilder(list, context, {isSearch = false}) => ConditionalBuilder(

  condition: list.length>0,

  builder: (context) => ListView.separated(

    physics: BouncingScrollPhysics(),// to blue color when scrolling

    itemBuilder: (context, index) => buildNewsItem(list[index], context),

    separatorBuilder: (context, index) => Padding(

      padding: const EdgeInsetsDirectional.only(

        start: 20,

      ),

      child: Container(

        width: double.infinity,

        height: 1,

        color: Colors.grey[300],

      ),

    ),

    itemCount: list.length,

  ),

  fallback: (context) => isSearch ? SizedBox(width: 0.1,) : Center(child: CircularProgressIndicator()),

);

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true,
  Color isModeLabel,
  Color isModeText,
  Color isModeBorder,

}) =>
    TextFormField(
      controller: controller,
      style: TextStyle(
        color: isModeText
      ),
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: isModeLabel,
        ),
        prefixIcon: Icon(
          prefix,
          color: Colors.grey,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
          ),
        )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: isModeBorder,
          ),
        ),
      ),
    );

void navigateTo(context, widget) => Navigator.push(context,
    MaterialPageRoute(
    builder: (context) => widget,
    )
);