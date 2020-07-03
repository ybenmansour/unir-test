import http.client

from flask import Flask

from app import util
from app.calc import Calculator

CALCULATOR = Calculator()
api_application = Flask(__name__)
CONTENT_TYPE_PLAIN = {"Content-Type": "text/plain"}


@api_application.route("/")
def hello():
    return "Hello from The Calculator!\n"


@api_application.route("/calc/add/<op_1>/<op_2>", methods=["GET"])
def add(op_1, op_2):
    try:
        num_1, num_2 = util.convert_to_int(op_1), util.convert_to_int(op_2)
        return "{}".format(CALCULATOR.add(num_1, num_2))
    except TypeError as e:
        return (str(e), http.client.BAD_REQUEST, CONTENT_TYPE_PLAIN)

