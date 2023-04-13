from flask import Blueprint, request, jsonify, make_response
import json
from src import db


savedRecipes = Blueprint('savedRecipes', __name__)