from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


accounts = Blueprint('accounts', __name__)

# Get all accounts from the database
@accounts.route('/accounts', methods=['GET'])
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
@accounts.route('/accounts', methods=['POST'])
def new_account():

    the_data = request.json
    current_app.logger.info(the_data)

    username = the_data['username']
    password = the_data['pword']
    first_name = the_data['first_name']
    last_name = the_data['last_name']
    email = the_data['email']
    phone = the_data['phone_number']
    birthdate = the_data['birthdate']
    bio = the_data['bio']

    query = '''
    insert into Accounts Values("{}", "{}", "{}", "{}", "{}", "{}", "{}", {})
    '''.format(username, password, birthdate, first_name, last_name, bio, email, phone)
    
    # query = 'INSERT into Accounts VALUES ("'
    # query += username + '", "'
    # query += password + '", "'
    # query += str(birthdate) + '", "'
    # query += first_name + '", "'
    # query += last_name + '", "'
    # query += bio + '", "'
    # query += email + '", "'
    # query += str(phone) + ')'
    current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()


# Gets all account data for a given username
@accounts.route('/accounts/<username>', methods=['GET'])
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
@accounts.route('/accounts/{username}', methods=['DELETE'])
def delete_account(username):
    cursor = db.get_db().cursor()
    query = 'delete * from Accounts where username ="{}"'.format(username)
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Gets the password of the given account
@accounts.route('/accounts/{pword}', methods=['GET'])
def get_account_pword(username):
    cursor = db.get_db().cursor()
    query = 'select pword from Accounts where username ="{}"'.format(username)
    cursor.execute(query)

# Updates the password of the given account
@accounts.route('/accounts/{pword}', methods=['POST'])
def update_account_pword(username, pword):
    cursor = db.get_db().cursor()
    query = 'update Accounts set pword ="{}" where username ="{}"'.format(pword, username)
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Gets the bio of the given account
@accounts.route('/accounts/{bio}', methods=['GET'])
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
@accounts.route('/accounts/{bio}', methods=['POST'])
def update_account_bio(bio, username):
    cursor = db.get_db().cursor()
    query = 'update Accounts set bio ="{}" where username ="{}"'.format(bio, username)
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Sets the bio of the given account to an empty string
@accounts.route('/accounts/{bio}', methods=['DELTE'])
def delete_accounts_bio(username):
    cursor = db.get_db().cursor()
    query = 'update Accounts set bio = "" where username ="{}"'.format(username)
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

