FROM python:3
ENV FLASK /app
COPY . /app
WORKDIR /app 
EXPOSE 5000
RUN pip install -r requirements.txt
ENTRYPOINT ['python']
CMD ['app.py']
