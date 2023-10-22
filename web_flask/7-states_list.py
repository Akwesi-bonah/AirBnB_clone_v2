#!/usr/bin/python3

""" This script starts a Flask web application.
     Routes: / - display “Hello HBNB!”
     Port 5000
     listening on 0.0.0.0
 """

from flask import Flask, render_template
from models import storage
app = Flask(__name__)


@app.teardown_appcontext
def teardown(self):
    """ Closes the storage """
    storage.close()


@app.route('/states_list', strict_slashes=False)
def states_list():
    """ Display a HTML page: (inside the tag BODY) """
    states = storage.all('State')
    return render_template('7-states_list.html', states=states)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
