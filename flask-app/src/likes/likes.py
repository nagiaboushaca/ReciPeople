from flask import Blueprint, request, jsonify, make_response
import json
from src import db


likes = Blueprint('likes', __name__)

# Get all accounts that liked a given post from the database
@likes.route('/likes/{postID}', methods=['GET'])
def get_likes(postID):
    cursor = db.get_db().cursor()
    query = 'select liker from likes where post_id=' + postID
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))


# Adds an account to the like table of a given post
@likes.route('/likes/{postID}{liker}', methods=['POST'])
def add_like(postID, liker):
    cursor = db.get_db().cursor()
    query = 'insert into likes(' + liker + ') values(' + liker + ')where post_id =' + postID
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

# Removes an account to the like table of a given post
@likes.route('/likes/{postID}{liker}', methods=['DELETE'])
def delete_like(postID, liker):
    cursor = db.get_db().cursor()
    query = 'delete from likes where post_id =' + postID + 'and liker = ' + liker

    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))