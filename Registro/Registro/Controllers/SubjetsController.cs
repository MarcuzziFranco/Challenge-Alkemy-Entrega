using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using System.Diagnostics;
using Registro.Models;

namespace Registro.Controllers
{
    public class SubjetsController : Controller
    {
        private RegistryEntities db = new RegistryEntities();

        // GET: Subjets
        public ActionResult Index()
        {
            if (checkUser())
            {
                var subjets = db.Subjets.Include(s => s.Professor).Include(s => s.Day);
                return View(subjets.OrderBy(x => x.name).ToList());
            }
            else
            {
                Debug.WriteLine("No valido");
                return RedirectToAction("FinishSession", "Manager"); 
            }
        }

        // GET: Subjets/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Subjet subjet = db.Subjets.Find(id);
            if (subjet == null)
            {
                return HttpNotFound();
            }
            return View(subjet);
        }

        // GET: Subjets/Create
        public ActionResult Create()
        {

            var result = from profes in db.Professors
                         where profes.activity == true
                         select profes;

            ViewBag.id_profesor = new SelectList(result.ToList(), "id", "name");
            ViewBag.id_day = new SelectList(db.Days, "id", "day_name");
            return View();
        }

        // POST: Subjets/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "id,name,description,start_time,end_time,id_profesor,vacancies,id_day")] Subjet subjet)
        {
            if (ModelState.IsValid)
            {
                db.Subjets.Add(subjet);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.id_profesor = new SelectList(db.Professors, "id", "name", subjet.id_profesor);
            ViewBag.id_day = new SelectList(db.Days, "id", "day_name", subjet.id_day);
            return View(subjet);
        }

        // GET: Subjets/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Subjet subjet = db.Subjets.Find(id);
            if (subjet == null)
            {
                return HttpNotFound();
            }

            
            //Busco solo los profesores activos.
            var result = from profes in db.Professors
                         where profes.activity == true
                         select profes;
            
            //Paso la lista al DrowDownList.
            ViewBag.id_profesor = new SelectList(result.ToList(), "id", "name", subjet.id_profesor);

            ViewBag.id_day = new SelectList(db.Days, "id", "day_name", subjet.id_day);
            return View(subjet);
        }

        // POST: Subjets/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "id,name,description,start_time,end_time,id_profesor,vacancies,id_day")] Subjet subjet)
        {
            if (ModelState.IsValid)
            {
                db.Entry(subjet).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.id_profesor = new SelectList(db.Professors, "id", "name", subjet.id_profesor);
            ViewBag.id_day = new SelectList(db.Days, "id", "day_name", subjet.id_day);
            return View(subjet);
        }

        // GET: Subjets/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Subjet subjet = db.Subjets.Find(id);
            if (subjet == null)
            {
                return HttpNotFound();
            }
            return View(subjet);
        }

        // POST: Subjets/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Subjet subjet = db.Subjets.Find(id);

            //Busco las incripciones a la materia.
            var incripciones = from incr in db.Student_subjet
                               where incr.id_subjet == subjet.id
                               select incr;
         
            //elimino las incripciones.
            db.Student_subjet.RemoveRange(incripciones);
            //elimino la materia.
            db.Subjets.Remove(subjet); 
            
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool checkUser()
        {
            bool valid = false;
            if ((String)Session["type_user"] == "Manager")
            {
                valid = true;
            }
            return valid;
        }
    }
}
