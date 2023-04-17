from flask import Blueprint, request, jsonify, make_response
import json
from src import db


likes = Blueprint('likes', __name__)

# Get all accounts that liked a given post from the database
@likes.route('/likes', methods=['GET'])
def get_likes():
    cursor = db.get_db().cursor()
    query = '''
    '''
    cursor.execute(query)

# Adds an account to the like table of a given post
@likes.route('/likes', methods=['POST'])
def add_like():
    cursor = db.get_db().cursor()
    query = '''
    '''
    cursor.execute(query)

# Removes an account to the like table of a given post
@likes.route('/likes', methods=['DELETE'])
def delete_like():
    cursor = db.get_db().cursor()
    query = '''
    '''
    cursor.execute(query)