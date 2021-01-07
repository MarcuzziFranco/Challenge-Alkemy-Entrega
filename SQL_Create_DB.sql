USE [master]
GO
/****** Object:  Database [Registry]    Script Date: 1/7/2021 4:25:36 PM ******/
CREATE DATABASE [Registry]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Registry', FILENAME = N'G:\bbdd\MSSQL15.MSSQLSERVER\MSSQL\DATA\Registry.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Registry_log', FILENAME = N'G:\bbdd\MSSQL15.MSSQLSERVER\MSSQL\DATA\Registry_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Registry] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Registry].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Registry] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Registry] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Registry] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Registry] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Registry] SET ARITHABORT OFF 
GO
ALTER DATABASE [Registry] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Registry] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Registry] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Registry] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Registry] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Registry] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Registry] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Registry] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Registry] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Registry] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Registry] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Registry] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Registry] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Registry] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Registry] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Registry] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Registry] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Registry] SET RECOVERY FULL 
GO
ALTER DATABASE [Registry] SET  MULTI_USER 
GO
ALTER DATABASE [Registry] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Registry] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Registry] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Registry] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Registry] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Registry] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Registry', N'ON'
GO
ALTER DATABASE [Registry] SET QUERY_STORE = OFF
GO
USE [Registry]
GO
/****** Object:  Table [dbo].[Day]    Script Date: 1/7/2021 4:25:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Day](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[day_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Day] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Professor]    Script Date: 1/7/2021 4:25:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Professor](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[last_name] [nvarchar](50) NOT NULL,
	[dni] [nvarchar](20) NOT NULL,
	[activity] [bit] NOT NULL,
 CONSTRAINT [PK_Professor] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Profile]    Script Date: 1/7/2021 4:25:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Profile](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Profile] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 1/7/2021 4:25:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_user] [int] NOT NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student_subjet]    Script Date: 1/7/2021 4:25:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student_subjet](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_student] [int] NOT NULL,
	[id_subjet] [int] NOT NULL,
 CONSTRAINT [PK_Student_subjet] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Subjet]    Script Date: 1/7/2021 4:25:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subjet](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](50) NOT NULL,
	[start_time] [datetime] NOT NULL,
	[end_time] [datetime] NOT NULL,
	[id_day] [int] NOT NULL,
	[vacancies] [int] NOT NULL,
	[id_profesor] [int] NOT NULL,
 CONSTRAINT [PK_Subjet] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 1/7/2021 4:25:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Last_Name] [nvarchar](50) NOT NULL,
	[Dni] [nvarchar](20) NOT NULL,
	[Code_login] [nvarchar](20) NOT NULL,
	[type] [int] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Day] ON 
GO
INSERT [dbo].[Day] ([id], [day_name]) VALUES (1, N'Monday')
GO
INSERT [dbo].[Day] ([id], [day_name]) VALUES (2, N'Tuesday')
GO
INSERT [dbo].[Day] ([id], [day_name]) VALUES (3, N'Wednesday')
GO
INSERT [dbo].[Day] ([id], [day_name]) VALUES (4, N'Thursday')
GO
INSERT [dbo].[Day] ([id], [day_name]) VALUES (5, N'Friday')
GO
INSERT [dbo].[Day] ([id], [day_name]) VALUES (6, N'Saturday')
GO
INSERT [dbo].[Day] ([id], [day_name]) VALUES (7, N'Sunday')
GO
SET IDENTITY_INSERT [dbo].[Day] OFF
GO
SET IDENTITY_INSERT [dbo].[Professor] ON 
GO
INSERT [dbo].[Professor] ([id], [name], [last_name], [dni], [activity]) VALUES (1, N'Mario', N'Mendez', N'1111111', 1)
GO
INSERT [dbo].[Professor] ([id], [name], [last_name], [dni], [activity]) VALUES (4, N'Jose', N'Garcia', N'2222', 1)
GO
INSERT [dbo].[Professor] ([id], [name], [last_name], [dni], [activity]) VALUES (5, N'Pablo', N'Tomaz', N'3333', 1)
GO
INSERT [dbo].[Professor] ([id], [name], [last_name], [dni], [activity]) VALUES (1005, N'Fernando', N'Gonzales', N'555555', 1)
GO
INSERT [dbo].[Professor] ([id], [name], [last_name], [dni], [activity]) VALUES (1006, N'Juan', N'Morales', N'666666', 1)
GO
INSERT [dbo].[Professor] ([id], [name], [last_name], [dni], [activity]) VALUES (2005, N'Carlos', N'Medina', N'7777', 0)
GO
SET IDENTITY_INSERT [dbo].[Professor] OFF
GO
SET IDENTITY_INSERT [dbo].[Profile] ON 
GO
INSERT [dbo].[Profile] ([id], [Type]) VALUES (1, N'Manager')
GO
INSERT [dbo].[Profile] ([id], [Type]) VALUES (2, N'Student')
GO
SET IDENTITY_INSERT [dbo].[Profile] OFF
GO
SET IDENTITY_INSERT [dbo].[Student] ON 
GO
INSERT [dbo].[Student] ([id], [id_user]) VALUES (1, 3)
GO
INSERT [dbo].[Student] ([id], [id_user]) VALUES (2, 4)
GO
SET IDENTITY_INSERT [dbo].[Student] OFF
GO
SET IDENTITY_INSERT [dbo].[Student_subjet] ON 
GO
INSERT [dbo].[Student_subjet] ([id], [id_student], [id_subjet]) VALUES (1003, 2, 2)
GO
INSERT [dbo].[Student_subjet] ([id], [id_student], [id_subjet]) VALUES (2002, 1, 5)
GO
INSERT [dbo].[Student_subjet] ([id], [id_student], [id_subjet]) VALUES (2003, 1, 2)
GO
INSERT [dbo].[Student_subjet] ([id], [id_student], [id_subjet]) VALUES (2004, 2, 2002)
GO
SET IDENTITY_INSERT [dbo].[Student_subjet] OFF
GO
SET IDENTITY_INSERT [dbo].[Subjet] ON 
GO
INSERT [dbo].[Subjet] ([id], [name], [description], [start_time], [end_time], [id_day], [vacancies], [id_profesor]) VALUES (2, N'Sistemas Operativos', N'Materia Interesante', CAST(N'2021-01-02T15:00:00.000' AS DateTime), CAST(N'2021-01-02T17:00:00.000' AS DateTime), 1, 3, 4)
GO
INSERT [dbo].[Subjet] ([id], [name], [description], [start_time], [end_time], [id_day], [vacancies], [id_profesor]) VALUES (3, N'Matematica', N'La mas difícil', CAST(N'2021-01-02T18:00:00.000' AS DateTime), CAST(N'2021-01-02T21:00:00.000' AS DateTime), 3, 2, 5)
GO
INSERT [dbo].[Subjet] ([id], [name], [description], [start_time], [end_time], [id_day], [vacancies], [id_profesor]) VALUES (5, N'Estadistica', N'Cosas basicas', CAST(N'2021-01-02T13:00:00.000' AS DateTime), CAST(N'2021-01-02T17:00:00.000' AS DateTime), 5, 0, 1)
GO
INSERT [dbo].[Subjet] ([id], [name], [description], [start_time], [end_time], [id_day], [vacancies], [id_profesor]) VALUES (1002, N'Fisica Aplicada', N'La matematica util', CAST(N'2021-01-04T09:00:00.000' AS DateTime), CAST(N'2021-01-04T12:00:00.000' AS DateTime), 6, 3, 1005)
GO
INSERT [dbo].[Subjet] ([id], [name], [description], [start_time], [end_time], [id_day], [vacancies], [id_profesor]) VALUES (2002, N'Aritmetica', N'Figuras matematicas', CAST(N'2021-01-06T15:00:00.000' AS DateTime), CAST(N'2021-01-06T17:00:00.000' AS DateTime), 4, 1, 5)
GO
INSERT [dbo].[Subjet] ([id], [name], [description], [start_time], [end_time], [id_day], [vacancies], [id_profesor]) VALUES (2004, N'Base de datos', N'Tablas Relaciones y SQL', CAST(N'2021-01-07T14:00:00.000' AS DateTime), CAST(N'2021-01-07T16:00:00.000' AS DateTime), 1, 3, 1)
GO
INSERT [dbo].[Subjet] ([id], [name], [description], [start_time], [end_time], [id_day], [vacancies], [id_profesor]) VALUES (2005, N'Logica', N'El pilar de la computacion', CAST(N'2021-01-07T16:00:00.000' AS DateTime), CAST(N'2021-01-07T18:00:00.000' AS DateTime), 1, 3, 1005)
GO
SET IDENTITY_INSERT [dbo].[Subjet] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 
GO
INSERT [dbo].[User] ([id], [Name], [Last_Name], [Dni], [Code_login], [type]) VALUES (2, N'Franco', N'Marcuzzi', N'3780', N'1269', 1)
GO
INSERT [dbo].[User] ([id], [Name], [Last_Name], [Dni], [Code_login], [type]) VALUES (3, N'Ana', N'Mendez', N'3655', N'1234', 2)
GO
INSERT [dbo].[User] ([id], [Name], [Last_Name], [Dni], [Code_login], [type]) VALUES (4, N'Rodrigo', N'Rodriguez', N'1234', N'4321', 2)
GO
INSERT [dbo].[User] ([id], [Name], [Last_Name], [Dni], [Code_login], [type]) VALUES (1004, N'admin', N'test', N'1111', N'2222', 1)
GO
SET IDENTITY_INSERT [dbo].[User] OFF
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_User] FOREIGN KEY([id_user])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Student_User]
GO
ALTER TABLE [dbo].[Student_subjet]  WITH CHECK ADD  CONSTRAINT [FK_Student] FOREIGN KEY([id_student])
REFERENCES [dbo].[Student] ([id])
GO
ALTER TABLE [dbo].[Student_subjet] CHECK CONSTRAINT [FK_Student]
GO
ALTER TABLE [dbo].[Student_subjet]  WITH CHECK ADD  CONSTRAINT [FK_Subjet] FOREIGN KEY([id_subjet])
REFERENCES [dbo].[Subjet] ([id])
GO
ALTER TABLE [dbo].[Student_subjet] CHECK CONSTRAINT [FK_Subjet]
GO
ALTER TABLE [dbo].[Subjet]  WITH CHECK ADD  CONSTRAINT [FK_Subjet_Day] FOREIGN KEY([id_day])
REFERENCES [dbo].[Day] ([id])
GO
ALTER TABLE [dbo].[Subjet] CHECK CONSTRAINT [FK_Subjet_Day]
GO
ALTER TABLE [dbo].[Subjet]  WITH CHECK ADD  CONSTRAINT [FK_Subjet_Professor] FOREIGN KEY([id_profesor])
REFERENCES [dbo].[Professor] ([id])
GO
ALTER TABLE [dbo].[Subjet] CHECK CONSTRAINT [FK_Subjet_Professor]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Profile] FOREIGN KEY([type])
REFERENCES [dbo].[Profile] ([id])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Profile]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_User] FOREIGN KEY([id])
REFERENCES [dbo].[User] ([id])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_User]
GO
USE [master]
GO
ALTER DATABASE [Registry] SET  READ_WRITE 
GO
