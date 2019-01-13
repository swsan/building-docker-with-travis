FROM python:3.4

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ONBUILD COPY requirements.txt /usr/src/app/
ONBUILD RUN pip install --no-cache-dir -r requirements.txt

ONBUILD COPY helloworld /usr/src/app

RUN apt-get update && apt-get install -y \
		gettext \
		mysql-client \
		postgresql-client libpq-dev \
		sqlite3 \
	--no-install-recommends && rm -rf /var/lib/apt/lists/*

EXPOSE 8000
WORKDIR /usr/src/app/helloworld
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

