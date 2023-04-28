import csv
import requests
import boto3


class DataExtractor:
    def __init__(self, api_key=None, bucket_name=None):
        self.api_key = api_key
        self.bucket_name = bucket_name
        self.s3 = boto3.client('s3')

    def extract_csv_data(self, file_path):
        data = []
        with open(file_path, 'r') as csv_file:
            csv_reader = csv.DictReader(csv_file)
            for row in csv_reader:
                data.append(row)
        return data

    def extract_api_data(self, url):
        headers = {'Authorization': f'Bearer {self.api_key}'} if self.api_key else {}
        response = requests.get(url, headers=headers)
        return response.json()

    def extract_s3_data(self, key):
        response = self.s3.get_object(Bucket=self.bucket_name, Key=key)
        content = response['Body'].read().decode('utf-8')
        return content.splitlines()
