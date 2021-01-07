using Registro.Models;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Registro.Controllers
{
    public class LoginController : Controller
    {
        // GET: Login
        public ActionResult Index() 
        {
            return View();
        }

        [HttpPost]
        public ActionResult Autorization(DataLogin data) {

            ViewBag.error = "";
            if (!ModelState.IsValid)
            {
                return View("Index");
            }
            else
            {
                
                using (var db = new RegistryEntities())
                {
                    User result = db.Users.FirstOrDefault
                        (u => u.Dni.Equals(data.dm_Dni) &&
                              u.Code_login.Equals(data.dm_Code_login));

                    if (result != null){
                        if (data.dm_isManager)
                        {
                            if(result.Profile.Type == "Manager"){
                                 Debug.WriteLine("User is Manager");
                                DataUser dataUser = new DataUser();
                                dataUser.id = result.id;
                                dataUser.Name = result.Name;
                                dataUser.Last_name = result.Last_Name;
                                dataUser.Type = result.Profile.Type;
                                return RedirectToAction("Index", "Manager", dataUser);
                            }
                            else{
                                //Debug.WriteLine("User not Found");
                                ViewBag.error = "User not Found";                     
                            }
                            
                        }
                        else
                        {
                            if (result.Profile.Type == "Student"){
                                Debug.WriteLine("User is Student");
                                //Llamar aqui al cambio de pagina.
                                DataUser dataUser = new DataUser();
                                dataUser.id = result.id;
                                dataUser.Name = result.Name;
                                dataUser.Last_name = result.Last_Name;
                                dataUser.Type = result.Profile.Type;
                                return RedirectToAction("Index", "Student", dataUser); 

                            }
                            else {
                                Debug.WriteLine("User not Found");
                                ViewBag.error = "User not Found";
                            }
                        }
                    }
                    else{                
                        ViewBag.error = "User not Found";
                    }
                }
                   
            }
            
            return View("Index");//vamos a la pagina designada.
        }

       
    }
}