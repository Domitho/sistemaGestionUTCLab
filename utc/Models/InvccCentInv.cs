using System;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace utc.Models
{
    public class InvccCentInv
    {
        [JsonProperty("strId_cen")]
        public string strId_cen { get; set; }

        [JsonProperty("strArchivo_cen")]
        public string strArchivo_cen { get; set; }
        

        [JsonProperty("strNombre_cen")]
        public string strNombre_cen { get; set; }

        [JsonProperty("strDescripcion_cen")]
        public string strDescripcion_cen { get; set; }

        [JsonProperty("strObservacion_cen")]
        public string strObservacion_cen { get; set; }

    }
}