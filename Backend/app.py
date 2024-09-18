from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager
from config import Config

app = Flask(__name__)
app.config.from_object(Config)

db = SQLAlchemy(app)
login_manager = LoginManager(app)
login_manager.login_view = 'auth.login'

from routes import auth, clerk, doctor, nurse, lab_technician, billing_clerk, patient

app.register_blueprint(auth.bp)
app.register_blueprint(clerk.bp)
app.register_blueprint(doctor.bp)
app.register_blueprint(nurse.bp)
app.register_blueprint(lab_technician.bp)
app.register_blueprint(billing_clerk.bp)
app.register_blueprint(patient.bp)

if __name__ == '__main__':
    app.run(debug=True)
