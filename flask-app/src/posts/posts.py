from flask import Blueprint, request, jsonify, make_response
import json
from src import db


posts = Blueprint('posts', __name__)

# Get all posts for a given user from the database
@posts.route('/posts/{poster}', methods=['GET'])
def get_posts(poster):
    cursor = db.get_db().cursor()
    query = 'select * from posts where poster =' + poster
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# Creates a new post for a given user
@posts.route('/posts/{poster}', methods=['POST'])
def create_post(poster):
    cursor = db.get_db().cursor()
    query = ''
    cursor.execute(query)

# Deletes a post for a given user
@posts.route('/posts/{poster}', methods=['DELETE'])
def delete_post(poster):
    cursor = db.get_db().cursor()
    query = ''
    cursor.execute(query)