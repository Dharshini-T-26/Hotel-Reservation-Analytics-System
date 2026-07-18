SELECT
    c.customer_id,
    CONCAT(c.first_name,' ',c.last_name) AS customer_name,
    COUNT(r.reservation_id) AS total_reservations
FROM Customer c
JOIN Reservation r
ON c.customer_id = r.customer_id
GROUP BY c.customer_id
HAVING COUNT(r.reservation_id) > 3;

SELECT
    h.hotel_name,
    SUM(i.grand_total) AS total_revenue
FROM Hotel h
JOIN Room rm
ON h.hotel_id = rm.hotel_id
JOIN Reservation r
ON rm.room_id = r.room_id
JOIN Invoice i
ON r.reservation_id = i.reservation_id
GROUP BY h.hotel_name;

select
    c.customer_id,
    concat(c.first_name,' ',c.last_name) as customer_name,
    sum(i.grand_total) as total_spent
from customer c
join reservation r
on c.customer_id=r.customer_id
join invoice i
on r.reservation_id=i.reservation_id
group by c.customer_id
order by total_spent desc
limit 5;

select *
from room
where room_id not in
( select room_id
from reservation );

select
h.hotel_name,
count(distinct r.room_id) as occupied_rooms,
count(distinct rm.room_id) as total_rooms,
round(count(distinct r.room_id)*100/
count(distinct rm.room_id),2) as occupancy_percentage
from hotel h
join room rm
on h.hotel_id=rm.hotel_id
left join reservation r
on rm.room_id=r.room_id
group by h.hotel_name;

select *
from customer
where customer_id not in
( select customer_id
from feedback );

select
rt.type_name,
count(*) as bookings
from reservation r
join room rm
on r.room_id=rm.room_id
join roomtype rt
on rm.room_type_id=rt.room_type_id
group by rt.type_name
order by bookings desc
limit 1;

select
year(invoice_date) as year,
month(invoice_date) as month,
sum(grand_total) as revenue
from invoice
group by year(invoice_date),month(invoice_date)
order by year,month;

select
h.hotel_name,
round(avg(f.rating),2) as avg_rating
from hotel h
join room rm
on h.hotel_id=rm.hotel_id
join reservation r
on rm.room_id=r.room_id
join feedback f
on r.reservation_id=f.reservation_id
group by h.hotel_name;

select *
from employee e
where salary=
( select max(salary)
from employee
where department_id=e.department_id );

select distinct
c.customer_id,
c.first_name,
c.last_name
from customer c
join reservation r
on c.customer_id=r.customer_id
join room rm
on r.room_id=rm.room_id
join roomtype rt
on rm.room_type_id=rt.room_type_id
where rt.base_price=
( select max(base_price)
from roomtype );


select
sum(total_amount) as service_revenue
from reservationservice;

select
s.service_name,
sum(rs.quantity) as total_used
from service s
join reservationservice rs
on s.service_id=rs.service_id
group by s.service_name
order by total_used desc
limit 1;

select *
from reservation
where reservation_id not in
( select reservation_id
from payment );

select
avg(datediff(check_out,check_in)) as average_days
from reservation;

select
reservation_id,
datediff(check_out,check_in) as days
from reservation
order by days desc
limit 1;

select
h.hotel_name,
avg(i.grand_total) as average_invoice
from hotel h
join room rm
on h.hotel_id=rm.hotel_id
join reservation r
on rm.room_id=r.room_id
join invoice i
on r.reservation_id=i.reservation_id
group by h.hotel_name;

select
customer_id,
count(*) as visits
from reservation
group by customer_id
having count(*)>1;

select *
from invoice
order by grand_total desc
limit 10;

select
c.customer_id,
c.first_name,
sum(i.grand_total) as spent
from customer c
join reservation r
on c.customer_id=r.customer_id
join invoice i
on r.reservation_id=i.reservation_id
group by c.customer_id
having spent >
( select avg(grand_total)
from invoice );

select
employee_id,
count(*) as tasks
from housekeeping
group by employee_id
order by tasks desc;

select
room_id,
count(*) as cleaned_times
from housekeeping
group by room_id;

select *
from housekeeping
where cleaning_date=curdate()
and cleaning_status='pending';

select
h.hotel_name,
avg(f.rating) rating
from hotel h
join room rm
on h.hotel_id=rm.hotel_id
join reservation r
on rm.room_id=r.room_id
join feedback f
on r.reservation_id=f.reservation_id
group by h.hotel_name
order by rating desc
limit 1;

select
c.customer_id,
concat(c.first_name,' ',c.last_name) customer,
sum(i.grand_total) lifetime_value
from customer c
join reservation r
on c.customer_id=r.customer_id
join invoice i
on r.reservation_id=i.reservation_id
group by c.customer_id;

select
sum(discount_amount) total_discount
from invoice;

select
customer_id,
sum(grand_total) spending,
rank() over(order by sum(grand_total) desc) customer_rank
from reservation r
join invoice i
on r.reservation_id=i.reservation_id
group by customer_id;

select
customer_id,
sum(grand_total) spending,
rank() over(order by sum(grand_total) desc) customer_rank
from reservation r
join invoice i
on r.reservation_id=i.reservation_id
group by customer_id
limit 1 offset 1;

select
booking_date,
count(*) total_bookings
from reservation
group by booking_date
order by booking_date;

select
rt.type_name,
sum(i.grand_total) revenue
from roomtype rt
join room rm
on rt.room_type_id=rm.room_type_id
join reservation r
on rm.room_id=r.room_id
join invoice i
on r.reservation_id=i.reservation_id
group by rt.type_name
order by revenue desc;

select
reservation_id,
sum(quantity) total_services
from reservationservice
group by reservation_id
order by total_services desc
limit 1;

select
r.customer_id,
count(distinct rm.hotel_id) hotels
from reservation r
join room rm
on r.room_id=rm.room_id
group by r.customer_id
having count(distinct rm.hotel_id)>1;

select
type_name,
avg(base_price) average_price
from roomtype
group by type_name;

select
h.hotel_name,
count(rm.room_id) total_rooms
from hotel h
join room rm
on h.hotel_id=rm.hotel_id
group by h.hotel_name
order by total_rooms desc
limit 1;

select
h.hotel_name,
count(distinct r.reservation_id) as total_bookings,
count(distinct c.customer_id) as total_customers,
sum(i.grand_total) as revenue,
round(avg(f.rating),2) as average_rating,
count(distinct rm.room_id) as total_rooms
from hotel h
left join room rm
on h.hotel_id=rm.hotel_id
left join reservation r
on rm.room_id=r.room_id
left join customer c
on r.customer_id=c.customer_id
left join invoice i
on r.reservation_id=i.reservation_id
left join feedback f
on r.reservation_id=f.reservation_id
group by h.hotel_name;