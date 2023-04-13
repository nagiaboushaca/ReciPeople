from flask import Blueprint, request, jsonify, make_response
import json
from src import db


ingredients = Blueprint('ingredients', __name__)