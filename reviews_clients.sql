
-- reviews dos usuários por estado

select  round(avg(t1.review_score),2) as avg_review,
        t4.seller_state

from  tb_order_reviews as t1

left join tb_orders as t2
on t2.order_id = t1.order_id

left join tb_order_items as t3
on t3.order_id = t2.order_id

left join tb_sellers as t4
on t4.seller_id = t3.seller_id

where t2.order_status = 'delivered'

group by t4.seller_state

order by avg_review desc