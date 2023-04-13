from flask import Blueprint, request, jsonify, make_response
import json
from src import db


posts = Blueprint('posts', __name__)