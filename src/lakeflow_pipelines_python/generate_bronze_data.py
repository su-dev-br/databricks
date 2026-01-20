import os
import sys
from faker import Faker
from pyspark.sql import SparkSession
from pyspark.sql.types import StructType, StructField, StringType, IntegerType, TimestampType
import datetime

def generate_fake_data(n=100):
    fake = Faker()
    data = []
    for i in range(n):
        data.append((
            fake.uuid4(),
            fake.name(),
            fake.email(),
            fake.address().replace('\n', ', '),
            fake.country(),
            fake.date_time_this_year()
        ))
    return data

def main():
    spark = SparkSession.builder.getOrCreate()
    
    # Get configuration from environment or bundle variables
    catalog = os.getenv("BUNDLE_VAR_CATALOG", "main")
    schema = os.getenv("BUNDLE_VAR_SCHEMA", "default")
    table_name = f"{catalog}.{schema}.bronze_customers"
    
    print(f"Generating data for {table_name}...")
    
    schema_definition = StructType([
        StructField("customer_id", StringType(), False),
        StructField("name", StringType(), True),
        StructField("email", StringType(), True),
        StructField("address", StringType(), True),
        StructField("country", StringType(), True),
        StructField("created_at", TimestampType(), True)
    ])
    
    fake_data = generate_fake_data(500)
    df = spark.createDataFrame(fake_data, schema=schema_definition)
    
    # Write to Bronze layer
    df.write.format("delta").mode("overwrite").saveAsTable(table_name)
    
    print(f"Successfully loaded 500 records into {table_name}")

if __name__ == "__main__":
    main()
