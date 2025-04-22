with stg_products as (
    select * from {{ source('northwind', 'Products') }}
),
stg_categories as (
    select * from {{ source('northwind', 'Categories') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['productid']) }} as productkey,
    {{ dbt_utils.generate_surrogate_key(['supplierid']) }} as supplierkey,
    p.productid,
    p.productname,
    c.categoryname,
    c.description as categorydescription
from stg_products p
left join stg_categories c on p.categoryid = c.categoryid