from flask import Blueprint, request, jsonify, make_response
import json
from src import db


posts = Blueprint('posts', __name__)

# Get all posts for a given user from the database
@posts.route('/posts', methods=['GET'])
def get_posts():
    cursor = db.get_db().cursor()
    query = '''
    '''
    cursor.execute(query)

# Creates a new post for a given user
@posts.route('/posts', methods=['POST'])
def create_post():
    cursor = db.get_db().cursor()
    query = '''
    '''
    cursor.execute(query)

# Deletes a post for a given user
@posts.route('/posts', methods=['DELETE'])
def delete_post():
    cursor = db.get_db().cursor()
    query = '''
    '''
    cursor.execute(query)