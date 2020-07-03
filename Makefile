.PHONY: all $(MAKECMDGOALS)

build:
	docker build -t calculator-app .

run:
	docker run --rm --volume `pwd`:/opt/calc --env PYTHONPATH=/opt/calc -w /opt/calc calculator-app:latest python -B app/calc.py

server:
	docker run --rm --volume `pwd`:/opt/calc --name apiserver --network calc --network-alias apiserver --env PYTHONPATH=/opt/calc --env FLASK_APP=app/api.py -p 5000:5000 -w /opt/calc calculator-app:latest flask run --host=0.0.0.0

unit:
	docker run --rm --volume `pwd`:/opt/calc --env PYTHONPATH=/opt/calc -w /opt/calc calculator-app:latest pytest --cov --cov-report=xml:cov_result.xml --cov-report=html:cov_result --junit-xml=unit_result.xml -m unit || true
	docker run --rm --volume `pwd`:/opt/calc --env PYTHONPATH=/opt/calc -w /opt/calc calculator-app:latest junit2html unit_result.xml unit_result.html

api:
	docker network create calc
	docker run -d --rm --volume `pwd`:/opt/calc --network calc --env PYTHONPATH=/opt/calc --name apiserver --env FLASK_APP=app/api.py -p 5000:5000 -w /opt/calc calculator-app:latest flask run --host=0.0.0.0
	docker run --rm --volume `pwd`:/opt/calc --network calc --env PYTHONPATH=/opt/calc --env BASE_URL=http://apiserver:5000/ -w /opt/calc calculator-app:latest pytest --junit-xml=api_result.xml -m api  || true
	docker run --rm --volume `pwd`:/opt/calc --env PYTHONPATH=/opt/calc -w /opt/calc calculator-app:latest junit2html api_result.xml api_result.html
	docker rm --force apiserver
	docker network rm calc

interactive:

	docker run -ti --rm --volume `pwd`:/opt/calc --env PYTHONPATH=/opt/calc  --network calc -w /opt/calc calculator-app:latest bash