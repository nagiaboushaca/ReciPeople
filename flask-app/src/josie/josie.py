from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


josie = Blueprint('josie', __name__)

# Get all accounts from the database
@josie.route('/accounts', methods=['GET'])
def get_accounts():
    cursor = db.get_db().cursor()
    query = '''
    SELECT username, phone_number, email_address, bio, last_name, first_name, birthdate, pword
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
    # db = db.get_db()
    # username = "test"
    # pword = "pword"
    # birthdate = "2001/09/04"
    # first_name = "first"
    # last_name = "last"
    # bio = "not null"
    # email = "test@123.com"
    # phone = 9414457506

    # # the_data = request.json
    # # current_app.logger.info(the_data)

    # query = '''
    # insert into Accounts values("{}", "{}", STR_TO_DATE("{}", '%Y/%m/%d'), "{}", "{}", "{}", "{}", {})
    # '''.format(username, pword, birthdate, first_name, last_name, bio, email, phone)
    
    # db.execute(query)
    # db.commit()
    # return query
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
    '''.format(username, password, first_name, last_name, bio, email, phone)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


# Gets all account data for a given username
@josie.route('/accounts/<username>', methods=['GET'])
def get_account(username):
    cursor = db.get_db().cursor()
    query = 'select * from Accounts where username = "{}"'.format(username)
    #return jsonify(query)
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


# Deletes the account of a given username
@josie.route('/accounts/<username>', methods=['DELETE'])
def delete_account(username):
    cursor = db.get_db().cursor()
    query = 'delete from Accounts where username ="{}"'.format(username)
    cursor.execute(query)
    db.get_db().commit()
    return query

# Gets the password of the given account
@josie.route('/accountPword/<username>', methods=['GET'])
def get_account_pword(username):
    cursor = db.get_db().cursor()
    query = 'select pword from Accounts where username ="{}"'.format(username)
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Updates the password of the given account
@josie.route('/accountPword/<username>/<pword>', methods=['POST'])
def update_account_pword(username, pword):
    cursor = db.get_db().cursor()
    query = 'update Accounts set pword ="{}" where username ="{}"'.format(pword, username)
    cursor.execute(query)
    db.get_db().commit()
    return query

# Gets the bio of the given account
@josie.route('/accountBio/<username>', methods=['GET'])
def get_account_bio(username):
    cursor = db.get_db().cursor()
    query = 'select bio from Accounts where username = "{}"'.format(username)
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Updates the bio of the given account
@josie.route('/accountBio/<username>/<bio>', methods=['POST'])
def update_account_bio(username, bio):
    cursor = db.get_db().cursor()
    query = 'update Accounts set bio ="{}" where username ="{}"'.format(bio, username)
    cursor.execute(query)
    db.get_db().commit()
    return query

# Sets the bio of the given account to an empty string
@josie.route('/accountBioEmpty/<username>', methods=['POST'])
def delete_accounts_bio(username):
    cursor = db.get_db().cursor()
    query = 'update Accounts set bio = "" where username ="{}"'.format(username)
    cursor.execute(query)
    db.get_db().commit()
    return query

# Follows a user 
@josie.route('/follow/<username>/<follow>', methods=['POST'])
def follow_user(username, follow):
    cursor = db.get_db().cursor()
    query = 'insert into FollowerRelationship(A, B) values("{}", "{}")'.format(username, follow)
    cursor.execute(query)
    db.get_db().commit()
    return query


# Unfollows a user
@josie.route('/unfollow/<username>/<unfollow>', methods=['POST'])
def unfollow_user(username, unfollow):
    cursor = db.get_db().cursor()
    query = 'delete * from FollowerRelationship where A ="{}" and B ="{}"'.format(username, unfollow)
    cursor.execute(query)
    db.get_db().commit()
    return query

# Get all accounts that liked a given post from the database
@josie.route('/likes/<postID>', methods=['GET'])
def get_likes(postID):
    cursor = db.get_db().cursor()
    query = 'select liker from Likes where post_id={}'.format(postID)
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))


# Adds an account to the like table of a given post
@josie.route('/likes/<postID>/<liker>', methods=['POST'])
def add_like(postID, liker):
    cursor = db.get_db().cursor()
    query = 'insert into Likes(liker) values("{}")where post_id ={}'.format(liker, postID)
    cursor.execute(query)
    db.get_db().commit()
    return query

# Removes an account to the like table of a given post
@josie.route('/likes/<postID>/<liker>', methods=['DELETE'])
def delete_like(postID, liker):
    cursor = db.get_db().cursor()
    query = 'delete from Likes where post_id ={} and liker = "{}"'.format(postID, liker)
    cursor.execute(query)
    db.get_db().commit()
    return query

# Gets all the comments and related details for a given post
@josie.route('/comments/<postID>', methods=['GET'])
def get_comments(postID):
    cursor = db.get_db().cursor()
    query = 'select * from Comments where post_id ={}'.format(postID)
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

# Adds a comment to a given post 
@josie.route('/comments', methods=['POST'])
def add_comments():
    cursor = db.get_db().cursor()
    query = '''
    '''
    cursor.execute(query)
    db.get_db().commit()
    return query

# Deletes a comment from a given post 
@josie.route('/comments/<comment_id>/<post_id>', methods=['DELETE'])
def delete_comments(comment_id, post_id):
    cursor = db.get_db().cursor()
    query = '''
    delete from Comments where comment_id ={} and post_id ={}
    '''.format(comment_id, post_id)
    cursor.execute(query)
    db.get_db().commit()
    return query

# Get the serving size of a recipe and scale the recipe
@josie.route('/recipes/<recipe_id>/<serving_size>', methods=['GET'])
def get_adjusted_recipe(recipe_id, serving_size):
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