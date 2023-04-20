from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


josie = Blueprint('josie', __name__)

# Get all accounts from the database
@josie.route('/accounts', methods=['GET'])
def get_accounts():
    cursor = db.get_db().cursor()
    query = '''
    SELECT *
    FROM Accounts
    '''
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Add a new account to the database
@josie.route('/accounts', methods=['POST'])
def new_account():

    the_data = request.json
    current_app.logger.info(the_data)

    username = the_data['username']
    password = the_data['pword']
    first_name = the_data['first_name']
    last_name = the_data['last_name']
    email = the_data['email']
    phone = the_data['phone_number']
    bio = the_data['bio']

    query = '''
    insert into Accounts values("{}", "{}", "{}", "{}", "{}", "{}", "{}")
    '''.format(username, password, first_name, last_name, bio, email, str(phone))
    
    cursor = db.get_db().cursor()
    cursor.execute(query)

    query2 = 'select * from Accounts where username="{}"'.format(username)
    cursor2 = db.get_db().cursor()
    cursor2.execute(query2)
    db.get_db().commit()

    column_headers = [x[0] for x in cursor2.description]
    json_data = []
    theData = cursor2.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


# Gets all account data for a given username
@josie.route('/account', methods=['GET'])
def get_account():
    the_data = request.json
    current_app.logger.info(the_data)
    username = the_data['username']
    cursor = db.get_db().cursor()
    query = 'select * from Accounts where username="{}"'.format(username)
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


# Deletes the account of a given username
@josie.route('/accounts', methods=['DELETE'])
def delete_account():
    the_data = request.json
    current_app.logger.info(the_data)
    username = the_data['username_b']
    pword = the_data['pword_a']
    cursor = db.get_db().cursor()
    query = 'delete from Accounts where username="{}" and pword ="{}"'.format(username, pword)
    cursor.execute(query)
    cursor2 = db.get_db().cursor()
    query2 = 'select count(*) from Accounts where username="{}"'.format(username)
    cursor2.execute(query2)
    db.get_db().commit()
    column_headers = [x[0] for x in cursor2.description]
    json_data = []
    theData = cursor2.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Gets the password of the given account
@josie.route('/accountPword', methods=['GET'])
def get_account_pword():
    the_data = request.json
    current_app.logger.info(the_data)
    username = the_data['username']
    cursor = db.get_db().cursor()
    query = 'select pword from Accounts where username="{}"'.format(username)
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Updates the password of the given account
@josie.route('/accountPword', methods=['PUT'])
def update_account_pword():
    the_data = request.json
    current_app.logger.info(the_data)
    username = the_data['username']
    pword = the_data['pword']
    cursor = db.get_db().cursor()
    query = 'update Accounts set pword="{}" where username="{}"'.format(pword, username)
    cursor.execute(query)
    cursor2 = db.get_db().cursor()
    query2 = 'select pword from Accounts where username="{}"'.format(username)
    cursor2.execute(query2)
    db.get_db().commit()
    column_headers = [x[0] for x in cursor2.description]
    json_data = []
    theData = cursor2.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Gets the bio of the given account
@josie.route('/accountBio', methods=['GET'])
def get_account_bio():
    the_data = request.json
    current_app.logger.info(the_data)
    username = the_data['username']
    cursor = db.get_db().cursor()
    query = 'select bio from Accounts where username="{}"'.format(username)
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Updates the bio of the given account
@josie.route('/accountBio', methods=['PUT'])
def update_account_bio():
    the_data = request.json
    current_app.logger.info(the_data)
    username = the_data['username_a']
    bio = the_data['bio']
    cursor = db.get_db().cursor()
    query = 'update Accounts set bio ="{}" where username="{}"'.format(bio, username)
    cursor.execute(query)
    cursor2 = db.get_db().cursor()
    query2 = 'select bio from Accounts where username="{}"'.format(username)
    cursor2.execute(query2)
    db.get_db().commit()
    column_headers = [x[0] for x in cursor2.description]
    json_data = []
    theData = cursor2.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Sets the bio of the given account to an empty string
@josie.route('/accountBioEmpty', methods=['PUT'])
def delete_accounts_bio():
    the_data = request.json
    current_app.logger.info(the_data)
    username = the_data['username_b']
    cursor = db.get_db().cursor()
    query = 'update Accounts set bio="" where username="{}"'.format(username)
    cursor.execute(query)
    cursor2 = db.get_db().cursor()
    query2 = 'select bio from Accounts where username="{}"'.format(username)
    cursor2.execute(query2)
    db.get_db().commit()
    column_headers = [x[0] for x in cursor2.description]
    json_data = []
    theData = cursor2.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Follows a user 
@josie.route('/follow', methods=['POST'])
def follow_user():
    the_data = request.json
    current_app.logger.info(the_data)
    username = the_data['username']
    follow = the_data['follow']
    cursor = db.get_db().cursor()
    query = 'insert into FollowerRelationship(A, B) values("{}", "{}")'.format(username, follow)
    cursor.execute(query)
    cursor2 = db.get_db().cursor()
    query2 = 'select * from FollowerRelationship where A="{}" and B="{}"'.format(username, follow)
    cursor2.execute(query2)
    db.get_db().commit()
    column_headers = [x[0] for x in cursor2.description]
    json_data = []
    theData = cursor2.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


# Unfollows a user
@josie.route('/unfollow', methods=['DELETE'])
def unfollow_user():
    the_data = request.json
    current_app.logger.info(the_data)
    username = the_data['username']
    unfollow = the_data['unfollow']
    cursor = db.get_db().cursor()
    query = 'delete from FollowerRelationship where A="{}" and B="{}"'.format(username, unfollow)
    cursor.execute(query)
    cursor2 = db.get_db().cursor()
    query2 = 'select count(*) from FollowerRelationship where A="{}" and B="{}"'.format(username, unfollow)
    cursor2.execute(query2)
    db.get_db().commit()
    column_headers = [x[0] for x in cursor2.description]
    json_data = []
    theData = cursor2.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Get all accounts that liked a given post from the database
@josie.route('/likes', methods=['GET'])
def get_likes():
    the_data = request.json
    current_app.logger.info(the_data)
    post_id = the_data['post_id']
    cursor = db.get_db().cursor()
    query = 'select liker from Likes where post_id={}'.format(post_id)
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)


# Adds an account to the like table of a given post
@josie.route('/likes', methods=['POST'])
def add_like():
    the_data = request.json
    current_app.logger.info(the_data)
    post_id = the_data['post_id']
    liker = the_data['liker']
    cursor = db.get_db().cursor()
    query = 'insert into Likes(liker, post_id) values("{}", {})'.format(liker, post_id)
    cursor.execute(query)
    cursor2 = db.get_db().cursor()
    query2 = 'select * from Likes where liker="{}" and post_id="{}"'.format(liker, post_id)
    cursor2.execute(query2)
    db.get_db().commit()
    column_headers = [x[0] for x in cursor2.description]
    json_data = []
    theData = cursor2.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Removes an account to the like table of a given post
@josie.route('/likes', methods=['DELETE'])
def delete_like():
    the_data = request.json
    current_app.logger.info(the_data)
    postID = the_data['post_id']
    liker = the_data['liker']
    cursor = db.get_db().cursor()
    query = 'delete from Likes where post_id={} and liker="{}"'.format(postID, liker)
    cursor.execute(query)
    cursor2 = db.get_db().cursor()
    query2 = 'select count(*) from Likes where liker="{}" and post_id={}'.format(liker, postID)
    cursor2.execute(query2)
    db.get_db().commit()
    column_headers = [x[0] for x in cursor2.description]
    json_data = []
    theData = cursor2.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Gets all the comments and related details for a given post
@josie.route('/comments', methods=['GET'])
def get_comments():
    the_data = request.json
    current_app.logger.info(the_data)
    postID = the_data['post_id']
    cursor = db.get_db().cursor()
    query = 'select * from Comments where post_id={}'.format(postID)
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))
    
    return jsonify(json_data)

# Adds a comment to a given post 
@josie.route('/comments', methods=['POST'])
def add_comments():
    the_data = request.json
    current_app.logger.info(the_data)
    commenter = the_data['commenter']
    post_id = the_data['post_id']
    content = the_data['content']
    cursor = db.get_db().cursor()
    query = '''
    insert into Comments(commenter, post_id, content)
    values("{}", "{}", "{}")
    '''.format(commenter, post_id, content)
    
    cursor = db.get_db().cursor()
    cursor.execute(query)

    query2 = 'select * from Comments where post_id="{}"'.format(post_id)
    cursor2 = db.get_db().cursor()
    cursor2.execute(query2)
    db.get_db().commit()

    column_headers = [x[0] for x in cursor2.description]
    json_data = []
    theData = cursor2.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Deletes a comment from a given post 
@josie.route('/comments', methods=['DELETE'])
def delete_comments():
    the_data = request.json
    current_app.logger.info(the_data)
    comment_id = the_data['comment_id']
    cursor = db.get_db().cursor()
    query = '''
    delete from Comments where comment_id={}
    '''.format(comment_id)
    cursor.execute(query)
    cursor2 = db.get_db().cursor()
    query2 = 'select count(*) from Comments where comment_id={}'.format(comment_id)
    cursor2.execute(query2)
    db.get_db().commit()
    column_headers = [x[0] for x in cursor2.description]
    json_data = []
    theData = cursor2.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Get the serving size of a recipe and scale the recipe
@josie.route('/recipeServingSize', methods=['GET'])
def get_adjusted_recipe():
    the_data = request.json
    current_app.logger.info(the_data)
    recipe_id = the_data['recipe_id']
    serving_size = the_data['serving_size']
    cursor = db.get_db().cursor()
    query = '''
    select r.recipe_id, r.recipe_name, r.steps, r.recipe_time, r.skill_level_id,
    r.serving_size AS original_serving_size, r.calories, r.cuisine_id,
    i.ingredient_name, i.amount * {} / r.serving_size AS adjusted_amount, i.unit
    from Recipes r
    join Ingredients i on r.recipe_id = i.recipe_id
    where r.recipe_id = {}
    '''.format(serving_size, recipe_id)
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)

# Get all posts route
@josie.route('/posts', methods=['GET'])
def get_posts():
    cursor = db.get_db().cursor()
    query = '''
    SELECT *
    FROM Posts
    '''
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Add a post 
@josie.route('/posts', methods=['POST'])
def add_post():
    the_data = request.json
    current_app.logger.info(the_data)
    poster = the_data['poster']
    caption = the_data['caption']
    cursor = db.get_db().cursor()
    query = '''
    insert into Posts (poster, caption)
    values ("{}", "{}")
    '''.format(poster, caption)
    cursor.execute(query)

    post_id = cursor.lastrowid
    recipe_name = the_data['recipe_name']
    steps = the_data['steps']
    recipe_time = the_data['recipe_time']
    skill_level_id = the_data['skill_level_id']
    serving_size = the_data['serving_size']
    calories = the_data['calories']
    cuisine_id = the_data['cuisine_id']
    query2 = '''
    insert into Recipes
    values ({}, "{}", "{}", {}, {}, {}, {}, {})
    '''.format(post_id, recipe_name, steps, recipe_time,
               skill_level_id, serving_size, calories, cuisine_id)
    cursor2 = db.get_db().cursor()
    cursor2.execute(query2)

    query3 = 'select * from Posts where post_id={}'.format(post_id)
    cursor3 = db.get_db().cursor()
    cursor3.execute(query3)
    db.get_db().commit()
    column_headers = [x[0] for x in cursor3.description]
    json_data = []
    theData = cursor3.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))
    return jsonify(json_data)
