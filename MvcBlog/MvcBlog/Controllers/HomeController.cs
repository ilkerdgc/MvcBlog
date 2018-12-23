using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MvcBlog.Models;
using PagedList;
using PagedList.Mvc;

namespace MvcBlog.Controllers
{
    public class HomeController : Controller
    {
        MvcBlogDB db = new MvcBlogDB();

        
        public ActionResult Index(int page = 1)
        {
            var makale = db.Makales.OrderByDescending(m => m.MakaleID).ToPagedList(page, 5);
            return View(makale);
        }

        public ActionResult BlogAra(string Ara = null)
        {
            var aranan = db.Makales.Where(m => m.Baslik.Contains(Ara)).ToList();
            return View(aranan.OrderByDescending(m => m.Tarih));
        }

        public ActionResult _SonYorumlarPartial()
        {
            return View(db.Yorums.OrderByDescending(y => y.YorumID).Take(3));
        }

        public ActionResult _PopulerMakalelerPartial()
        {
            return View(db.Makales.OrderByDescending(m => m.Okunma).Take(5));
        }

        public ActionResult KategoriMakale(int id)
        {
            var makaleler = db.Makales.Where(m => m.Kategori.KategoriID == id).ToList();
            return View(makaleler);
        }

        public ActionResult MakaleDetay(int id)
        {
            var makale = db.Makales.Where(m => m.MakaleID == id).SingleOrDefault();
            if (makale == null)
            {
                return HttpNotFound();
            }
            return View(makale);
        }

        public ActionResult Hakkimizda()
        {
            return View();
        }
        public ActionResult Iletisim()
        {
            return View();
        }
        public ActionResult _KategoriPartial()
        {
            return View(db.Kategoris.ToList());
        }
        public JsonResult YorumYap(string yorum, int makaleID)
        {
            var uyeid = Session["UyeID"];
            if (yorum == null)
            {
                return Json(true, JsonRequestBehavior.AllowGet);
            }
            db.Yorums.Add(new Yorum { UyeID = Convert.ToInt32(uyeid), MakaleID = makaleID, Icerik = yorum, Tarih = DateTime.Now });
            db.SaveChanges();
            return Json(false, JsonRequestBehavior.AllowGet);
        }

        public ActionResult YorumSil(int id)
        {
            var uyeid = Session["UyeID"];
            var yorum = db.Yorums.Where(y => y.YorumID == id).SingleOrDefault();
            var makale = db.Makales.Where(m => m.MakaleID == yorum.MakaleID).SingleOrDefault();

            if (yorum.UyeID == Convert.ToInt32(uyeid))
            {
                db.Yorums.Remove(yorum);
                db.SaveChanges();
                return RedirectToAction("MakaleDetay","Home", new { id = makale.MakaleID });
            }
            else
            {
                return HttpNotFound();
            }
        }

        public ActionResult OkunmaArttir(int makaleid)
        {
            var makale = db.Makales.Where(m => m.MakaleID == makaleid).SingleOrDefault();
            makale.Okunma += 1;
            db.SaveChanges();
            return View();
        }
    }
}