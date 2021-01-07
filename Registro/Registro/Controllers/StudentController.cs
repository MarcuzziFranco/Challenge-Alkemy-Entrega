using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Registro.Models;
using System.Data.Entity;

namespace Registro.Views
{
    public class StudentController : Controller
    {

        // GET: Student
        public DataUser dataUser;
      
        public StudentController()
        {
            dataUser = new DataUser();
            
        }

        public ActionResult Index(DataUser dataUser)
        {
            if(Session["id_user"] == null)
            {
                Session["id_user"] = dataUser.id;
                Session["name_user"] = dataUser.Name;
                Session["last_name"] = dataUser.Last_name;
                
            }
      
            ViewBag.name = Session["name_user"];
            ViewBag.lastName = Session["last_name"];
           
            Debug.WriteLine("pagina estudiante");
            return View(this.dataUser);
        }

      

     

        public ActionResult OffertSubjet(int? op , String order)
        {
           
            using (var db = new RegistryEntities())
            {
                int id_student = GetStudentId();    //get id estudiante
                var student_subjet = db.Student_subjet.Where(d=> d.id_student == id_student).ToList();  //get lista materias anotadas.
                var subjets = db.Subjets.Include(s => s.Professor).Include(s => s.Day).ToList();    //get lista materias.

                var result = from a in subjets  //Consulta.
                             where !student_subjet.Select(b => b.id_subjet).Contains(a.id)
                             select a;

                Debug.WriteLine(order);

                if (op == 1)
                {
                    ViewBag.Message = "Successfull registration";
                }
                else if(op == 2)
                {
                    ViewBag.Message = "No vacancies";
                }
                else if(op == 3)
                {
                    ViewBag.Message = "There is already a class at that time";
                }

                if(order == "byDay")
                {
                    return View(result.OrderBy(x => x.Day.id).ToList());
                }
                else
                {
                    return View(result.OrderBy(x => x.name).ToList()); 

                }
            }
        }

        public ActionResult ListarMySubjet()
        {

            int id_Student = GetStudentId();    //obtengo id estudiante.
            Debug.WriteLine(id_Student);

            using (var db = new RegistryEntities())
            {
                int id_student = GetStudentId();    //get id estudiante
                var student_subjet = db.Student_subjet.Where(d => d.id_student == id_student).ToList();  //get lista materias anotadas.
                var subjets = db.Subjets.Include(s => s.Professor).Include(s => s.Day).ToList();    //get lista materias.

                var result = from a in subjets  //Consulta.
                             where student_subjet.Select(b => b.id_subjet).Contains(a.id)
                             select a;
                return View(result.OrderBy(x => x.name).ToList());
            }          
        }

        public ActionResult Description(int id)
        {
            
            using (var db = new RegistryEntities())
            {
                var subjets = db.Subjets.Find(id);
                return View(subjets);
            }
           
        }

        public ActionResult Anotarce(int? id)
        {
          
            using (var db = new RegistryEntities())
            {

                var subjets = db.Subjets.Find(id);  //Id materia seleccionada obtengo data materia seleccionada.
                Student_subjet student_subjet = new Student_subjet();   //Creo dato para agregar en la tabla de incripciones.
                

                if (subjets != null)
                {
                                      
                    if(!ConflictorHorarioMateria(subjets))
                    {
                        if (subjets.vacancies > 0)
                        {
                            subjets.vacancies -= 1;

                            student_subjet.id_student = GetStudentId(); //id de estudiante.
                            student_subjet.id_subjet = subjets.id;
                            db.Student_subjet.Add(student_subjet);

                            db.Entry(subjets).State = System.Data.Entity.EntityState.Modified;
                            db.SaveChanges();                         
                            ViewBag.operacion = 1;

                        }
                        else
                        {                                            
                            ViewBag.operacion = 2;
                        }
                    }
                    else
                    {
                        ViewBag.operacion = 3;                                                                 
                    }                                

                }
               
            }
            
            return RedirectToAction("OffertSubjet", "Student", new {op = ViewBag.operacion});
        }

        public ActionResult FinishSession()
        {
            Session.Abandon();
           return RedirectToAction("Index", "Login");
        }


        public int GetStudentId() {

            using (var db = new RegistryEntities())
            {
                int id_user_login = (int)Session["id_user"];
                var query = from d in db.Students
                            where d.id_user == id_user_login
                            select d;


                var student = query.FirstOrDefault<Student>();
                          
                return (student.id);
            }

        }

        public bool ConflictorHorarioMateria(Subjet materiaAInscribirce)
        {
            List<Subjet> incripciones;         
            bool conflictoHorario = false;

            using (var db = new RegistryEntities())
            {
                int id_student = GetStudentId();    //get id estudiante
                var student_subjet = db.Student_subjet.Where(d => d.id_student == id_student).ToList();  //get lista materias anotadas.
                var subjets = db.Subjets.Include(s => s.Professor).Include(s => s.Day).ToList();    //get lista materias.

                var result = from a in subjets  //Consulta.
                             where student_subjet.Select(b => b.id_subjet).Contains(a.id)
                             select a;

                incripciones = result.ToList();     //Materias incriptas del alumno.
                Debug.WriteLine(incripciones.Count());

            }
          
            var materiasMismoDia = incripciones.FindAll(incr => incr.Day.id.Equals(materiaAInscribirce.Day.id));

            if(materiasMismoDia.Count() > 0)
            {
                int i = 0;
                while(i < materiasMismoDia.Count() && !conflictoHorario)
                {
                    if(materiaAInscribirce.start_time.Hour >= materiasMismoDia[i].start_time.Hour &&
                       materiaAInscribirce.start_time.Hour < materiasMismoDia[i].end_time.Hour)
                    {
                        conflictoHorario = true;
                    }else if(materiaAInscribirce.end_time.Hour > materiasMismoDia[i].start_time.Hour &&
                             materiaAInscribirce.end_time.Hour < materiasMismoDia[i].end_time.Hour)
                    {
                        conflictoHorario = true;
                    }
                    i++;
                }
            }
            return conflictoHorario;
           
        }
    }
}