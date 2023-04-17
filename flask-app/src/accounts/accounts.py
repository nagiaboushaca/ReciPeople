from flask import Blueprint, request, jsonify, make_response
import json
from src import db


accounts = Blueprint('accounts', __name__)

# Get all accounts from the database
@accounts.route('/accounts', methods=['GET'])
def get_accounts():
    cursor = db.get_db().cursor()
    query = '''
    SELECT username, phone_number, email_address, bio, last_name, first_name, birthdate, pword
    FROM accounts
    '''
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Add a new account to the database
@accounts.route('/addAccount', methods=['POST'])
def post_accounts():
    cursor = db.get_db().cursor()
    query = ''
    cursor.execute(query)

# Gets all account data for a given username
@accounts.route('/getByUsername')
def get_accounts_by_username():
    cursor = db.get_db().cursor()
    query = ''
    cursor.execute(query)

# Deletes the account of a given username
@accounts.route('/deleteAccount', methods=['DELETE'])
def delete_accounts_by_username():
    cursor = db.get_db().cursor()

# Gets the password of the given account
@accounts.route('/getPassword')
def get_accounts_password():
    cursor = db.get_db().cursor()
    query = ''
    cursor.execute(query)

# Updates the password of the given account
@accounts.route('/updatePassword')
def update_accounts_password():
    cursor = db.get_db().cursor()
    query = ''
    cursor.execute(query)

# Gets the bio of the given account
@accounts.route('/getBio')
def get_accounts_bio():
    cursor = db.get_db().cursor()
    query = ''
    cursor.execute(query)

# Updates the bio of the given account
@accounts.route('/updateBio')
def update_accounts_bio():
    cursor = db.get_db().cursor()
    query = ''
    cursor.execute(query)

# Sets the bio of the given account to an empty string
@accounts.route('/setBioEmpty')
def delete_accounts_bio():
    cursor = db.get_db().cursor()

