from flask import Blueprint, request, jsonify, make_response
import json
from src import db


equipment = Blueprint('equipment', __name__)