FROM python:3.7

WORKDIR /rand_act

COPY requirements.txt /rand_act/requirements.txt
RUN pip3 install -r requirements.txt

COPY . ./

EXPOSE 5000
CMD ["python", "main_service.py"]