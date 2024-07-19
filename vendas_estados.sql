
-- Primeira pergunta:
-- Quais são os estados com maior volume de vendas? considerando vendas efetuadas
-- Quantos vendedores existem em cada estado?

select  
        t1.seller_state,
        count(distinct t1.seller_id) as total_vendedores,
        round(sum(t2.price),2) as total_vendas    

from tb_sellers as t1

left join tb_order_items as t2
on t2.seller_id = t1.seller_id

left join tb_orders as t3
on t2.order_id = t3.order_id

where t3.order_status = 'delivered'

group by seller_state

order by total_vendas DESC
