
-- De qual estado são os principais clientes?
-- Qual a categoria de produto que eles mais compram?

with tb_data as (
    select  t1.customer_state,
            count(distinct t1.customer_id) as qtde_clientes
                
    from tb_customers as t1

    left join tb_orders as t2
    on t2.customer_id = t1.customer_id

    left join tb_order_items as t3
    on t2.order_id = t3.order_id

    left join tb_products as t4
    on t4.product_id = t3.product_id

    where t2.order_status = 'delivered'

    group by t1.customer_state
),
tb_customer_windown as (
    select  t1.customer_state,
            case when product_category_name like ('%alimentos%') then 'alimentos'
                when product_category_name like ('%artigos%') then 'artigos'
                when product_category_name like ('%artes%') then 'artes'
                when product_category_name like ('%casa%') then 'casa'
                when product_category_name like ('%construcao%') then 'construcao'
                when product_category_name like ('%eletrodomesticos%') then 'eletrodomesticos'
                when product_category_name like ('%fashion%') then 'fashion'
                when product_category_name like ('%livros%') then 'livros'
                when product_category_name like ('%moveis%') then 'moveis'
                when product_category_name like ('%beleza%') then 'beleza'
                when product_category_name like ('%esporte%') then 'esporte'
                else product_category_name
                end as 'categorias',
            row_number() over (partition by t1.customer_state order by COUNT(t3.order_item_id) desc) as order_quant
                    
    from tb_customers as t1

    left join tb_orders as t2
    on t2.customer_id = t1.customer_id

    left join tb_order_items as t3
    on t2.order_id = t3.order_id

    left join tb_products as t4
    on t4.product_id = t3.product_id

    where t2.order_status = 'delivered'

    group by t1.customer_state, t4.product_category_name
)

select  t5.customer_state,
        qtde_clientes,
        categorias as cat_maior_qtde_vendida
        

from tb_customer_windown as t5

left join tb_data as t6
on t5.customer_state = t6.customer_state

where order_quant = 1

order by qtde_clientes desc