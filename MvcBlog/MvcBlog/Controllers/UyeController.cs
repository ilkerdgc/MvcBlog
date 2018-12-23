using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MvcBlog.Models;
using System.Web.Helpers;
using System.IO;

namespace MvcBlog.Controllers
{
    public class UyeController : Controller
    {
        MvcBlogDB db = new MvcBlogDB();

        // GET: Uye
        public ActionResult Index(int id)
        {
            var uye = db.Uyes.Where(u => u.UyeID == id).SingleOrDefault();
            if (Convert.ToInt32(Session["UyeID"]) != uye.UyeID)
            {
                return HttpNotFound();
            }
            return View(uye);
        }

        public ActionResult Edit(int id)
        {
            var uye = db.Uyes.Where(u => u.UyeID == id).SingleOrDefault();
            if (Convert.ToInt32(Session["UyeID"]) != uye.UyeID)
            {
                return HttpNotFound();
            }
            return View(uye);
        }

        [HttpPost]
        public ActionResult Edit(int id, Uye uye, string sifre, HttpPostedFileBase foto)
        {
            if (ModelState.IsValid)
            {
                var guvenliSifreleme = sifre;

                var uyes = db.Uyes.Where(u => u.UyeID == id).SingleOrDefault();
                if (foto != null)
                {
                    if (System.IO.File.Exists(Server.MapPath(uye.Foto)))
                    {
                        System.IO.File.Delete(Server.MapPath(uyes.Foto));
                    }

                    WebImage img = new WebImage(foto.InputStream);
                    FileInfo fotoinfo = new FileInfo(foto.FileName);

                    string newfoto = Guid.NewGuid().ToString() + fotoinfo.Extension;
                    img.Resize(150, 150);
                    img.Save("~/Upload/UyeFoto/" + newfoto);
                    uyes.Foto = "/Upload/UyeFoto/" + newfoto;
                }
                uyes.AdSoyad = uye.AdSoyad;
                uyes.KullaniciAdi = uye.KullaniciAdi;
                uyes.Sifre = Crypto.Hash(guvenliSifreleme, "MD5");
                uyes.Email = uye.Email;
                db.SaveChanges();
                Session["KullaniciAdi"] = uye.KullaniciAdi;
                return RedirectToAction("Index", "Home", new { id = uyes.UyeID });

            }
            return View();
        }

        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(Uye uye, string sifre)
        {
            var guvenliSifreleme = Crypto.Hash(sifre, "MD5");

            var login = db.Uyes.Where(u => u.KullaniciAdi == uye.KullaniciAdi).FirstOrDefault();
            if (login.KullaniciAdi == uye.KullaniciAdi && login.Email == uye.Email && login.Sifre == guvenliSifreleme)
            {
                Session["UyeID"] = login.UyeID;
                Session["KullaniciAdi"] = login.KullaniciAdi;
                Session["YetkiID"] = login.YetkiID;
                return RedirectToAction("Index", "Home");
            }
            else
            {
                ViewBag.Uyari = "Kullanıcı Adı, Mail ya da Şifrenizi Kontrol Ediniz!";
                return View();
            }
            
        }

        public ActionResult Logout()
        {
            Session["UyeID"] = null;
            Session.Abandon(); // session ları sonlandırmak için kullanıldı
            return RedirectToAction("Index", "Home");
        }

        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Create(Uye uye, string sifre, HttpPostedFileBase foto)
        {
            var guvenliSifreleme = sifre;

            if (ModelState.IsValid)
            {
                if (foto != null)
                {
                    WebImage img = new WebImage(foto.InputStream);
                    FileInfo fotoinfo = new FileInfo(foto.FileName);
                    string newfoto = Guid.NewGuid().ToString() + fotoinfo.Extension;
                    img.Resize(150, 150);
                    img.Save("~/Upload/UyeFoto/" + newfoto);
                    uye.Foto = "/Upload/UyeFoto/" + newfoto;

                    uye.YetkiID = 2;
                    uye.Sifre = Crypto.Hash(guvenliSifreleme, "MD5");
                    db.Uyes.Add(uye);
                    db.SaveChanges();
                    Session["UyeID"] = uye.UyeID;
                    Session["KullaniciAdi"] = uye.KullaniciAdi;
                    return RedirectToAction("Index", "Home");
                }
                else
                {
                    ModelState.AddModelError("Fotoğraf", "Fotoğraf Seçiniz");
                }
            }
            return View(uye);
        }

        public ActionResult UyeProfili(int id)
        {
            var uye = db.Uyes.Where(u => u.UyeID == id).SingleOrDefault();

            return View(uye);
        }
    }
}