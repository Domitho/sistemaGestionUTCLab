using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Newtonsoft.Json;

namespace utc.Models
{
    public class InvgccDocente
    {
       
            [JsonProperty("strId_doc")]
            public string strId_doc { get; set; }

            [JsonProperty("strCedula_doc")]
            public string strCedula_doc { get; set; }

            [JsonProperty("strApellidos_doc")]
            public string strApellidos_doc { get; set; }

            [JsonProperty("strNombres_doc")]
            public string strNombres_doc { get; set; }

            [JsonProperty("strFacultad_doc")]
            public string strFacultad_doc { get; set; }

            [JsonProperty("strCarrera_doc")]
            public string strCarrera_doc { get; set; }

            [JsonProperty("strFuncion_doc")]
            public string strFuncion_doc { get; set; }
            [JsonProperty("strId_cat")]
            public string strId_cat { get; set; }

            [JsonProperty("dtFecha_cat")]   
            public DateTime dtFecha_cat { get; set; }

            [JsonProperty("strCategorizacion")]
            public string strCategorizacion { get; set; }
    }
}