from flask import Blueprint, request, jsonify, make_response
import json
from src import db


cuisine = Blueprint('cuisine', __name__)