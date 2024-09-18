from flask import Blueprint, request, jsonify
from flask_login import login_user, logout_user, login_required
from werkzeug.security import check_password_hash
from models.user import User

bp = Blueprint('auth', __name__)

@bp.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    user = User.query.filter_by(username=data['username']).first()
    if user and check_password_hash(user.password_hash, data['password']):
        login_user(user)
        return jsonify({'message': 'Logged in successfully.', 'role': user.role}), 200
    return jsonify({'message': 'Invalid username or password.'}), 401

@bp.route('/logout')
@login_required
def logout():
    logout_user()
    return jsonify({'message': 'Logged out successfully.'}), 200
