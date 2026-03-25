IF DB_ID('zoo') IS NULL
BEGIN
    CREATE DATABASE zoo;
END
GO

USE zoo;
GO

IF OBJECT_ID('Animals', 'U') IS NOT NULL DROP TABLE Animals;
IF OBJECT_ID('Zookeepers', 'U') IS NOT NULL DROP TABLE Zookeepers;
IF OBJECT_ID('Departments', 'U') IS NOT NULL DROP TABLE Departments;
GO

CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    size_sm INT
);
GO

CREATE TABLE Zookeepers (
    zookeeper_id INT PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    expertise NVARCHAR(100)
);
GO

CREATE TABLE Animals (
    animal_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(50) NULL, 
    species NVARCHAR(50) NOT NULL,
    age FLOAT NOT NULL,
    department_id INT,
    zookeeper_id INT,
    CONSTRAINT FK_Animals_Departments FOREIGN KEY (department_id) REFERENCES Departments(department_id),
    CONSTRAINT FK_Animals_Zookeepers FOREIGN KEY (zookeeper_id) REFERENCES Zookeepers(zookeeper_id)
);
GO

INSERT INTO Departments (department_id, name, size_sm) VALUES
(1, N'Afrikai Szavanna', 5000),
(2, N'Hüllőház', 800),
(3, N'Majom-sziget', 1200),
(4, N'Madárröpde', 2000),
(5, N'Akvárium', 1500);
GO

INSERT INTO Zookeepers (zookeeper_id, name, expertise) VALUES
(1, N'Kovács Péter', N'Növényevők és patások'),
(2, N'Nagy Anna', N'Hüllők és kétéltűek'),
(3, N'Tóth Gábor', N'Főemlősök'),
(4, N'Szabó Éva', N'Madarak'),
(5, N'Kiss László', N'Vízi állatok');
GO

INSERT INTO Animals (name, species, age, department_id, zookeeper_id) VALUES
(N'Szimba', N'Oroszlán', 8.5, 1, 1),
(N'Nala', N'Oroszlán', 6.2, 1, 1),
(NULL, N'Oroszlán', 0.3, 1, 1),
(NULL, N'Oroszlán', 0.5, 1, 1),
(NULL, N'Oroszlán', 1.1, 1, 1),
(N'Zserbó', N'Zsiráf', 12.0, 1, 1),
(N'Foltos', N'Zsiráf', 7.4, 1, 1),
(N'Nyakigláb', N'Zsiráf', 4.8, 1, 1),
(N'Góliát', N'Zsiráf', 15.3, 1, 1),
(NULL, N'Zsiráf', 0.2, 1, 1),
(NULL, N'Zsiráf', 1.5, 1, 1),
(NULL, N'Zsiráf', 0.4, 1, 1),
(NULL, N'Zsiráf', 0.6, 1, 1),
(NULL, N'Zsiráf', 1.2, 1, 1),
(NULL, N'Zsiráf', 0.8, 1, 1),
(N'Csíkos', N'Zebra', 5.5, 1, 1),
(N'Villám', N'Zebra', 8.1, 1, 1),
(N'Zénó', N'Zebra', 3.7, 1, 1),
(NULL, N'Zebra', 0.1, 1, 1),
(NULL, N'Zebra', 1.3, 1, 1),
(NULL, N'Zebra', 0.5, 1, 1),
(NULL, N'Zebra', 0.2, 1, 1),
(NULL, N'Zebra', 0.7, 1, 1),
(NULL, N'Zebra', 1.8, 1, 1),
(NULL, N'Zebra', 1.4, 1, 1),
(NULL, N'Zebra', 0.3, 1, 1),
(NULL, N'Zebra', 0.9, 1, 1),
(NULL, N'Zebra', 0.4, 1, 1),
(NULL, N'Zebra', 1.1, 1, 1),
(NULL, N'Zebra', 0.6, 1, 1),
(N'Dumbó', N'Elefánt', 15.0, 1, 1),
(N'Mamus', N'Elefánt', 42.5, 1, 1),
(N'Trombi', N'Elefánt', 28.2, 1, 1),
(N'Agyar', N'Elefánt', 35.8, 1, 1),
(N'Kópé', N'Elefánt', 5.4, 1, 1),
(N'Zöldike', N'Iguána', 6.1, 2, 2),
(N'Tüsi', N'Iguána', 4.3, 2, 2),
(NULL, N'Iguána', 0.5, 2, 2),
(NULL, N'Iguána', 1.2, 2, 2),
(NULL, N'Iguána', 0.8, 2, 2),
(NULL, N'Iguána', 0.3, 2, 2),
(NULL, N'Iguána', 1.5, 2, 2),
(NULL, N'Iguána', 0.4, 2, 2),
(NULL, N'Iguána', 0.2, 2, 2),
(NULL, N'Iguána', 0.7, 2, 2),
(N'Kaa', N'Tigrispiton', 12.5, 2, 2),
(N'Sziszke', N'Tigrispiton', 8.0, 2, 2),
(N'Tekergő', N'Tigrispiton', 5.7, 2, 2),
(NULL, N'Tigrispiton', 0.6, 2, 2),
(NULL, N'Tigrispiton', 1.1, 2, 2),
(NULL, N'Tigrispiton', 0.9, 2, 2),
(NULL, N'Tigrispiton', 0.3, 2, 2),
(NULL, N'Tigrispiton', 0.4, 2, 2),
(NULL, N'Tigrispiton', 1.8, 2, 2),
(NULL, N'Tigrispiton', 0.2, 2, 2),
(N'Rejtő', N'Kaméleon', 3.1, 2, 2),
(N'Színész', N'Kaméleon', 2.4, 2, 2),
(N'Szemes', N'Kaméleon', 4.0, 2, 2),
(N'Lassú', N'Kaméleon', 2.8, 2, 2),
(NULL, N'Kaméleon', 0.5, 2, 2),
(NULL, N'Kaméleon', 0.2, 2, 2),
(NULL, N'Kaméleon', 0.7, 2, 2),
(NULL, N'Kaméleon', 0.4, 2, 2),
(NULL, N'Kaméleon', 0.9, 2, 2),
(NULL, N'Kaméleon', 0.6, 2, 2),
(N'Csita', N'Csimpánz', 18.5, 3, 3),
(N'Kong', N'Csimpánz', 25.0, 3, 3),
(N'Banán', N'Csimpánz', 12.3, 3, 3),
(N'Ugri', N'Csimpánz', 8.9, 3, 3),
(N'Okoska', N'Csimpánz', 30.1, 3, 3),
(N'Móka', N'Csimpánz', 15.4, 3, 3),
(N'Főnök', N'Csimpánz', 35.2, 3, 3),
(N'Kicsi', N'Csimpánz', 4.7, 3, 3),
(NULL, N'Csimpánz', 1.5, 3, 3),
(NULL, N'Csimpánz', 0.8, 3, 3),
(N'Julien', N'Gyűrűsfarkú maki', 7.5, 3, 3),
(N'Maurice', N'Gyűrűsfarkú maki', 9.2, 3, 3),
(N'Mort', N'Gyűrűsfarkú maki', 4.1, 3, 3),
(N'Maki', N'Gyűrűsfarkú maki', 5.6, 3, 3),
(NULL, N'Gyűrűsfarkú maki', 0.4, 3, 3),
(N'Futár', N'Strucc', 9.0, 4, 4),
(N'Szaladó', N'Strucc', 5.5, 4, 4),
(NULL, N'Strucc', 0.3, 4, 4),
(NULL, N'Strucc', 1.2, 4, 4),
(NULL, N'Strucc', 0.7, 4, 4),
(NULL, N'Strucc', 0.5, 4, 4),
(NULL, N'Strucc', 1.8, 4, 4),
(NULL, N'Strucc', 0.9, 4, 4),
(NULL, N'Strucc', 0.2, 4, 4),
(NULL, N'Strucc', 0.6, 4, 4),
(N'Tipegő', N'Pingvin', 6.2, 5, 5),
(N'Frakkos', N'Pingvin', 4.5, 5, 5),
(N'Halász', N'Pingvin', 8.0, 5, 5),
(NULL, N'Pingvin', 0.8, 5, 5),
(NULL, N'Pingvin', 1.4, 5, 5),
(NULL, N'Pingvin', 0.5, 5, 5),
(NULL, N'Pingvin', 0.3, 5, 5),
(NULL, N'Pingvin', 0.7, 5, 5),
(NULL, N'Pingvin', 1.1, 5, 5),
(NULL, N'Pingvin', 0.9, 5, 5);
GO