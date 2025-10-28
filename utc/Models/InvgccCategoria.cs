using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Newtonsoft.Json;

namespace utc.Models
{
    public class InvgccCategoria
    {
        [JsonProperty("strId_cat")]
        public string strId_cat { get; set; }

        [JsonProperty("strCategorizacion")]
        public string strCategorizacion { get; set; }

        [JsonProperty("fkId_doc")]
        public string fkId_doc { get; set; }

        [JsonProperty("dtFecha_cat")]
        public DateTime dtFecha_cat { get; set; }

        [JsonProperty("strEstado_cat")]
        public string str_Estado_cat { get; set; }

    

    }
}