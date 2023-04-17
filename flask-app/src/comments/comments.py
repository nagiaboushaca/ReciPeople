from flask import Blueprint, request, jsonify, make_response
import json
from src import db


comments = Blueprint('comments', __name__)

# Gets all the comments and related details for a given post
@comments.route('/comments', methods=['GET'])
def get_comments():
    cursor = db.get_db().cursor()
    query = '''
    '''
    cursor.execute(query)

# Adds a comment to a given post 
@comments.route('/comments', methods=['POST'])
def add_comments():
    cursor = db.get_db().cursor()
    query = '''
    '''
    cursor.execute(query)

# Deletes a comment from a given post 
@comments.route('/comments', methods=['DELETE'])
def delete_comments():
    cursor = db.get_db().cursor()
    query = '''
    '''
    cursor.execute(query)