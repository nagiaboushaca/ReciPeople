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
@accounts.route('/accounts', methods=['POST'])
def post_accounts():
    cursor = db.get_db().cursor()
    query = ''
    cursor.execute(query)

# Gets all account data for a given username
@accounts.route('/accounts/{username}', methods=['POST'])
def get_account(username):
    cursor = db.get_db().cursor()
    query = ''
    cursor.execute(query)

# Deletes the account of a given username
@accounts.route('/accounts/{username}', methods=['DELETE'])
def delete_account(username):
    cursor = db.get_db().cursor()

# Gets the password of the given account
@accounts.route('/accounts/{pword}', methods=['GET'])
def get_account_pword():
    cursor = db.get_db().cursor()
    query = ''
    cursor.execute(query)

# Updates the password of the given account
@accounts.route('/accounts/{pword}', methods=['POST'])
def update_account_pword():
    cursor = db.get_db().cursor()
    query = ''
    cursor.execute(query)

# Gets the bio of the given account
@accounts.route('/accounts/{bio}', methods=['GET'])
def get_account_bio():
    cursor = db.get_db().cursor()
    query = ''
    cursor.execute(query)

# Updates the bio of the given account
@accounts.route('/accounts/{bio}', methods=['POST'])
def update_account_bio():
    cursor = db.get_db().cursor()
    query = ''
    cursor.execute(query)

# Sets the bio of the given account to an empty string
@accounts.route('/accounts/{bio}', methods=['DELTE'])
def delete_accounts_bio():
    cursor = db.get_db().cursor()

