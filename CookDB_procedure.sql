CREATE PROCEDURE InsertProduct
	@name varchar(75),
	@price float,
	@count int,
	@calories float,
	@weight float
as
BEGIN
	INSERT INTO Product
		(name, price, count, calories, weight)
	VALUES 
		(@name, @price, @count, @calories, @weight)

	SELECT * FROM Product
END
go


ALTER PROCEDURE UpdateMenuList
	@menu int,
	@product varchar(75),
	@count int
as 
BEGIN
	declare @product_ID int

	select @product_ID = ID
	from Product where name = @product

	IF EXISTS (SELECT * from Menu_list where menu_ID = @menu and product_ID = @product_ID)
	begin
		update Menu_List
		set count = @count
		where menu_ID = @menu and product_ID = @product_ID
		
		select Menu_list.menu_ID, Product.name, Menu_list.count
		from Menu_list 
		inner join Product on Product.ID = Menu_list.product_ID
		where menu_ID = @menu
		return
	end

	insert into Menu_list values
		(@menu, @product_ID, @count)

	select Menu_list.menu_ID, Product.name, Menu_list.count
	from Menu_list
	inner join Product on Product.ID = Menu_list.product_ID
	where menu_ID = @menu
END
go


ALTER PROCEDURE InsertCheckList
	@check int,
	@product varchar(75),
	@count int
as 
BEGIN
	declare @product_ID int
	declare @product_count int

	select @product_ID = ID, @product_count = count
	from Product where name = @product
	
	if (@product_count < @count) begin
		select 0 Result, 'shortage count' Msg
		return
	end

	update Product
	set count = count - @count
	where ID = @product_ID

	if not EXISTS (select * from Sale_check where ID = @check)
	begin
		insert into Sale_check (ID, price) values (@check, 0)
	end

	insert into Check_compositions(sale_ID, product_ID, count) values
		(@check, @product_ID, @count);

	select Check_compositions.sale_ID, Check_compositions.count, Product.name
	from Check_compositions
	inner join Product on Product.ID = Check_compositions.product_ID
	where sale_ID=@check
END
go
