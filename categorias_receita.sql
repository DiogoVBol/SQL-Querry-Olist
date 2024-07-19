-- Qual a categoria de produto que mais vende em receita.

with tb_data as (
    select  t1.product_category_name,
            round(sum(t2.price),2) as total_receita,
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
                end as 'categorias'


    from tb_products as t1

    left join tb_order_items as t2
    on t1.product_id = t2.product_id

    left join tb_orders as t3
    on t3.order_id = t2.order_id

    where t3.order_status = 'delivered'

    group by t1.product_category_name
)

select  product_category_name,	
        sum(total_receita) as receita_total

from tb_data

group by categorias

order by receita_total desc