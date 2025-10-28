using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace utc.Models
{
    public class InvgccConvocatori
    {
        [JsonProperty("strId_conv")]
        public string strId_conv { get; set; }

        [JsonProperty("strNombre_conv")]
        
        public string strNombre_conv { get; set; }
        [JsonProperty("strArchivo_conv")]
        
        public string strArchivo_conv { get; set; }

        [JsonProperty("strDescripcion_conv")]
        public string strDescripcion_conv { get; set; }

        [JsonProperty("dtFechaini_conv")]
        public DateTime dtFechaini_conv { get; set; }

        [JsonProperty("dtFechafin_conv")]
        public DateTime dtFechafin_conv { get; set; }
    }
}