using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Newtonsoft.Json;

namespace utc.Models
{
    public class InvgccInsPro
    {
        [JsonProperty("strId_pro")]
        public string strId_pro { get; set; }

        [JsonProperty("strTema_pro")]
        public string strTema_pro { get; set; }

        [JsonProperty("strDuracion_pro")]
        public string strDuracion_pro { get; set; }

        [JsonProperty("dtFehains_pro")]
        public DateTime dtFehains_pro { get; set; }

        [JsonProperty("strArchivo_pro")]
        public string strArchivo_pro { get; set; }

        [JsonProperty("strEstado_pro")]
        public string strEstado_pro { get; set; }

        [JsonProperty("fkId_conv")]
        public string fkId_conv { get; set; }

        [JsonProperty("fkId_gru")]
        public string fkId_gru { get; set; }

        [JsonProperty("strNombre_gru")]
        public string strNombre_gru { get; set; }

        [JsonProperty("strNombre_conv")]
        public string strNombre_conv { get; set; }

       

    }
}