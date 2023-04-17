from flask import Blueprint, request, jsonify, make_response
import json
from src import db


followers = Blueprint('followers', __name__)

# Follows a given user
@followers.route('/FollowerRelationship', methods=['POST'])
def follow_user():
    cursor = db.get_db().cursor()
    query = '''
    '''
    cursor.execute(query)

# Unfollows a given user
@followers.route('/FollowerRelationship', methods=['DELETE'])
def unfollow_user():
    cursor = db.get_db().cursor()
    query = '''
    '''
    cursor.execute(query)