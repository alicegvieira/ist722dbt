with orders as (
    select * from {{ source('northwind', 'Orders') }}
),
order_details as (
    select * from {{ source('northwind', 'Order_Details') }}
)

select
    od.orderid,
    {{ dbt_utils.generate_surrogate_key(['o.customerid']) }} as customerkey,
    {{ dbt_utils.generate_surrogate_key(['o.employeeid']) }} as employeekey,
    {{ dbt_utils.generate_surrogate_key(['p.productid']) }} as productkey,
    o.orderdate,
    od.quantity,
    od.unitprice * od.quantity as extendedpriceamount,
    od.unitprice * od.quantity * od.discount as discountamount,
    od.unitprice * od.quantity * (1 - od.discount) as soldamount
from order_details od
join orders o on o.orderid = od.orderid
join {{ ref('dim_product') }} p on p.productid = od.productid