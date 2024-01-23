1. CASE ... WHEN
select film_id,
case
	when length<60 then 'short'
	when length between 60 and 120 then 'meidum'
	when length>120 then 'long'
end
from film
2. Đếm số lượng theo từng thể lọai
select
case
	when length<60 then 'short'
	when length between 60 and 120 then 'medium'
	else  'long'
end category,
count (*) as so_luong 
from film
group by category
/* Bộ phim có tag là 1 nếu trường rating là G hoặc PG
còn lại là 0 */
select film_id,
case
	when rating in ('G', 'PG') then 1
	when rating not in ('G', 'PG') then 0 / else 0
end tag
from film
--tìm hiểu xem công ty đã bán bao
nhiêu vé trong danh mục sau
 low price ticket:
total_amount<20000
 mid price ticket: total_amount
between 20000 and 150000
 high price ticket:
total_amount>=150000
select 
case
 when amount<20000 then 'low price ticket'
 when amount between 20000 and 150000 then 'mid price ticket'
 else 'high price ticket'
end category,
count (*) as so_luong
from ticket_flights
group by category
  /*  Cho biết có bao nhiêu chuyến bay đã khởi hành vào
	Mùa xuân: 2,3,4
	Mùa hè: 5,6,7
	Màu thu: 8,9,10
	Mùa đông: 11,12,1
	*/
select 
case
	when extract(month from scheduled_departure) in (2,3,4) then 'mùa xuân'
	when extract(month from scheduled_departure) in (5,6,7) then 'mùa hè'
	when extract(month from scheduled_departure) in (8,9,10) then 'mùa thu'
	else 'mùa đông'
end as season,
count(*) as so_luong
from flights
group by season
  /* Bạn muốn tạo danh sách phim phân theo cấp độ như sau:
1. Xếp hạng là PG/PG-13 hoặc thời lượng hơn 210 phút: Great rating or long (tier 1)
2. Mô tả chứa 'Drama' và thời lượng hơn 90 phút: 'Log drama (tier 2)'
3. Mô tả chứa 'Drama' và thời lượng không quá 90 phút: 'Shcity Drama (tier 3)'
4. Gia thuê thấp hơn $1: 'Very cheap (tier 4 )'
Nếu một bộ phim có thể thuộc nhiều danh mục nó sẽ chỉ định ở cấp cao hơn
Làm thế nào để chỉ lọc những phim xuất hiện ở một trong 4 cấp độ này
*/

select film_id,
case
 	when rating in ('PG', 'PG-13') 
	or length >210  then 'tier 1'
	when description like '%Drama%' and length > 90 then 'tier 2'
	when description like '%Drama%' and length <= 90 then 'tier 3'
	when rental_rate <1 then 'tier 4'
end as category
from film
where case
 	when rating in ('PG', 'PG-13') 
	or length >210  then 'tier 1'
	when description like '%Drama%' and length > 90 then 'tier 2'
	when description like '%Drama%' and length <= 90 then 'tier 3'
	when rental_rate <1 then 'tier 4'
end is not null
-- CAST
--string/number/datetime
select  
--string --> number ( string phải chứa chữ số, không được chứa abc )
cast (ticket_no as bigint),
-- number --> string
cast (amount as varchar)
from ticket_flights;
--datetime--> string
select
cast(scheduled_departure as varchar)
from flights

