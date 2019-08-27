set names utf8;
set foreign_key_checks=0;

drop database if exists florida;
create database if not exists florida;

use florida;

create table user_info(
id int primary key not null auto_increment comment "ID",
user_id varchar(16) unique not null comment "ユーザーID",
password varchar(16) not null comment "パスワード",
family_name varchar(32) not null comment "姓",
first_name varchar(32) not null comment "名",
family_name_kana varchar(32) not null comment "姓かな",
first_name_kana varchar(32) not null comment "名かな",
sex tinyint default 0 comment "姓別",
email varchar(32) comment "メールアドレス",
status tinyint default 0 comment "ステータス",
logined tinyint not null default 0 comment "ログインフラグ",
regist_date datetime comment "登録日",
update_date datetime comment "更新日"
)
default charset=utf8
comment="会員情報テーブル"
;

create table product_info(
id int primary key not null auto_increment comment "ID",
product_id int unique not null comment "商品ID",
product_name varchar(100) unique not null comment "商品名",
product_name_kana varchar(100) not null comment "商品名かな",
product_description varchar(255) not null comment "商品詳細",
category_id int not null not null comment "カテゴリID",
price int not null comment "値段",
image_file_path varchar(100) comment "画像ファイルパス",
image_file_name varchar(50) comment "画像ファイル名",
release_date datetime not null comment "発売年月",
release_company varchar(50) comment "発売会社",
status tinyint not null default 1 comment "ステータス",
regist_date datetime not null comment "登録日",
update_date datetime comment "更新日",
foreign key(category_id) references m_category(category_id)
)
default charset=utf8
comment="商品情報テーブル";

create table cart_info(
id int primary key not null auto_increment comment "ID",
user_id varchar(16) not null comment "ユーザーID",
product_id int not null comment "商品ID",
product_count int not null comment "個数",
regist_date datetime comment "登録日",
update_date datetime comment "更新日",
foreign key(product_id) references product_info(product_id)
)
default charset=utf8
comment="カート情報テーブル"
;

create table purchase_history_info(
id int primary key not null auto_increment comment "ID",
user_id varchar(16) not null comment "ユーザーID",
product_id int not null comment "商品ID",
product_count int not null comment "個数",
price int not null comment "値段",
destination_id int comment "宛先情報ID",
regist_date datetime comment "登録日",
update_date datetime comment "更新日",
foreign key(user_id) references user_info(user_id),
foreign key(product_id) references product_info(product_id)
)
default charset=utf8
comment="購入履歴情報テーブル"
;

create table destination_info(
id int primary key not null auto_increment comment "ID",
user_id varchar(16) not null comment "ユーザーID",
family_name varchar(32) not null comment "姓",
first_name varchar(32) not null comment "名",
family_name_kana varchar(32) not null comment "姓かな",
first_name_kana varchar(32) not null comment "名かな",
email varchar(32) comment "メールアドレス",
tel_number varchar(13) comment "電話番号",
user_address varchar(50) not null comment "住所",
regist_date datetime comment "登録日",
update_date datetime comment "更新日",
foreign key(user_id) references user_info(user_id)
)
default charset=utf8
comment="宛先情報テーブル"
;

create table m_category(
id int primary key not null comment "ID",
category_id int not null unique comment "カテゴリID",
category_name varchar(20) not null unique comment "カテゴリ名",
category_description varchar(100) comment "カテゴリ詳細",
insert_date datetime not null comment "登録日",
update_date datetime comment "更新日"
)
default charset=utf8
comment="カテゴリマスタテーブル"
;

set foreign_key_checks=1;

insert into user_info values
(1,"guest","guest","インターノウス","ゲストユーザー","いんたーのうす","げすとゆーざー",0,"guest@gmail.com",0,0,now(),now()),
(2,"guest2","guest2","インターノウス","ゲストユーザー2","いんたーのうす","げすとゆーざー2",0,"guest2@gmail.com",0,0,now(),now()),
(3,"guest3","guest3","インターノウス","ゲストユーザー3","いんたーのうす","げすとゆーざー3",0,"guest3@gmail.com",0,0,now(),now()),
(4,"guest4","guest4","インターノウス","ゲストユーザー4","いんたーのうす","げすとゆーざー4",0,"guest4@gmail.com",0,0,now(),now()),
(5,"guest5","guest5","インターノウス","ゲストユーザー5","いんたーのうす","げすとゆーざー5",0,"guest5@gmail.com",0,0,now(),now()),
(6,"guest6","guest6","インターノウス","ゲストユーザー6","いんたーのうす","げすとゆーざー6",0,"guest6@gmail.com",0,0,now(),now()),
(7,"guest7","guest7","インターノウス","ゲストユーザー7","いんたーのうす","げすとゆーざー7",0,"guest7@gmail.com",0,0,now(),now()),
(8,"guest8","guest8","インターノウス","ゲストユーザー8","いんたーのうす","げすとゆーざー8",0,"guest8@gmail.com",0,0,now(),now()),
(9,"guest9","guest9","インターノウス","ゲストユーザー9","いんたーのうす","げすとゆーざー9",0,"guest9@gmail.com",0,0,now(),now()),
(10,"guest10","guest10","インターノウス","ゲストユーザー10","いんたーのうす","げすとゆーざー10",0,"guest10@gmail.com",0,0,now(),now()),
(11,"guest11","guest11","インターノウス","ゲストユーザー11","いんたーのうす","げすとゆーざー11",0,"guest11@gmail.com",0,0,now(),now()),
(12,"guest12","guest12","インターノウス","ゲストユーザー12","いんたーのうす","げすとゆーざー12",0,"guest12@gmail.com",0,0,now(),now());

insert into m_category values
(1,1,"全てのカテゴリー","本、家電・パソコン、おもちゃ・ゲーム全てのカテゴリーが対象となります",now(), now()),
(2,2,"本","本に関するカテゴリーが対象となります",now(),now()),
(3,3,"家電・パソコン","家電・パソコンに関するカテゴリーが対象となります",now(),now()),
(4,4,"おもちゃ・ゲーム","おもちゃ・ゲームに関するカテゴリーが対象となります",now(),now()),
(5,5,"音楽","音楽に関するカテゴリーが対象となります",now(),now());

insert into product_info values
( 1, 1,"伊東慶祐の人生","いとうけいすけのじんせい","伊東慶祐の人生の商品詳細",2,100,"./images","book.jpg",now(),"発売会社",1,now(),now()),
( 2, 2,"星の王子さま","ほしのおうじさま","星の王子さまの商品詳細",2,200,"./images","book.png",now(),"発売会社",1,now(),now()),
( 3, 3,"羅生門","らしょうもん","羅生門の商品詳細",2,300,"./images","Book (2).png",now(),"発売会社",1,now(),now()),
( 4, 4,"魔法の料理本","まほうのりょうりぼん","まほうのりょうりぼんの商品詳細",2,100,"./images","book (3).png",now(),"発売会社",1,now(),now()),
( 5, 5,"源氏物語","げんじものがたり","源氏物語の商品詳細",2,200,"./images","book (4).png",now(),"発売会社",1,now(),now()),
( 6,6,"ノートパソコン","のーとぱそこん","ノートパソコンの商品詳細",3,100,"./images","PC.jpg",now(),"発売会社",1,now(),now()),
( 7,7,"冷蔵庫","れいぞうこ","冷蔵庫の商品詳細",3,200,"./images","Refredgerator.jpg",now(),"発売会社",1,now(),now()),
( 8,8,"電子レンジ","でんしれんじ","電子レンジの商品詳細",3,300,"./images","Oven.png",now(),"発売会社",1,now(),now()),
( 9,9,"掃除機","そうじき","掃除機の商品詳細",3,100,"./images","VacumMachine.png",now(),"発売会社",1,now(),now()),
( 10,10,"洗濯機","せんたくき","洗濯機の商品詳細",3,100,"./images","WashingMachine.jpg",now(),"発売会社",1,now(),now()),
( 11,11,"くまのぬいぐるみ","くまのぬいぐるみ","くまのぬいぐるみの商品詳細",4,100,"./images","Dool.jpg",now(),"発売会社",1,now(),now()),
( 12,12,"お人形さん","おにんぎょうさん","お人形さんの商品詳細",4,200,"./images","Dool (2).jpg",now(),"発売会社",1,now(),now()),
( 13,13,"DS","でぃーえす","DSの商品詳細",4,300,"./images","GameMachine.png",now(),"発売会社",1,now(),now()),
( 14,14,"PSP","ぴーえすぴー","PSPの商品詳細",4,100,"./images","GameMachine (2).png",now(),"発売会社",1,now(),now()),
( 15,15,"つみき","つみき","つみきの商品詳細",4,200,"./images","Toy.jpg",now(),"発売会社",1,now(),now()),
( 16,16,"伊東慶祐歌謡集","いとうけいすけかようしゅう","伊東慶祐歌謡集の商品詳細",5,100,"./images","CD.jpg",now(),"発売会社",1,now(),now()),
( 17,17,"オーディオプレイヤー","おーでぃおぷれいやー","オーディオプレイヤーの商品詳細",5,200,"./images","AudioPlayer.jpg",now(),"発売会社",1,now(),now()),
( 18,18,"ラジオ","らじお","ラジオの商品詳細",5,300,"./images","Radio.jpg",now(),"発売会社",1,now(),now()),
( 19,19,"ピアノ","ぴあの","ピアノの商品詳細",5,100,"./images","Piano.png",now(),"発売会社",1,now(),now()),
( 20,20,"ギター","ぎたー","ギターの商品詳細",5,200,"./images","Guitar.png",now(),"発売会社",1,now(),now());

insert into destination_info values
(1,"guest","インターノウス","テストユーざー","いんたーのうす","てすとゆーざー","guest@internous.co.jp","080-1234-5678","東京都千代田区三番町１ー１　ＫＹ三番町ビル１Ｆ",now(),now());
