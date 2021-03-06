USE [master]
GO
/****** Object:  Database [MvcBlog]    Script Date: 5.01.2018 16:19:25 ******/
CREATE DATABASE [MvcBlog]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MvcBlog', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\MvcBlog.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'MvcBlog_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\MvcBlog_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [MvcBlog] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MvcBlog].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MvcBlog] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MvcBlog] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MvcBlog] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MvcBlog] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MvcBlog] SET ARITHABORT OFF 
GO
ALTER DATABASE [MvcBlog] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MvcBlog] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MvcBlog] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MvcBlog] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MvcBlog] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MvcBlog] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MvcBlog] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MvcBlog] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MvcBlog] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MvcBlog] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MvcBlog] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MvcBlog] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MvcBlog] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MvcBlog] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MvcBlog] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MvcBlog] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MvcBlog] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MvcBlog] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [MvcBlog] SET  MULTI_USER 
GO
ALTER DATABASE [MvcBlog] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MvcBlog] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MvcBlog] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MvcBlog] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [MvcBlog] SET DELAYED_DURABILITY = DISABLED 
GO
USE [MvcBlog]
GO
/****** Object:  Table [dbo].[Etiket]    Script Date: 5.01.2018 16:19:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Etiket](
	[EtiketID] [int] IDENTITY(1,1) NOT NULL,
	[EtiketAdi] [nvarchar](50) NULL,
 CONSTRAINT [PK_Etiket] PRIMARY KEY CLUSTERED 
(
	[EtiketID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Kategori]    Script Date: 5.01.2018 16:19:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kategori](
	[KategoriID] [int] IDENTITY(1,1) NOT NULL,
	[KategoriAdi] [nvarchar](50) NULL,
 CONSTRAINT [PK_Kategori] PRIMARY KEY CLUSTERED 
(
	[KategoriID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Makale]    Script Date: 5.01.2018 16:19:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Makale](
	[MakaleID] [int] IDENTITY(1,1) NOT NULL,
	[Baslik] [nvarchar](500) NULL,
	[Icerik] [nvarchar](max) NULL,
	[Foto] [nvarchar](500) NULL,
	[Tarih] [datetime] NULL CONSTRAINT [DF_Makale_Tarih]  DEFAULT (getdate()),
	[KategoriID] [int] NULL,
	[UyeID] [int] NULL,
	[Okunma] [int] NULL,
 CONSTRAINT [PK_Makale] PRIMARY KEY CLUSTERED 
(
	[MakaleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MakaleEtiket]    Script Date: 5.01.2018 16:19:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MakaleEtiket](
	[MakaleID] [int] NOT NULL,
	[EtiketID] [int] NOT NULL,
 CONSTRAINT [PK_MakaleEtiket] PRIMARY KEY CLUSTERED 
(
	[MakaleID] ASC,
	[EtiketID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Uye]    Script Date: 5.01.2018 16:19:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Uye](
	[UyeID] [int] IDENTITY(1,1) NOT NULL,
	[KullaniciAdi] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[Sifre] [nvarchar](100) NULL,
	[AdSoyad] [nvarchar](50) NULL,
	[Foto] [nvarchar](250) NULL,
	[YetkiID] [int] NULL,
 CONSTRAINT [PK_Uye] PRIMARY KEY CLUSTERED 
(
	[UyeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Yetki]    Script Date: 5.01.2018 16:19:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Yetki](
	[YetkiID] [int] IDENTITY(1,1) NOT NULL,
	[Yetki] [nvarchar](50) NULL,
 CONSTRAINT [PK_Yetki] PRIMARY KEY CLUSTERED 
(
	[YetkiID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Yorum]    Script Date: 5.01.2018 16:19:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Yorum](
	[YorumID] [int] IDENTITY(1,1) NOT NULL,
	[Icerik] [nvarchar](500) NULL,
	[UyeID] [int] NULL,
	[MakaleID] [int] NULL,
	[Tarih] [datetime] NULL CONSTRAINT [DF_Yorum_Tarih]  DEFAULT (getdate()),
 CONSTRAINT [PK_Yorum] PRIMARY KEY CLUSTERED 
(
	[YorumID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Etiket] ON 

INSERT [dbo].[Etiket] ([EtiketID], [EtiketAdi]) VALUES (15, N'resim1')
INSERT [dbo].[Etiket] ([EtiketID], [EtiketAdi]) VALUES (16, N' resim2')
INSERT [dbo].[Etiket] ([EtiketID], [EtiketAdi]) VALUES (17, N'Yazılım')
INSERT [dbo].[Etiket] ([EtiketID], [EtiketAdi]) VALUES (18, N' Dilleri')
INSERT [dbo].[Etiket] ([EtiketID], [EtiketAdi]) VALUES (19, N' Sıralaması')
INSERT [dbo].[Etiket] ([EtiketID], [EtiketAdi]) VALUES (20, N'resim1')
INSERT [dbo].[Etiket] ([EtiketID], [EtiketAdi]) VALUES (21, N' resim2')
INSERT [dbo].[Etiket] ([EtiketID], [EtiketAdi]) VALUES (22, N' resim3')
INSERT [dbo].[Etiket] ([EtiketID], [EtiketAdi]) VALUES (23, N' resim4')
INSERT [dbo].[Etiket] ([EtiketID], [EtiketAdi]) VALUES (28, N'resim1')
INSERT [dbo].[Etiket] ([EtiketID], [EtiketAdi]) VALUES (29, N' resim2')
INSERT [dbo].[Etiket] ([EtiketID], [EtiketAdi]) VALUES (30, N' resim3')
INSERT [dbo].[Etiket] ([EtiketID], [EtiketAdi]) VALUES (31, N' resim4')
INSERT [dbo].[Etiket] ([EtiketID], [EtiketAdi]) VALUES (32, N'b1')
INSERT [dbo].[Etiket] ([EtiketID], [EtiketAdi]) VALUES (33, N'b2')
INSERT [dbo].[Etiket] ([EtiketID], [EtiketAdi]) VALUES (34, N'b3')
INSERT [dbo].[Etiket] ([EtiketID], [EtiketAdi]) VALUES (35, N'resim1')
INSERT [dbo].[Etiket] ([EtiketID], [EtiketAdi]) VALUES (36, N' resim2')
INSERT [dbo].[Etiket] ([EtiketID], [EtiketAdi]) VALUES (37, N' resim3')
INSERT [dbo].[Etiket] ([EtiketID], [EtiketAdi]) VALUES (38, N' resim4')
INSERT [dbo].[Etiket] ([EtiketID], [EtiketAdi]) VALUES (41, N'yazılım')
INSERT [dbo].[Etiket] ([EtiketID], [EtiketAdi]) VALUES (42, N'yazılım2')
INSERT [dbo].[Etiket] ([EtiketID], [EtiketAdi]) VALUES (43, N'dasd')
SET IDENTITY_INSERT [dbo].[Etiket] OFF
SET IDENTITY_INSERT [dbo].[Kategori] ON 

INSERT [dbo].[Kategori] ([KategoriID], [KategoriAdi]) VALUES (1, N'Genel')
INSERT [dbo].[Kategori] ([KategoriID], [KategoriAdi]) VALUES (3, N'Teknoloji')
INSERT [dbo].[Kategori] ([KategoriID], [KategoriAdi]) VALUES (4, N'Yazılım')
INSERT [dbo].[Kategori] ([KategoriID], [KategoriAdi]) VALUES (7, N'Sağlık')
SET IDENTITY_INSERT [dbo].[Kategori] OFF
SET IDENTITY_INSERT [dbo].[Makale] ON 

INSERT [dbo].[Makale] ([MakaleID], [Baslik], [Icerik], [Foto], [Tarih], [KategoriID], [UyeID], [Okunma]) VALUES (17, N'C# İle Stopwatch Kullanımı ve İşlem Süresi Hesaplamaları', N'<p><a href="https://msdn.microsoft.com/tr-tr/library/system.diagnostics.stopwatch(v=vs.110).aspx" target="_blank">Stopwatch</a><span></span></p>
<p></p>
<p>&Ouml;rneğimizde iki farklı y&ouml;ntemi benchmark yapacağız. Elimizde bir sayı koleksiyonu var ve biz bu koleksiyonun elemanlarını bir Console uygulaması ile ekrana yazdırmak istiyoruz. Koleksiyon elemanlarını yazdırmak i&ccedil;in bir d&ouml;ng&uuml; işlemine ihtiyacımız var. &Ouml;ncelikle bir For d&ouml;ng&uuml;s&uuml; ile ekrana yazdırmayı deneyelim.</p>
<div class="dp-highlighter">
<div class="bar"></div>
<ol start="1" class="dp-c">
<li class="alt"><span><span class="keyword">static</span><span>&nbsp;</span><span class="keyword">void</span><span>&nbsp;Main(</span><span class="keyword">string</span><span>[]&nbsp;args)&nbsp;&nbsp;</span></span></li>
<li><span>{&nbsp;&nbsp;</span></li>
<li class="alt"><span>&nbsp;&nbsp;&nbsp;&nbsp;List&lt;<span class="keyword">int</span><span>&gt;&nbsp;numbers&nbsp;=&nbsp;</span><span class="keyword">new</span><span>&nbsp;List&lt;</span><span class="keyword">int</span><span>&gt;();&nbsp;&nbsp;</span></span></li>
<li><span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="keyword">for</span><span>&nbsp;(</span><span class="keyword">int</span><span>&nbsp;i&nbsp;=&nbsp;1;&nbsp;i&nbsp;&lt;=&nbsp;1000;&nbsp;i++)&nbsp;&nbsp;</span></span></li>
<li class="alt"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;numbers.Add(i);&nbsp;&nbsp;</span></li>
<li><span>&nbsp;&nbsp;</span></li>
<li class="alt"><span>&nbsp;&nbsp;&nbsp;&nbsp;Stopwatch&nbsp;stopwatch&nbsp;=&nbsp;<span class="keyword">new</span><span>&nbsp;Stopwatch();&nbsp;&nbsp;</span></span></li>
<li><span>&nbsp;&nbsp;&nbsp;&nbsp;stopwatch.Start();&nbsp;&nbsp;</span></li>
<li class="alt"><span>&nbsp;&nbsp;</span></li>
<li><span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="keyword">for</span><span>&nbsp;(</span><span class="keyword">int</span><span>&nbsp;i&nbsp;=&nbsp;0;&nbsp;i&nbsp;&lt;numbers.Count;&nbsp;i++)&nbsp;&nbsp;</span></span></li>
<li class="alt"><span>&nbsp;&nbsp;&nbsp;&nbsp;{&nbsp;&nbsp;</span></li>
<li><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Console.WriteLine(numbers[i]);&nbsp;&nbsp;</span></li>
<li class="alt"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Thread.Sleep(10);&nbsp;&nbsp;</span></li>
<li><span>&nbsp;&nbsp;&nbsp;&nbsp;}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></li>
<li class="alt"><span>&nbsp;&nbsp;</span></li>
<li><span>&nbsp;&nbsp;&nbsp;&nbsp;stopwatch.Stop();&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></li>
<li class="alt"><span>&nbsp;&nbsp;&nbsp;&nbsp;Console.WriteLine($<span class="string">"Time&nbsp;elapsed&nbsp;(For):&nbsp;{stopwatch.Elapsed}"</span><span>);&nbsp;&nbsp;</span></span></li>
<li><span>&nbsp;&nbsp;</span></li>
<li class="alt"><span>&nbsp;&nbsp;&nbsp;&nbsp;Console.ReadLine();&nbsp;&nbsp;</span></li>
<li><span>}&nbsp;&nbsp;</span></li>
</ol></div>
<p></p>
<p><img src="http://www.hikmetokumus.com/MakImages/stopwatch-for-sample.jpg" alt="www.hikmetokumus.com" class="img-responsive" /></p>
<p></p>
<p>For d&ouml;ng&uuml;s&uuml; ile işlem başlangı&ccedil; bitiş s&uuml;resini hesapladık. Kodu farklı y&ouml;ntemler ile optimize etsek daha performanslı bir sonu&ccedil; elde edebilir miyiz ? Bunu g&ouml;rmek i&ccedil;in Parallel.For yapısına g&ouml;re kodumuzu revize edelim ve Stopwatch ile s&uuml;reyi hesaplayalım.</p>
<div class="dp-highlighter">
<div class="bar"></div>
<ol start="1" class="dp-c">
<li class="alt"><span><span class="keyword">static</span><span>&nbsp;</span><span class="keyword">void</span><span>&nbsp;Main(</span><span class="keyword">string</span><span>[]&nbsp;args)&nbsp;&nbsp;</span></span></li>
<li><span>{&nbsp;&nbsp;</span></li>
<li class="alt"><span>&nbsp;&nbsp;&nbsp;&nbsp;List&lt;<span class="keyword">int</span><span>&gt;&nbsp;numbers&nbsp;=&nbsp;</span><span class="keyword">new</span><span>&nbsp;List&lt;</span><span class="keyword">int</span><span>&gt;();&nbsp;&nbsp;</span></span></li>
<li><span>&nbsp;&nbsp;&nbsp;&nbsp;<span class="keyword">for</span><span>&nbsp;(</span><span class="keyword">int</span><span>&nbsp;i&nbsp;=&nbsp;1;&nbsp;i&nbsp;&lt;=&nbsp;1000;&nbsp;i++)&nbsp;&nbsp;</span></span></li>
<li class="alt"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;numbers.Add(i);&nbsp;&nbsp;</span></li>
<li><span>&nbsp;&nbsp;</span></li>
<li class="alt"><span>&nbsp;&nbsp;&nbsp;&nbsp;Stopwatch&nbsp;stopwatch&nbsp;=&nbsp;<span class="keyword">new</span><span>&nbsp;Stopwatch();&nbsp;&nbsp;</span></span></li>
<li><span>&nbsp;&nbsp;&nbsp;&nbsp;stopwatch.Start();&nbsp;&nbsp;</span></li>
<li class="alt"><span>&nbsp;&nbsp;</span></li>
<li><span>&nbsp;&nbsp;&nbsp;&nbsp;Parallel.ForEach&lt;<span class="keyword">int</span><span>&gt;(numbers,&nbsp;x&nbsp;=&gt;&nbsp;&nbsp;</span></span></li>
<li class="alt"><span>&nbsp;&nbsp;&nbsp;&nbsp;{&nbsp;&nbsp;</span></li>
<li><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Console.WriteLine(x);&nbsp;&nbsp;</span></li>
<li class="alt"><span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Thread.Sleep(10);&nbsp;&nbsp;</span></li>
<li><span>&nbsp;&nbsp;&nbsp;&nbsp;});&nbsp;&nbsp;</span></li>
<li class="alt"><span>&nbsp;&nbsp;</span></li>
<li><span>&nbsp;&nbsp;&nbsp;&nbsp;stopwatch.Stop();&nbsp;&nbsp;</span></li>
<li class="alt"><span>&nbsp;&nbsp;&nbsp;&nbsp;Console.WriteLine($<span class="string">"Time&nbsp;elapsed&nbsp;(Parallel&nbsp;For):&nbsp;{stopwatch.Elapsed}"</span><span>);&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></span></li>
<li><span>&nbsp;&nbsp;</span></li>
<li class="alt"><span>&nbsp;&nbsp;&nbsp;&nbsp;Console.ReadLine();&nbsp;&nbsp;</span></li>
<li><span>}&nbsp;&nbsp;</span></li>
</ol></div>
<p></p>
<p><img src="http://www.hikmetokumus.com/MakImages/stopwatch-parallel-for-sample.jpg" alt="www.hikmetokumus.com" class="img-responsive" /></p>
<p></p>
<p>Her iki yapıya g&ouml;re işlem s&uuml;relerini baz aldığımızda, Parallel.For yapısının daha iyi bir performans sunduğu g&ouml;r&uuml;lmektedir. Artık kodumuzu Parallel.For yapısına g&ouml;re değiştirebiliriz. Konunun başında belirttiğim gibi, Stopwatch sayesinde farklı işlem yapılarını, kod bloklarını bu şekilde s&uuml;re bazında &ouml;l&ccedil;ebilir, yapıları benchmark edebiliriz.</p>
<p></p>
<p>Başarılar dilerim.</p>', N'/Upload/MakaleFoto/37b2b0cb-d802-4548-9f1f-d9813fb94893.jpg', CAST(N'2017-12-19 00:00:00.000' AS DateTime), 4, 5, 46)
INSERT [dbo].[Makale] ([MakaleID], [Baslik], [Icerik], [Foto], [Tarih], [KategoriID], [UyeID], [Okunma]) VALUES (18, N'Deneme3', N'<p>asfasfas</p>', N'/Upload/MakaleFoto/a406cd90-04fb-4f1e-a373-ce7d5c6c88f6.jpg', CAST(N'2017-12-26 00:00:00.000' AS DateTime), 1, 5, 4)
SET IDENTITY_INSERT [dbo].[Makale] OFF
INSERT [dbo].[MakaleEtiket] ([MakaleID], [EtiketID]) VALUES (17, 41)
INSERT [dbo].[MakaleEtiket] ([MakaleID], [EtiketID]) VALUES (17, 42)
INSERT [dbo].[MakaleEtiket] ([MakaleID], [EtiketID]) VALUES (18, 43)
SET IDENTITY_INSERT [dbo].[Uye] ON 

INSERT [dbo].[Uye] ([UyeID], [KullaniciAdi], [Email], [Sifre], [AdSoyad], [Foto], [YetkiID]) VALUES (5, N'IlkerDGC', N'ilker.dagcii@gmail.com', N'202CB962AC59075B964B07152D234B70', N'ilker dağcı', N'/Upload/UyeFoto/40c9c41f-0956-4a84-8921-fe69521fdddb.jpg', 1)
SET IDENTITY_INSERT [dbo].[Uye] OFF
SET IDENTITY_INSERT [dbo].[Yetki] ON 

INSERT [dbo].[Yetki] ([YetkiID], [Yetki]) VALUES (1, N'Admin')
INSERT [dbo].[Yetki] ([YetkiID], [Yetki]) VALUES (2, N'Üye')
SET IDENTITY_INSERT [dbo].[Yetki] OFF
SET IDENTITY_INSERT [dbo].[Yorum] ON 

INSERT [dbo].[Yorum] ([YorumID], [Icerik], [UyeID], [MakaleID], [Tarih]) VALUES (7, N'xzvxzv', 5, 17, CAST(N'2017-12-20 14:29:07.227' AS DateTime))
INSERT [dbo].[Yorum] ([YorumID], [Icerik], [UyeID], [MakaleID], [Tarih]) VALUES (8, N'zxvzvzdvd', 5, 17, CAST(N'2017-12-20 14:30:38.437' AS DateTime))
INSERT [dbo].[Yorum] ([YorumID], [Icerik], [UyeID], [MakaleID], [Tarih]) VALUES (9, N'', 5, 17, CAST(N'2017-12-21 13:58:06.697' AS DateTime))
INSERT [dbo].[Yorum] ([YorumID], [Icerik], [UyeID], [MakaleID], [Tarih]) VALUES (10, N'dolu', 5, 17, CAST(N'2017-12-21 14:27:56.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Yorum] OFF
ALTER TABLE [dbo].[Makale]  WITH CHECK ADD  CONSTRAINT [FK_Makale_Kategori] FOREIGN KEY([KategoriID])
REFERENCES [dbo].[Kategori] ([KategoriID])
GO
ALTER TABLE [dbo].[Makale] CHECK CONSTRAINT [FK_Makale_Kategori]
GO
ALTER TABLE [dbo].[Makale]  WITH CHECK ADD  CONSTRAINT [FK_Makale_Uye] FOREIGN KEY([UyeID])
REFERENCES [dbo].[Uye] ([UyeID])
GO
ALTER TABLE [dbo].[Makale] CHECK CONSTRAINT [FK_Makale_Uye]
GO
ALTER TABLE [dbo].[MakaleEtiket]  WITH CHECK ADD  CONSTRAINT [FK_MakaleEtiket_Etiket] FOREIGN KEY([EtiketID])
REFERENCES [dbo].[Etiket] ([EtiketID])
GO
ALTER TABLE [dbo].[MakaleEtiket] CHECK CONSTRAINT [FK_MakaleEtiket_Etiket]
GO
ALTER TABLE [dbo].[MakaleEtiket]  WITH CHECK ADD  CONSTRAINT [FK_MakaleEtiket_Makale] FOREIGN KEY([MakaleID])
REFERENCES [dbo].[Makale] ([MakaleID])
GO
ALTER TABLE [dbo].[MakaleEtiket] CHECK CONSTRAINT [FK_MakaleEtiket_Makale]
GO
ALTER TABLE [dbo].[Uye]  WITH CHECK ADD  CONSTRAINT [FK_Uye_Yetki] FOREIGN KEY([YetkiID])
REFERENCES [dbo].[Yetki] ([YetkiID])
GO
ALTER TABLE [dbo].[Uye] CHECK CONSTRAINT [FK_Uye_Yetki]
GO
ALTER TABLE [dbo].[Yorum]  WITH CHECK ADD  CONSTRAINT [FK_Yorum_Makale] FOREIGN KEY([MakaleID])
REFERENCES [dbo].[Makale] ([MakaleID])
GO
ALTER TABLE [dbo].[Yorum] CHECK CONSTRAINT [FK_Yorum_Makale]
GO
ALTER TABLE [dbo].[Yorum]  WITH CHECK ADD  CONSTRAINT [FK_Yorum_Uye] FOREIGN KEY([UyeID])
REFERENCES [dbo].[Uye] ([UyeID])
GO
ALTER TABLE [dbo].[Yorum] CHECK CONSTRAINT [FK_Yorum_Uye]
GO
USE [master]
GO
ALTER DATABASE [MvcBlog] SET  READ_WRITE 
GO
