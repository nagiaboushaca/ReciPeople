from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db

brock = Blueprint('brock', __name__)

# Get all recipes from the database
@brock.route('/recipes', methods=['GET'])
def get_recipes():
    cursor = db.get_db().cursor()
    query = '''
    SELECT *
    FROM Recipes
    '''
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Get all the details of a given recipe
@brock.route('/recipeFromPost/<postid>', methods=['GET'])
def get_recipe(postid):
    cursor = db.get_db().cursor()
    query = 'select * from Recipes where recipe_id ={}'.format(postid)
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Get all recipes with a given recipe name
@brock.route('/recipeName', methods=['GET'])
def get_recipe_by_name():
    the_data = request.json
    current_app.logger.info(the_data)
    recipe_name = the_data['recipe_name']
    cursor = db.get_db().cursor()
    query = 'select * from Recipes where recipe_name ="{}"'.format(recipe_name)
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Get all saved reciped by a user
@brock.route('/saved_recipes/<username>', methods=['GET'])
def get_saved_recipes(username):
    cursor = db.get_db().cursor()
    query = '''
    SELECT Recipes.recipe_name, Recipes.steps, Recipes.recipe_time, Recipes.skill_level_id, Recipes.serving_size, Recipes.calories, Cuisines.cuisine_name 
    FROM Saved_recipes 
    INNER JOIN Recipes ON Saved_recipes.saved_recipe_id = Recipes.recipe_id 
    INNER JOIN Cuisines ON Recipes.cuisine_id = Cuisines.cuisine_id 
    WHERE Saved_recipes.username = "{}";
    '''.format(username)
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Add a recipe to a user's saved recipes
@brock.route('/saved_recipes/<username>/<recipeid>', methods=['POST'])
def add_saved_recipe(username, recipeid):
    cursor = db.get_db().cursor()
    query = 'insert into Saved_recipes(username, saved_recipe_id) values("{}", {})'.format(username, recipeid)
    cursor.execute(query)
    cursor2 = db.get_db().cursor()
    query2 = 'select * from Saved_recipes where username="{}"'.format(username)
    cursor2.execute(query2)
    db.get_db().commit()
    column_headers = [x[0] for x in cursor2.description]
    json_data = []
    theData = cursor2.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Delete a recipe from a user's saved recipes
@brock.route('/saved_recipes/<username>/<recipeid>', methods=['DELETE'])
def delete_saved_recipe(username, recipeid):
    cursor = db.get_db().cursor()
    query = 'delete from Saved_recipes where username="{}" and saved_recipe_id={}'.format(username, recipeid)
    cursor.execute(query)
    cursor2 = db.get_db().cursor()
    query2 = 'select count(*) from Saved_recipes where username="{}" and saved_recipe_id={}'.format(username, recipeid)
    cursor2.execute(query2)
    db.get_db().commit()
    column_headers = [x[0] for x in cursor2.description]
    json_data = []
    theData = cursor2.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Get all recipes that use the given ingredient name
@brock.route('/ingredientName', methods=['GET'])
def get_recipes_by_ingredient():
    the_data = request.json
    current_app.logger.info(the_data)
    ingredient_name = the_data['ingredient_name']
    cursor = db.get_db().cursor()
    query = '''
    select Recipes.*
    from Recipes
    inner join Ingredients on Recipes.recipe_id = Ingredients.recipe_id
    where Ingredients.ingredient_name like '%{}%'
    '''.format(ingredient_name)
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Get the skill level of a given recipe
@brock.route('/skill_level', methods=['GET'])
def get_skill_level():
    the_data = request.json
    current_app.logger.info(the_data)
    recipe_id = the_data['recipe_id']
    cursor = db.get_db().cursor()
    query = '''
    select s.skill_name
    from Recipes r
    join Skill_Level s on r.skill_level_id = s.skill_level_id
    where r.recipe_id = {}
    '''.format(recipe_id)
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Get all recipes that take less than the given time 
@brock.route('/recipeTime', methods=['GET'])
def get_recipes_by_time():
    the_data = request.json
    current_app.logger.info(the_data)
    time = the_data['recipe_time']
    cursor = db.get_db().cursor()
    query = '''
    select *
    from Recipes
    where recipe_time <= {}
    '''.format(time)
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Get all recipes that use the given equipment name
@brock.route('/equipment', methods=['GET'])
def get_recipes_by_equipment():
    the_data = request.json
    current_app.logger.info(the_data)
    name = the_data['equipment_name']
    cursor = db.get_db().cursor()
    query = '''
    select Recipes.*
    from Recipes
    inner join Equipment on Recipes.recipe_id = Equipment.recipe_id
    where Equipment.equipment_name like '%{}%'
    '''.format(name)
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Get the cuisine name from the cuisine ID 
@brock.route('/cuisineName/<cuisineid>', methods=['GET'])
def get_cuisine_name(cuisineid):
    cursor = db.get_db().cursor()
    query = 'select cuisine_name from Cuisines where cuisine_id={}'.format(cuisineid)
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)
