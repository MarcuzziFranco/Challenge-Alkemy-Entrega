using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Registro.Models
{
    public class DataLogin
    {
        [Required(ErrorMessage = "DNI is Required.")]
        public string dm_Dni { get; set; }

        
        [Required(ErrorMessage = "Password is Required.")] 
        public string dm_Code_login { get; set; }

        public bool dm_isManager { get; set; }
    }
}