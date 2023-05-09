create view Preferential_menu 
as 
	select Menu_list.*
	from Menu, Menu_list
	where Menu.ID = Menu_list.menu_ID 
	and Menu.preferential = 1;

create view Sold_products
as 
	select Product.ID, Product.name, Check_compositions.count 
	from Check_compositions
	inner join Product 
	on Check_compositions.product_ID = Product.ID;

create view Unsold_products
as
	select ID, name, count
	from Product
	where count > 0;

create view Finansial_results
as
	select sdate, sum(price) as price
	from Sale_check
	group by sdate;