create database demojoin;

use demojoin;
create table Product(
id int auto_increment primary key,
name varchar(50),
catalogId int
);

create table Catalog(
id int auto_increment primary key,
name varchar(100)
);
insert into Catalog(name) values
("áo"), ("quần"),("trang sức");
insert into Product(name, catalogId) values
("áo ngắn ",9), ("quần đùi",2),("sách",null);
-- inner join 
select * from product p join catAlog c on  p.catalogId = c.id;
 
-- left join 
select * from product p left join catAlog c on  p.catalogId = c.id; 

-- right join
select * from product p right join catAlog c on  c.id = p.catalogid ;

-- full outer join
select * from product p left join catAlog c on  p.catalogId = c.id 
union 
select * from product p right join catAlog c on  p.catalogId = c.id; 


SELECT s.id song_id,s.name song_name,sg.name singer_name,g.name genre_name 
FROM songs s inner join singers sg on s.singer_id = sg.id join genres g on g.id =s.genre_id 
order by sg.name desc,s.name
;

-- Group by / group by ... having
SELECT s.name
FROM  songs s inner join singers sg on s.singer_id = sg.id join genres g on g.id =s.genre_id 
group by s.name, g.name
;
-- hiển thị những thể loại có > 5 bài hát 
  SELECT g.name,count(s.id)
FROM  songs s inner join singers sg on s.singer_id = sg.id join genres g on g.id =s.genre_id 
group by g.name
having  count(s.id) > 5;

-- tính tông giá tiền của các bài hát theo album 

select count(s.id) `so  bai hat`, al.name from songs s 
join albums al on al.id = s.album_id
group by al.id
;

-- Tính tổng tiền trung bình của bảng songs sử dụng hàm AVG
select avg(songs.price) from songs;

-- Tính giá tiền trung bình mua một bài hát của từng người dùng

select avg(t.price),u.id  from transactions t join users u on t.user_id = u.id group by u.id;
-- Tìm bài hát có giá tiền cao nhất
select length(s.name) from songs s;
select now();


-- truy vấn nang cao 
-- truy vấn lồng

select songs.id,songs.name from songs;
select * from (select songs.id,songs.name, songs.album_id from songs) as s join albums a on a.id = s.album_id;

-- lấy ra danh sách những bài hát có giá cao nhất

select max(songs.price) from songs;
select  * from songs 
where songs.price = (select max(songs.price) from songs);

-- lấy ra toàn bộ thông tin của người dùng mua lớn hơn hoặc 2 bài hát 
select  *  from users where id in (select t.user_id from transactions t
group by t.user_id 
having count(t.song_id) >=2);

-- Lấy ra tất cả thông tin của những album chứa có bài hát có nhiều người mua nhất .
select count(t.user_id), t.song_id from transactions t
group by t.song_id limit 1
;
select t.song_id from transactions t
group by t.song_id having count(t.user_id) = (select count(t.user_id) from transactions t
group by t.song_id limit 1)
;

select distinct al.* from albums al join songs s on al.id = s.album_id where s.id in (select t.song_id from transactions t
group by t.song_id having count(t.user_id) = (select count(t.user_id) from transactions t
group by t.song_id limit 1));



