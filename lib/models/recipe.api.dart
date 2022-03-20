import 'dart:convert';
import 'package:recipe_app/models/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeApi{
/*  var req = unirest("GET", "https://yummly2.p.rapidapi.com/feeds/list");

req.query({
	"limit": "24",
	"start": "0"
});

req.headers({
	"x-rapidapi-host": "yummly2.p.rapidapi.com",
	"x-rapidapi-key": "70470b7f58msh866f2325cfd975ap1a8fb5jsna2f991e72f43",
	"useQueryString": true
});*/

  static Future<List<Recipe>> getRecipe() async{

      var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list',{	"limit": "24",
        "start": "0", "tag": "list.recipe.popular"});

      final response = await http.get(uri, headers :{
        "x-rapidapi-host": "yummly2.p.rapidapi.com",
        "x-rapidapi-key": "70470b7f58msh866f2325cfd975ap1a8fb5jsna2f991e72f43",
        "useQueryString": "true"
      });
      
      Map data = jsonDecode(response.body);
      List _temp = [];

      for(var i in data['feed']){
        _temp.add(i['content']['details']);
      }

      return Recipe.recipesFromSnapshot(_temp);
  }
}