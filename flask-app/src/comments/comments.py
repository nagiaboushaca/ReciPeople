from flask import Blueprint, request, jsonify, make_response
import json
from src import db


comments = Blueprint('comments', __name__)