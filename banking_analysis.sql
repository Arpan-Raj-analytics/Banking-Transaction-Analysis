CREATE TABLE banking_transactions (
    transaction_id BIGINT,
    customer_id BIGINT,
    transaction_date TIMESTAMP,
    account_type VARCHAR(50),
    transaction_type VARCHAR(50),
    transaction_amount NUMERIC(12,2),
    transaction_direction VARCHAR(20),
    merchant_category VARCHAR(100),
    transaction_status VARCHAR(50),
    channel VARCHAR(50),
    is_fraud INTEGER
);

select * from banking_transactions;


ALTER TABLE banking_transactions
    ALTER COLUMN transaction_id TYPE VARCHAR(50),
    ALTER COLUMN customer_id TYPE VARCHAR(50);

select * from banking_transactions;

select count (*) as total_transactions
from banking_transactions;

--1. how many transaction were successful and how many failed.

select transaction_status,
count(*) as total_transaction
from banking_transactions 
group by transaction_status
order by total_transaction desc;


--2.which transaction type has highest activity

select
transaction_type,
count(*) as total_transactions 
from banking_transactions
group by transaction_type
order by total_transactions desc ;

--3.which transaction channel is most popular.

select channel,
count(*) as total_channel
from banking_transactions
group by channel
order by total_channel desc;

--4.what is the average transaction amount for each transaction type.

SELECT
    transaction_type,
    COUNT(*) AS total_transactions,
    AVG(transaction_amount) as average_transaction_amount
FROM banking_transactions
GROUP BY transaction_type
ORDER BY average_transaction_amount DESC;

--5. which transaction type have the most failed transaction.

select transaction_type,
count(*) as failed_transactions
from banking_transactions
where transaction_status = 'Failed'
group by transaction_type
order by failed_transactions desc;

--6.which account type have most transactions..

SELECT
    account_type,
    COUNT(*) AS total_transactions
FROM banking_transactions
GROUP BY account_type
ORDER BY total_transactions DESC;

--7.How many transactions occur each day

SELECT
    DATE(transaction_date) AS transaction_day,
    COUNT(*) AS total_transactions
FROM banking_transactions
GROUP BY DATE(transaction_date)
ORDER BY transaction_day;

--8.Which merchant categories have the most transactions.

SELECT
    merchant_category,
    COUNT(*) AS total_transactions
FROM banking_transactions
GROUP BY merchant_category
ORDER BY total_transactions DESC;

--9.Which transaction types have the highest total transaction value.

SELECT
    transaction_type,
    SUM(transaction_amount) AS total_transaction_value
FROM banking_transactions
GROUP BY transaction_type
ORDER BY total_transaction_value DESC;


--10.Which hours have the most transactions..

SELECT
    EXTRACT(HOUR FROM transaction_date) AS transaction_hour,
    COUNT(*) AS total_transactions
FROM banking_transactions
GROUP BY EXTRACT(HOUR FROM transaction_date)
ORDER BY total_transactions DESC;


--11.Which transaction types have the highest minimum transaction amount.

SELECT
    transaction_type,
    MIN(transaction_amount) AS minimum_amount
FROM banking_transactions
GROUP BY transaction_type
ORDER BY minimum_amount DESC;


--12..Which transaction_types have the most reversed transactions.


SELECT
    transaction_type,
    COUNT(*) AS reversed_transactions
FROM banking_transactions
WHERE transaction_status = 'Reversed'
GROUP BY transaction_type
ORDER BY reversed_transactions DESC;

--13.identify the fraud rate.

SELECT
    is_fraud,
    COUNT(*) AS total_transactions
FROM banking_transactions
GROUP BY is_fraud
ORDER BY total_transactions DESC;

--14. which transaction typee  have most fraud accurs..

select transaction_type,
count (*) as fraud_transactions
from banking_transactions
where is_fraud = 1
group by transaction_type 
order by fraud_transactions desc;



