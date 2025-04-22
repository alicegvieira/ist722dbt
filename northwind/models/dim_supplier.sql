with stg_suppliers as (
    select * from {{ source('northwind', 'Suppliers') }}
)

select
    {{ dbt_utils.generate_surrogate_key(['supplierid']) }} as supplierkey,
    supplierid,
    companyname as suppliercompanyname,
    contactname as suppliercontactname,
    contacttitle as suppliercontacttitle,
    address as supplieraddress,
    city as suppliercity,
    region as supplierregion,
    postalcode as supplierpostalcode,
    country as suppliercountry,
    phone as supplierphone,
    fax as supplierfax,
    homepage as supplierhomepage
from stg_suppliers