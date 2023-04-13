from flask import Blueprint, request, jsonify, make_response
import json
from src import db


recipes = Blueprint('recipes', __name__)