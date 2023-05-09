CREATE TRIGGER sale_product
ON Check_compositions AFTER INSERT
as
BEGIN
  UPDATE Sale_check
  SET Sale_check.price = Sale_check.price + (select price from Product where Product.ID = inserted.product_ID) * inserted.count
  from inserted
  inner join Sale_check on Sale_check.ID = inserted.sale_ID
END
go

CREATE TRIGGER menu_price
on Menu_list AFTER INSERT
as
begin
	UPDATE Menu
	set Menu.price = Menu.price + (select price from Product where Product.ID = inserted.product_ID) * inserted.count
	from inserted
	inner join Menu on Menu.ID = inserted.menu_ID
end
go