-- Create Database
DROP DATABASE IF EXISTS raun_raun_airlane;
CREATE DATABASE raun_raun_airlane;
USE raun_raun_airlane;
CREATE TABLE Airport (
	AirportID varchar(20) not null unique primary key,
    AirportName varchar(50)
);
CREATE TABLE AirplaneType (
	AirplaneTypeID varchar(20) not null unique primary key,
	TypeName varchar(50),
	PassengerCapacity int,
    Dimension float,
	MachineType varchar(20)
);
CREATE TABLE Airplane (
	AirplaneID varchar(20) not null unique primary key,
	AirportID varchar(20),
	AirplaneTypeID varchar(20),
	EligibilityStatus tinyint,
    constraint AirportIDAirplane_FK foreign key (AirportID) references Airport(AirportID),
    constraint AirplaneTypeIDAirplane_FK foreign key (AirplaneTypeID) references AirplaneType(AirplaneTypeID)
);
CREATE TABLE Ticket (
	AirplaneTypeID varchar(20),
	TicketID varchar(20) not null unique,
	TicketClass varchar(20),
	TicketPrice bigint,
    primary key (TicketID, AirplaneTypeID),
	constraint AirplaneTypeIDTicket_FK foreign key (AirplaneTypeID) references AirplaneType(AirplaneTypeID)
);
CREATE TABLE FlightSchedule (
	FlightScheduleID varchar(20) not null unique primary key,
	FlightDate date,
	Hours time,
	Origin varchar(50),
	Destination varchar(50)
);
CREATE TABLE RealizationSchedule (
	RealizationScheduleID varchar(20) not null unique primary key,
	AirplaneID varchar(20),
    FlightScheduleID varchar(20),
    TimeStampDate date,
    Hours time,
	constraint AirplaneIDRS_FK foreign key (AirplaneID) references Airplane(AirplaneID),
    constraint FlightScheduleIDRS_FK foreign key (FlightScheduleID) references FlightSchedule(FlightScheduleID)
);
CREATE TABLE Crew (
	CrewID varchar(20) not null unique primary key,
    RealizationScheduleID varchar(20),
    CrewName varchar(50),
    BirthDate date,
    EntryDate date,
    Address varchar(50),
    Email varchar(50),
    PhoneNumber varchar(20),
    constraint RealizationScheduleID_FK foreign key (RealizationScheduleID) references RealizationSchedule(RealizationScheduleID)
);
CREATE TABLE Pilot (
	PCrewID varchar(20) not null unique primary key,
    FlightHours int,
    constraint Pilot_FK foreign key (PCrewID) references Crew(CrewID)
);
CREATE TABLE Stewardess (
	SCrewID varchar(20) not null unique primary key,
    TotalFlight int,
    constraint Stewardess_FK foreign key (SCrewID) references Crew(CrewID)
);
CREATE TABLE Mechanic (
    MCrewID varchar(20) not null unique primary key,
    constraint Mechanic_FK foreign key (MCrewID) references Crew(CrewID)
);
-- Insert Values
insert into Airport(AirportID, AirportName)
values
('CGK','Soekarno-Hatta'),('DPS','Ngurah Rai'),('SUB','Juanda'),('UPG','Sultan Hasanuddin'),('KNO','Kualanamu'),
('JOG','Adisutjipto'),('BPN','Sultan Aji Muhammad Sulaiman'),('HLP','Halim Perdanakusuma'),('BTH','Hang Nadim'),('PLM','Sultan Mahmud Badaruddin II'),
('SRG','Jenderal Ahmad Yani'),('BDO','Husein Sastranegara'),('PNK','Supadio'),('LOP','Lombok'),('PKU','Sultan Syarif Kasim II'),
('PDG','Minangkabau'),('BDJ','Syamsudin Noor'),('MDJ','Sam Ratulangi'),('TKG','Radin Inten II'),('SOC','Adisumarmo'),
('DJJ','Sentani'),('PGK','Depati Amir'),('KOE','El Tari'),('DJB','Sultan Thaha'),('SOQ','Domine Eduard Osok'),
('KDI','Haluoleo'),('AMQ','Pattimura'),('PLW','Mutiara'),('MLG','Abdul Rachman Saleh'),('BTJ','Sultan Iskandar Muda');
insert into AirplaneType(AirplaneTypeID, TypeName, PassengerCapacity, Dimension, MachineType)
values
('Boeing 737-100','Boeing',124,28.6,'ganda'),('Boeing 737-200','Boeing',136,30.5,'ganda'),('Boeing 737-500','Boeing',140,43.8,'ganda'),('Boeing 737-800','Boeing',189,39.5,'ganda'),('Boeing 737-MAX','Boeing',220,42.1,'ganda'),
('Airbus A318','Airbus',132,31.4,'turbofan'),('Airbus A319','Airbus',156,33.8,'turbofan'),('Airbus A320','Airbus',186,37.6,'turbofan'),('ATR 72-100','ATR',68,44,'ganda'),('ATR 72-200','ATR',70,44,'ganda'),
('ATR 72-210','ATR',70,44,'ganda'),('ATR 72-600','ATR',78,44,'ganda'),('Boeing 777-200','Boeing',440,63.7,'ganda'),('Boeing 777-200ER','Boeing',440,63.7,'ganda'),('Boeing 777-200LR','Boeing',440,63.7,'ganda'),
('Boeing 777-300','Boeing',550,73.9,'ganda'),('Boeing 777-300ER','Boeing',550,73.9,'ganda'),('Boeing 777F','Boeing',610,63.7,'ganda'),('Airbus A330-200','Airbus',406,58.8,'turbofan'),('Airbus A330-300','Airbus',440,63.6,'turbofan'),
('Airbus A330-900','Airbus',500,64.0,'turbofan'),('Boeing 787-8','Boeing',210,57.0,'turbofan'),('Boeing 787-9','Boeing',290,60.0,'turbofan'),('Boeing 787-10','Boeing',290,68.3,'turbofan'),('Airbus A321','Airbus',236,44.5,'turbofan'),
('Airbus A321-Neo','Airbus',220,44.5,'turbofan'),('Boeing 747','Boeing',500,70.6,'turbofan'),('Boeing 707','Boeing',170,46.6,'turbofan'),('Airbus A380','Airbus',555,73.0,'turbofan'),('Airbus A350','Airbus',300,66.8,'turbofan');
insert into Airplane(AirplaneID, AirportID, AirplaneTypeID, EligibilityStatus)
values 
('RR-101','JOG','Airbus A350',1), ('RR-102','CGK','Boeing 737-800',1), ('RR-103','KDI','Boeing 777-300',1), ('RR-104','PDG','Boeing 777-300',1), ('RR-105','PDG','Boeing 737-500',0),
('RR-106','KOE','Airbus A319',1), ('RR-107','UPG','Boeing 777-300',1), ('RR-108','BPN','Boeing 737-200',1), ('RR-109','DPS','Airbus A321-Neo',1), ('RR-110','MDJ','Boeing 737-200',1),
('RR-111','DJJ','ATR 72-210',1), ('RR-112','PDG','Boeing 737-800',1), ('RR-113','DPS','Airbus A380',1), ('RR-114','PDG','Airbus A350',0), ('RR-115','KDI','ATR 72-100',1),
('RR-116','JOG','Airbus A320',1), ('RR-117','CGK','Airbus A330-900',1), ('RR-118','BTJ','Airbus A380',1), ('RR-119','BTJ','Airbus A320',1), ('RR-120','SOQ','Airbus A350',1),
('RR-121','BTJ','Boeing 737-200',1), ('RR-122','SOC','Boeing 737-200',1), ('RR-123','HLP','Boeing 777-300',1), ('RR-124','MLG','Boeing 737-MAX',1), ('RR-125','MLG','Airbus A319',1),
('RR-126','DPS','Boeing 777-300',1), ('RR-127','JOG','Boeing 737-500',1), ('RR-128','LOP','ATR 72-210',1), ('RR-129','DPS','Boeing 777-300ER',1), ('RR-130','MLG','Boeing 737-500',0);
insert into Ticket(AirplaneTypeID, TicketID, TicketClass, TicketPrice)
values
('Boeing 737-200','1018310170162','Economy',800000), ('Boeing 737-200','1018048540368','First',2000000), ('Boeing 777-300','1013342918015','Business',1500000), ('Boeing 737-MAX','1016538305383','Business',1500000), ('Airbus A319','2025329448190','First',2000000),
('Boeing 777-300','1013682971040','First',2000000), ('Boeing 737-500','1019954021948','Economy',800000), ('ATR 72-210','5051248444266','Business',1500000), ('Boeing 777-300ER','1014753056833','First',2000000), ('Boeing 737-500','1015594925755','Economy',800000),
('Airbus A350','2022960265484','Economy',800000), ('Boeing 737-800','1017674771254','First',2000000), ('Boeing 777-300','1011459641366','Business',1500000), ('Boeing 777-300','1017245602683','Economy',800000), ('Boeing 737-500','1016503638399','Economy',800000),
('Airbus A319','2024223651655','Economy',800000), ('Boeing 777-300','1015235160346','First',2000000), ('Boeing 737-200','1019833237135','Business',1500000), ('Airbus A321-Neo','2027250967379','Economy',800000), ('Boeing 737-200','1011207126141','First',2000000),
('ATR 72-210','5052771799086','Economy',800000), ('Boeing 737-800','1012930612200','Business',1500000), ('Airbus A380','2027362185270','Business',1500000), ('Airbus A350','2025767090994','Economy',800000), ('ATR 72-100','5052821930422','First',2000000),
('Airbus A320','2028998488502','First',2000000), ('Airbus A330-900','2023826875084','Economy',800000), ('Airbus A380','2027768720469','First',2000000), ('Airbus A320','2026416998470','Business',1500000), ('Airbus A350','2026808974519','Economy',800000);
insert into FlightSchedule(FlightScheduleID, FLightDate, Hours, Origin, Destination)
values
('RRF-1299','2020-11-28','7:00:00','Soekarno–Hatta','Ngurah Rai'), ('RRF-1687','2020-11-18','15:30:00','Ngurah Rai','Sultan Syarif Kasim II'), ('RRF-1972','2020-12-27','14:00:00','Juanda','Husein Sastranegara'), ('RRF-1583','2020-12-24','16:30:00','Sultan Hasanuddin','Soekarno-Hatta'), ('RRF-1165','2020-12-02','9:00:00','Kualanamu','Sultan Iskandar Muda'),
('RRF-1198','2020-11-15','9:30:00','Adisutjipto','Sultan Thaha'), ('RRF-1117','2020-12-13','10:00:00','Sultan Aji Muhammad Sulaiman','Adisumarmo'), ('RRF-1668','2020-12-04','10:30:00','Halim Perdanakusuma','Soekarno-Hatta'), ('RRF-1106','2020-11-24','18:00:00','Hang Nadim','Ngurah Rai'), ('RRF-1802','2020-11-22','18:30:00','Sultan Mahmud Badaruddin II','Adisutjipto'),
('RRF-1902','2020-12-27','19:00:00','Jenderal Ahmad Yani','Depati Amir'), ('RRF-1822','2020-12-07','21:00:00','Husein Sastranegara','Adisutjipto'), ('RRF-1671','2020-12-04','20:30:00','Supadio','Adisumarmo'), ('RRF-1780','2020-11-17','17:30:00','Lombok','Juanda'), ('RRF-1614','2020-11-23','14:30:00','Sultan Syarif Kasim II','Soekarno-Hatta'),
('RRF-1101','2020-11-06','15:00:00','Minangkabau','Sultan Hasanuddin'), ('RRF-1214','2020-11-04','7:30:00','Syamsudin Noor','Jenderal Ahmad Yani'), ('RRF-1355','2020-12-20','8:00:00','Sam Ratulangi','Husein Sastranegara'), ('RRF-1031','2020-11-27','8:30:00','Radin Inten II','Adisutjipto'), ('RRF-1886','2020-12-17','17:00:00','Adisumarmo','Ngurah Rai'),
('RRF-1947','2020-12-12','17:30:00','Sentani','Lombok'), ('RRF-1640','2020-11-03','11:00:00','Depati Amir','Husein Sastranegara'), ('RRF-1435','2020-12-25','11:30:00','El Tari','Ngurah Rai'), ('RRF-1053','2020-11-27','8:30:00','Sultan Thaha','Soekarno-Hatta'), ('RRF-1209','2020-12-25','13:00:00','Domine Eduard Osok','Soekarno-Hatta'),
('RRF-1636','2020-11-15','13:30:00','Haluoleo','Sultan Aji Muhammad Sulaiman'), ('RRF-1579','2020-11-11','21:00:00','Pattimura','Halim Perdanakusuma'), ('RRF-1154','2020-11-09','21:30:00','Mutiara','Ngurah Rai'), ('RRF-1532','2020-12-16','22:00:00','Abdul Rachman Saleh','Halim Perdanakusuma'), ('RRF-1807','2020-12-18','23:00:00','Sultan Iskandar Muda','Juanda');
insert into RealizationSchedule(RealizationScheduleID, AirplaneID, FlightScheduleID, TimeStampDate, Hours)
values
('RS-471969','RR-122','RRF-1299','2020-11-28','7:05:35'),('RS-194863','RR-123','RRF-1687','2020-11-18','15:34:54'),('RS-203008','RR-129','RRF-1972','2020-12-27','14:34:43'),('RS-346322','RR-113','RRF-1583','2020-12-24','16:30:00'),('RS-315003','RR-124','RRF-1165','2020-12-02','9:10:12'),
('RS-256574','RR-120','RRF-1198','2020-11-15','9:30:25'),('RS-428115','RR-114','RRF-1117','2020-12-13','10:23:44'),('RS-242619','RR-105','RRF-1668','2020-12-04','10:56:30'),('RS-153010','RR-119','RRF-1106','2020-11-24','18:00:00'),('RS-373845','RR-130','RRF-1802','2020-11-22','18:32:22'),
('RS-366056','RR-109','RRF-1902','2020-12-27','19:04:00'),('RS-306940','RR-115','RRF-1822','2020-12-07','21:00:00'),('RS-167523','RR-101','RRF-1671','2020-12-04','20:33:27'),('RS-271208','RR-111','RRF-1780','2020-11-17','17:45:42'),('RS-329070','RR-106','RRF-1614','2020-11-23','14:53:38'),
('RS-107580','RR-102','RRF-1101','2020-11-06','15:24:13'),('RS-241112','RR-117','RRF-1214','2020-11-04','7:30:00'),('RS-282460','RR-125','RRF-1355','2020-12-20','8:05:26'),('RS-466340','RR-127','RRF-1031','2020-11-27','8:47:25'),('RS-157700','RR-104','RRF-1886','2020-12-17','17:40:26'),
('RS-495899','RR-118','RRF-1947','2020-12-12','17:32:53'),('RS-169432','RR-107','RRF-1640','2020-11-03','11:12:14'),('RS-249715','RR-112','RRF-1435','2020-12-25','11:30:35'),('RS-226697','RR-116','RRF-1053','2020-11-27','8:34:20'),('RS-177748','RR-110','RRF-1209','2020-12-25','13:34:41'),
('RS-367403','RR-126','RRF-1636','2020-11-15','13:37:49'),('RS-177223','RR-121','RRF-1579','2020-11-11','21:00:00'),('RS-492003','RR-128','RRF-1154','2020-11-09','21:31:30'),('RS-270331','RR-108','RRF-1532','2020-12-16','22:02:40'),('RS-128558','RR-103','RRF-1807','2020-12-18','23:02:13');
insert into Crew(CrewID, RealizationScheduleID, CrewName, BirthDate, EntryDate, Address, Email, PhoneNumber)
values
('MC001','RS-471969','Kala Murti Januar','1985-09-29','2008-10-27','Jl. Terate 61 A, Dki Jakarta','kalamurti@gmail.com','0812825813'),
('ST002','RS-194863','Endah Ella Riyanti','1984-09-08','2012-07-08','Jl. Dinoyo 61-63, Jawa Timur','endahella@gmail.com','0853888342'),
('PL003','RS-203008','Parman Wijaya','1980-03-29','2008-12-30','Kompl Deppen, Dki Jakarta','parmanwijaya@yahoo.com','0819697384'),
('ST004','RS-346322','Chelsea Haryanti','1983-09-22','2010-08-07','Jl. Rawa Buaya 33 A RT 04/07, Dki Jakarta','chelseaharyan@hotmail.com','0821390743'),
('MC005','RS-315003','Mulya Dalimin Firgantoro','1981-04-07','2009-06-03','Jl. Jend Sudirman Kav 1, Dki Jakarta','mulyadalimin@yahoo.com','0859486032'),
('PL006','RS-256574','Cahyanto Tedi Utama','1981-08-15','2014-07-06','Jl. KH Zainal Arifin 192, Sumatera Utara','cahyantotedi@gmail.com','0859735850'),
('MC007','RS-428115','Syahrini Indah Pudjiastuti','1980-09-27','2013-07-01','Jl. Jati Padang 2 18A RT 005/03, Dki Jakarta',null,'0814869592'),
('PL008','RS-242619','Gatra Salman Nainggolan','1984-07-09','2011-09-20','Jl. Cikini Raya 84-86, Dki Jakarta','gatrasalman@icloud.com','0818795377'),
('MC009','RS-153010','Tedi Mustofa','1979-02-28','2011-11-24','Jl. Harapan Indah XXII 47, Dki Jakarta','tedimustofa@yahoo.com','0821170611'),
('ST010','RS-373845','Puti Nasyidah','1982-10-05','2008-03-05','Kompl Harmoni Plaza Bl A/38, Dki Jakarta','putinasyidah@yahoo.com',null),
('PL011','RS-471969','Cakrabuana Tampubolon','1981-07-25','2012-01-25','Jl. Sei Bingai 5, Sumatera Utara','cakrabuana123@hotmail.com','0854914417'),
('ST012','RS-194863','Anita Utami','1983-01-27','2008-07-14','Jl. Kayu Putih 4 Bl A/4, Dki Jakarta','anitautami@yahoo.com','0821499558'),
('ST013','RS-203008','Sarah Yulianti','1979-04-03','2010-11-23','Jl. Budi Kemuliaan 16, Dki Jakarta','saragyuli@icloud.com','0897328104'),
('ST014','RS-346322','Puti Novitasari','1979-11-02','2009-11-05','Jl. Madiun 34, Dki Jakarta','putinovitasari@yahoo.com','0821692451'),
('PL015','RS-315003','Baktiono Jumari Saragih','1984-03-24','2011-07-17','Jl. Cikini Raya 69, Dki Jakarta','jumarisaragih@gmail.com','0814194612'),
('MC016','RS-256574','Pranawa Sitorus','1982-08-10','2014-02-20','Jl. Terminal Lintas Andalas, Sumatera Barat','pranawa94@yahoo.com','0821391045'),
('ST017','RS-428115','Aurora Puspa Usamah','1979-01-16','2014-04-17','Kompl Marina Kav 2, Jawa Tengah','aurorapu@gmail.com','0853445212'),
('MC018','RS-242619','Saiful Nasab Maheswara','1979-12-30','2011-01-06','Jl. Mardani Raya 56, Dki Jakarta','saifulnasab@yahoo.com','0812735545'),
('MC019','RS-153010','Cawuk Mandala','1980-02-08','2012-12-15','Jl. Bakti 18, Dki Jakarta','cawuk103@gmail.com','0856297511'),
('ST020','RS-373845','Lili Safina Lestari','1979-10-22','2009-11-16','Jl. Gn Krakatau 387 A, Sumatera Utara','lilisafina@yahoo.com','0817454879'),
('PL021','RS-471969','Darman Waluyo','1980-08-28','2015-11-07','Jl. Jatinegara Tmr 57 A, Dki Jakarta',null,'0895431617'),
('PL022','RS-194863','Cawisadi Kairav Saptono','1982-08-08','2013-09-28','Jl. Tj Karang 5, Dki Jakarta','cawisadiks@hotmail.com','0896709639'),
('ST023','RS-203008','Hafshah Puspita','1984-10-02','2010-02-03','Jl. Menteng Granit 14 A, Dki Jakarta','hpuspita@gmail.com','0821414456'),
('MC024','RS-346322','Setya Jagaraga Firgantoro','1983-09-06','2015-12-16','Jl. Mandala Raya 19, Dki Jakarta','setya34@gmail.com',null),
('PL025','RS-315003','Irwan Sirait','1981-05-10','2011-03-05','Jl. Pahlawan 19 B, Jawa Barat','irwans@gmail.com','0897692244'),
('MC026','RS-256574','Raden Mulya Hakim','1980-02-04','2008-12-23','Jl. Jend. Sudirman No. 40, Parepare','radenmulya@yahoo.com','0812774674'),
('PL027','RS-428115','Tirta Pradipta','1983-03-08','2015-11-28','Jl. Moh Yamin 2, Sumatera Utara','tirtap@yahoo.com',null),
('MC028','RS-242619','Margana Warji Mandala','1980-07-03','2015-10-05','Jl. Sultan Agung 4, Jawa Barat',null,'0858216078'),
('ST029','RS-153010','Zizi Sudiati','1985-07-18','2014-06-23','Jl. Bukit Tulip 7-9, Jawa Tengah','zizi15@gmail.com','0812225575'),
('PL030','RS-373845','Paris Namaga','1984-10-26','2014-07-25','Jl. Raden Saleh 45 F, Dki Jakarta','parisnamaga@gmail.com','0821933484'),
('MC031','RS-471969','Mulyanto Mandala','1980-11-22','2011-12-01','JL, Bass No. 599, Makassar','mulyala@gmail.com','0812388048'),
('ST032','RS-194863','Icha Kamaria Mardhiyah','1985-09-23','2006-04-18','Jl. Lumban Tobing No. 447, NTT',null,'0894394423'),
('PL033','RS-203008','Gatra Dongoran','1980-10-14','2016-05-20','Jl. Sumpah Pemuda No. 610, Dumai, DIY','gatradran@gmail.com','0821432568'),
('MC034','RS-346322','Ivan Gandi Wibisono','1984-09-28','2007-07-01','Jl. Bakti No. 557, Sulawesi Tengah','ivangapt@gmail.com','0857373274'),
('ST035','RS-315003','Arsanta Pratiwi','1986-01-24','2015-04-26','Jl. Padma No. 662, Parepare',null,'0817239434'),
('MC036','RS-256574','Harsaya Kusumo','1985-10-02','2008-02-05','Gg. Baik No. 183, Mataram','harsaya33@gmail.com','0821234459'),
('PL037','RS-428115','Mariadi Wawan Maheswara','1985-08-25','2006-08-22','Jl. Abdul No. 399, Tangerang','mariadiwm@gmail.com','0859343214'),
('PL038','RS-242619','Naradi Salahudin','1983-05-10','2008-08-25','Ds. Juanda No. 20, Madiun','nararadi05@yahoo.com','0812388546'),
('MC039','RS-153010','Langgeng Pangestu','1986-07-28','2015-09-17','Ki. Elang No. 226, Sorong','langgengpangestu@gmail.com','0821464904'),
('ST040','RS-373845','Kairav Sinaga','1980-08-05','2009-11-04','Ds. Achmad Yani No. 249, Tangerang','kairavsinaga@yahoo.com','0894305314'),
('ST041','RS-471969','Hamima Yolanda','1984-09-06','2008-04-10','Jl. Bayan No. 517, Tomohon','hamimayolanda@yahoo.com',null),
('ST042','RS-194863','Carla Cornelia Pertiwi','1985-09-10','2015-09-28','Jl. Honggowongso No. 526, Bitung','carlacp@gmail.com',null),
('PL043','RS-203008','Made Dwija Mahardika','1980-03-15','2011-10-22','Jl. Baja Raya No. 827, Sawahlunto','madedwija@gmail.com','0812388048'),
('MC044','RS-346322','Mohamad Ivan Hegiansyah','1984-06-21','2010-07-18','Jr. Cihampelas No. 535, Kotamobagu','ivanhegiansyah@gmail.com','0812395303'),
('PL045','RS-315003','Isnan Rifai','1983-01-28','2007-05-07','Jln. Jend. Sudirman No. 804, Bukittinggi','isnanrifai@gmail.com','0850493032');
insert into Pilot(PCrewID, FlightHours)
values
('PL003',299),('PL006',390),('PL027',402),('PL030',434),('PL021',125),
('PL025',185),('PL022',435),('PL011',165),('PL015',178),('PL008',189),
('PL045',312),('PL043',233),('PL033',128),('PL038',211),('PL037',209);
insert into Stewardess(SCrewID, TotalFlight)
values
('ST029',13),('ST017',19),('ST012',40),('ST023',11),('ST004',39),
('ST013',2),('ST002',19),('ST014',24),('ST020',27),('ST010',27),
('ST042',43),('ST040',11),('ST032',25),('ST035',22),('ST041',46);
insert into Mechanic(MCrewID)
values
('MC018'),('MC026'),('MC009'),('MC024'),('MC019'),
('MC007'),('MC016'),('MC001'),('MC005'),('MC028'),
('MC044'),('MC031'),('MC039'),('MC036'),('MC034');