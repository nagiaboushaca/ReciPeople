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
    db = db.get_db()
    username = "test"
    pword = "pword"
    birthdate = "2001/09/04"
    first_name = "first"
    last_name = "last"
    bio = "not null"
    email = "test@123.com"
    phone = 9414457506

    # the_data = request.json
    # current_app.logger.info(the_data)

    query = '''
    insert into Accounts values("{}", "{}", STR_TO_DATE("{}", '%Y/%m/%d'), "{}", "{}", "{}", "{}", {})
    '''.format(username, pword, birthdate, first_name, last_name, bio, email, phone)
    
    db.execute(query)
    db.commit()
    return query


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
@josie.route('/accounts/{username}', methods=['DELETE'])
def delete_account(username):
    cursor = db.get_db().cursor()
    query = 'delete * from Accounts where username ="{}"'.format(username)
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
@josie.route('/accountBio/<username>/<bio>}', methods=['POST'])
def update_account_bio(bio, username):
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
    cursor.execute(query)
    db.get_db().commit()
    return query

# Follows a user 
@josie.route('/follow/<username>', methods=['POST'])
def follow_user(username):
    cursor = db.get_db().cursor()
    query = 'update ... where username ="{}"'.format(username)
    cursor.execute(query)
    cursor.execute(query)
    db.get_db().commit()
    return query


# Unfollows a user
# Follows a user 
@josie.route('/unfollow/<username>', methods=['POST'])
def follow_user(username):
    cursor = db.get_db().cursor()
    query = 'update ... where username ="{}"'.format(username)
    cursor.execute(query)
    cursor.execute(query)
    db.get_db().commit()
    return query