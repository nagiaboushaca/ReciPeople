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
@brock.route('/recipes/<recipe_id>', methods=['GET'])
def get_recipe(recipe_id):
    cursor = db.get_db().cursor()
    query = 'select * from Recipes where recipe_id ={}'.format(recipe_id)
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Get all recipes with a given recipe name
@brock.route('/recipes/<recipe_name', methods=['GET'])
def get_recipe_by_name(recipe_name):
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
    query = 'select * from Saved_recipes where username ="{}"'.format(username)
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Add a recipe to a user's saved recipes
@brock.route('/saved_recipes/<username>/<recipe_id>', methods=['POST'])
def add_saved_recipe(username, recipe_id):
    cursor = db.get_db().cursor()
    query = 'insert into Saved_recipes(username, saved_recipe_id) values("{}", {})'.format(username, recipe_id)
    cursor.execute(query)
    db.get_db().commit()
    return query

# Delete a recipe from a user's saved recipes
@brock.route('/saved_recipes/<username>/<recipe_id>', methods=['DELETE'])
def delete_saved_recipe(username, recipe_id):
    cursor = db.get_db().cursor()
    query = 'delete from Saved_recipes where username ="{}" and saved_recipe_id = {}'.format(username, recipe_id)
    cursor.execute(query)
    db.get_db().commit()
    return query

# Get all recipes that use the given ingredient name
@brock.route('/ingredients/<name>', methods=['GET'])
def get_recipes_by_ingredient(name):
    cursor = db.get_db().cursor()
    query = '''
    select Recipes.*
    from Recipes
    inner join Ingredients on Recipes.recipe_id = Ingredients.recipe_id
    where Ingredients.ingredient_name like '%{}%'
    '''.format(name)
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Get the skill level of a given recipe
@brock.route('/skill_level/<recipe_id>', methods=['GET'])
def get_skill_level(recipe_id):
    cursor = db.get_db().cursor()
    query = '''
    select s.skill_name
    from Recipes r
    join Skill_Level s on r.skill_level_id = s.skill_lvel_id
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
@brock.route('/recipeTime/<time>', methods=['GET'])
def get_recipes_by_time(time):
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
@brock.route('/equipment/<name>', methods=['GET'])
def get_recipes_by_equipment(name):
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