import pandas as pd


class DataCleaning:
    @staticmethod
    def clean_csv_data(data):
        # Remove any rows with missing values
        data = data.dropna()
        
        # Convert string columns to numeric where applicable
        data['sales'] = pd.to_numeric(data['sales'], errors='coerce')
        data['quantity'] = pd.to_numeric(data['quantity'], errors='coerce')
        
        return data
    
    @staticmethod
    def clean_api_data(data):
        # Remove any rows with missing values
        data = [item for item in data if all(item.values())]
        
        # Convert string values to numeric where applicable
        for item in data:
            item['sales'] = float(item['sales'])
            item['quantity'] = int(item['quantity'])
        
        return data
    
    @staticmethod
    def clean_s3_data(data):
        # Convert byte data to string
        data = data.decode('utf-8')
        
        # Remove any rows with missing values
        rows = [row for row in data.split('\n') if row.strip()]
        
        # Split each row into columns and convert string columns to numeric where applicable
        cleaned_data = []
        for row in rows:
            columns = row.split(',')
            if len(columns) == 3:
                try:
                    sales = float(columns[0])
                    quantity = int(columns[1])
                    date = columns[2]
                    cleaned_data.append({'sales': sales, 'quantity': quantity, 'date': date})
                except ValueError:
                    pass
        
        return cleaned_data
