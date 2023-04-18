from flask import Blueprint, request, jsonify, make_response
import json
from src import db


likes = Blueprint('likes', __name__)

# Get all accounts that liked a given post from the database
@likes.route('/likes', methods=['GET'])
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
@likes.route('/likes', methods=['POST'])
def add_like(postID, liker):
    cursor = db.get_db().cursor()
    query = 'insert into Likes(liker) values("{}")where post_id ={}'.format(liker, postID)
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

# Removes an account to the like table of a given post
@likes.route('/likes', methods=['DELETE'])
def delete_like(postID, liker):
    cursor = db.get_db().cursor()
    query = 'delete from Likes where post_id ={} and liker = "{}"'.format(postID, liker)

    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))