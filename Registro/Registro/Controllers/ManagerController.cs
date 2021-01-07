using Registro.Models;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Registro.Controllers
{
    public class ManagerController : Controller
    {
        // GET: Manager

         
        public ActionResult Index(DataUser dataUser) 
        {
            if(Session["id_user"] == null)
            {
                Session["id_user"] = dataUser.id;
                Session["name_user"] = dataUser.Name;
                Session["last_name"] = dataUser.Last_name;
                Session["type_user"] = dataUser.Type;

            }

            
            if ((String)Session["type_user"] == "Manager")
            {
                Debug.WriteLine("Valido");
                ViewBag.name = Session["name_user"];
                ViewBag.lastName = Session["last_name"];

                Debug.WriteLine("paso por aca");
                return View(dataUser);
            }
            else
            {
                FinishSession(); 
                Debug.WriteLine("No valido");
                return RedirectToAction("Index", "Login");
            }

        }

        public ActionResult FinishSession()
        {
            Session.Abandon();
            return RedirectToAction("Index", "Login"); 
        }

       


    }
}