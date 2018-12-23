using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MvcBlog.Models;
using System.Web.Helpers;
using System.IO;
using PagedList;
using PagedList.Mvc;

namespace MvcBlog.Controllers
{
    public class AdminMakaleController : Controller
    {
        MvcBlogDB db = new MvcBlogDB();

       
        public ActionResult Index(int page = 1)
        {
            var makales = db.Makales.OrderByDescending(m => m.MakaleID).ToPagedList(page,10);           
            return View(makales);
        }

        
        public ActionResult Details(int id)
        {
            return View();
        }

        
        public ActionResult Create()
        {
            ViewBag.KategoriID = new SelectList(db.Kategoris, "KategoriID", "KategoriAdi");
            return View();
        }

        
        [HttpPost]
        public ActionResult Create(Makale makale, string etiketler, HttpPostedFileBase foto)
        {
            if (ModelState.IsValid)
            {
                if (foto != null)
                {
                    WebImage img = new WebImage(foto.InputStream);
                    FileInfo fotoinfo = new FileInfo(foto.FileName);
                    string newfoto = Guid.NewGuid().ToString() + fotoinfo.Extension;
                    img.Resize(800, 350);
                    img.Save("~/Upload/MakaleFoto/" + newfoto);
                    makale.Foto = "/Upload/MakaleFoto/" + newfoto;

                }
                if (etiketler != null)
                {
                    string[] etiketdizi = etiketler.Split(',');
                    foreach (var item in etiketdizi)
                    {
                        var yenietiket = new Etiket { EtiketAdi = item };
                        db.Etikets.Add(yenietiket);
                        makale.Etikets.Add(yenietiket);
                    }
                }

                makale.UyeID = Convert.ToInt32(Session["UyeID"]);
                makale.Okunma = 0;
                db.Makales.Add(makale);
                db.SaveChanges();

                return RedirectToAction("Index");
            }

            return View(makale);
        }

        
        public ActionResult Edit(int id)
        {
            var makale = db.Makales.Where(m => m.MakaleID == id).SingleOrDefault();
            if (makale == null)
            {
                return HttpNotFound();
            }
            ViewBag.KategoriID = new SelectList(db.Kategoris, "KategoriID", "KategoriAdi", makale.KategoriID);
            return View(makale);
        }

       
        [HttpPost]
        public ActionResult Edit(int id, HttpPostedFileBase foto, Makale makale)
        {
            // burada try catch bloklarını görmül olduk
            try
            {
                var GuncellenecekMakale = db.Makales.Where(m => m.MakaleID == id).SingleOrDefault();

                if (foto != null)
                {
                    if (System.IO.File.Exists(Server.MapPath(GuncellenecekMakale.Foto)))
                    {
                        System.IO.File.Delete(Server.MapPath(GuncellenecekMakale.Foto));
                    }

                    WebImage img = new WebImage(foto.InputStream);
                    FileInfo fotoinfo = new FileInfo(foto.FileName);

                    string newfoto = Guid.NewGuid().ToString() + fotoinfo.Extension;
                    img.Resize(800, 350);
                    img.Save("~/Upload/MakaleFoto/" + newfoto);
                    GuncellenecekMakale.Foto = "/Upload/MakaleFoto/" + newfoto;
                    GuncellenecekMakale.Baslik = makale.Baslik;
                    GuncellenecekMakale.Icerik = makale.Icerik;
                    GuncellenecekMakale.KategoriID = makale.KategoriID;
                    GuncellenecekMakale.Tarih = makale.Tarih;
                    db.SaveChanges();                  
                }
                else
                {
                    GuncellenecekMakale.Baslik = makale.Baslik;
                    GuncellenecekMakale.Icerik = makale.Icerik;
                    GuncellenecekMakale.KategoriID = makale.KategoriID;
                    GuncellenecekMakale.Tarih = makale.Tarih;
                    db.SaveChanges();
                }
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        
        public ActionResult Delete(int id)
        {
            var makale = db.Makales.Where(m => m.MakaleID == id).SingleOrDefault();
            if (makale == null)
            {
                return HttpNotFound();
            }
            return View(makale);
        }

        
        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                var makale = db.Makales.Where(m => m.MakaleID == id).SingleOrDefault();

                if (makale == null)
                {
                    return HttpNotFound();
                }
                if (System.IO.File.Exists(Server.MapPath(makale.Foto)))
                {
                    System.IO.File.Delete(Server.MapPath(makale.Foto));
                }
                foreach (var item in makale.Yorums.ToList())
                {
                    db.Yorums.Remove(item);
                }
                foreach (var item in makale.Etikets.ToList())
                {
                    db.Etikets.Remove(item);
                }
                db.Makales.Remove(makale);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
